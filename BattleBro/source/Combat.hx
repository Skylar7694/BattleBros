import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;

using flixel.util.FlxSpriteUtil;

/**
 * This enum is used to set the valid values for our outcome variable.
 * Outcome can only ever be one of these 4 values and we can check for these values easily once combat is concluded.
 */
enum Outcome
{
	NONE;
	ESCAPE;
	VICTORY;
	DEFEAT;
}

enum Choice
{
	FIGHT;
	FLEE;
}

class CombatHUD extends FlxTypedGroup<FlxSprite>
{

	public var enemy:Enemy;
	public var pHealth(default, null):Int; 
	public var outcome(default, null):Outcome; 

	// These are the sprites that we will use to show the combat hud interface
	var background:FlxSprite; 
	var pSprite:Player; 
	var eSprite:Enemy; 

	// To track the eSprite's health
	var eHealth:Int;
	var eMaxHealth:Int;
	var eHealthBar:FlxBar; 

	var pHealthCounter:FlxText; // show the pSprite's current/max health

	var damages:Array<FlxText>;

	var pointer:FlxSprite; // pointer for the fight or flee option
	var selected:Choice; // selects option
	var choices:Map<Choice, FlxText>; // shows the text Fight and Flee

	var results:FlxText; // Shows the outcome of the battle.

	var screen:FlxSprite;

	public function new()
	{
		super();

		screen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
		var waveEffect = new FlxWaveEffect(FlxWaveMode.ALL, 4, -1, 4);
		var waveSprite = new FlxEffectSprite(screen, [waveEffect]);
		add(waveSprite);

		background = new FlxSprite().makeGraphic(120, 120, FlxColor.WHITE);
		background.drawRect(1, 1, 118, 44, FlxColor.BLACK);
		background.drawRect(1, 46, 118, 73, FlxColor.BLACK);
		background.screenCenter();
		add(background);

		pSprite = new Player(background.x + 36, background.y + 16);
		pSprite.animation.frameIndex = 3;
		pSprite.active = false;
		pSprite.facing = FlxObject.RIGHT;
		add(pSprite);

		eSprite = new Enemy(background.x + 76, background.y + 16, REGULAR);
		eSprite.animation.frameIndex = 3;
		eSprite.active = false;
		eSprite.facing = FlxObject.LEFT;
		add(eSprite);

		// setup the pSprite's health display
		pHealthCounter = new FlxText(0, pSprite.y + pSprite.height + 2, 0, "3 / 3", 8);
		pHealthCounter.alignment = CENTER;
		pHealthCounter.x = pSprite.x + 4 - (pHealthCounter.width / 2);
		add(pHealthCounter);

		// create and add a FlxBar to show the eSprite's health.
		enemyHealthBar = new FlxBar(eSprite.x - 6, pHealthCounter.y, LEFT_TO_RIGHT, 20, 10);
		enemyHealthBar.createFilledBar(0xffdc143c, FlxColor.YELLOW, true, FlxColor.YELLOW);
		add(enemyHealthBar);

		// create our choices 
		choices = new Map();
		choices[FIGHT] = new FlxText(background.x + 30, background.y + 48, 85, "FIGHT", 22);
		choices[FLEE] = new FlxText(background.x + 30, choices[FIGHT].y + choices[FIGHT].height + 8, 85, "FLEE", 22);
		add(choices[FIGHT]);
		add(choices[FLEE]);

		pointer = new FlxSprite(background.x + 10, choices[FIGHT].y + (choices[FIGHT].height / 2) - 8, AssetPaths.pointer__png);
		pointer.visible = false;
		add(pointer);

		// create our damage texts. 
		damages = new Array<FlxText>();
		damages.push(new FlxText(0, 0, 40));
		damages.push(new FlxText(0, 0, 40));
		for (d in damages)
		{
			d.color = FlxColor.WHITE;
			d.setBorderStyle(SHADOW, FlxColor.RED);
			d.alignment = CENTER;
			d.visible = false;
			add(d);
		}

		// create our results text object.
		results = new FlxText(background.x + 2, background.y + 9, 116, "", 18);
		results.alignment = CENTER;
		results.color = FlxColor.YELLOW;
		results.setBorderStyle(SHADOW, FlxColor.GRAY);
		results.visible = false;
		add(results);


		forEach(function(sprite:FlxSprite)
		{
			sprite.scrollFactor.set();
			sprite.alpha = 0;
		});

		active = false;
		visible = false;

		fledSound = FlxG.sound.load(AssetPaths.fled__wav);
		hurtSound = FlxG.sound.load(AssetPaths.hurt__wav);
		loseSound = FlxG.sound.load(AssetPaths.lose__wav);
		missSound = FlxG.sound.load(AssetPaths.miss__wav);
		selectSound = FlxG.sound.load(AssetPaths.select__wav);
		winSound = FlxG.sound.load(AssetPaths.win__wav);
		combatSound = FlxG.sound.load(AssetPaths.combat__wav);
	}

	/**
	 * 
	 * @param	pHealth	
	 * @param	enemy			T
	 */
	public function initCombat(pHealth:Int, enemy:Enemy)
	{
		screen.drawFrame();
		var screenPixels = screen.framePixels;

		if (FlxG.renderBlit)
			screenPixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point());
		else
			screenPixels.draw(FlxG.camera.canvas, new Matrix(1, 0, 0, 1, 0, 0));

		var rc:Float = 1 / 3;
		var gc:Float = 1 / 2;
		var bc:Float = 1 / 6;
		screenPixels.applyFilter(screenPixels, screenPixels.rect, new Point(),
			new ColorMatrixFilter([rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, 0, 0, 0, 1, 0]));

		combatSound.play();
		this.pHealth = pHealth; 
		this.enemy = enemy; 

		updatepHealth();

		// setup our eSprite
		enemyMaxHealth = enemyHealth = if (enemy.type == REGULAR) 2 else 4; 
		enemyHealthBar.value = 100;
		eSprite.changeType(enemy.type);

		
		wait = true;
		results.text = "";
		pointer.visible = false;
		results.visible = false;
		outcome = NONE;
		selected = FIGHT;
		movePointer();

		visible = true;

		FlxTween.num(0, 1, .66, {ease: FlxEase.circOut, onComplete: finishFadeIn}, updateAlpha);
	}

	function updateAlpha(alpha:Float)
	{
		this.alpha = alpha;
		forEach(function(sprite) sprite.alpha = alpha);
	}

	function finishFadeIn(_)
	{
		active = true;
		wait = false;
		pointer.visible = true;
		selectSound.play();
	}


	function finishFadeOut(_)
	{
		active = false;
		visible = false;
	}


	function updatepHealth()
	{
		pHealthCounter.text = pHealth + " / 3";
		pHealthCounter.x = pSprite.x + 4 - (pHealthCounter.width / 2);
	}

	override public function update(elapsed:Float)
	{
		if (!wait) 
		{
			updateKeyboardInput();
			updateTouchInput();
		}
		super.update(elapsed);
	}

	function updateKeyboardInput()
	{
		#if FLX_KEYBOARD

		var up:Bool = false;
		var down:Bool = false;
		var fire:Bool = false;

		if (FlxG.keys.anyJustReleased([SPACE, X, ENTER]))
		{
			fire = true;
		}
		else if (FlxG.keys.anyJustReleased([W, UP]))
		{
			up = true;
		}
		else if (FlxG.keys.anyJustReleased([S, DOWN]))
		{
			down = true;
		}

		if (fire)
		{
			selectSound.play();
			makeChoice(); // when the pSprite chooses either option, we call this function to process their selection
		}
		else if (up || down)
		{
			// if the pSprite presses up or down, we move the cursor up or down (with wrapping)
			selected = if (selected == FIGHT) FLEE else FIGHT;
			selectSound.play();
			movePointer();
		}
		#end
	}

	function updateTouchInput()
	{
		#if FLX_TOUCH
		for (touch in FlxG.touches.justReleased())
		{
			for (choice in choices.keys())
			{
				var text = choices[choice];
				if (touch.overlaps(text))
				{
					selectSound.play();
					selected = choice;
					movePointer();
					makeChoice();
					return;
				}
			}
		}
		#end
	}

	function movePointer()
	{
		pointer.y = choices[selected].y + (choices[selected].height / 2) - 8;
	}


	function makeChoice()
	{
		pointer.visible = false; 
		switch (selected) 
		{
			case FIGHT:
                      // need to add choices so that when fight is choosen you will choose options. 
                //Spell

                //Sword

                //Axe

                //bow
                if (FlxG.random.bool(85))
                    
          
				{
					damages[1].text = "1";
					FlxTween.tween(eSprite, {x: eSprite.x + 4}, 0.1, {
						onComplete: function(_)
						{
							FlxTween.tween(eSprite, {x: eSprite.x - 4}, 0.1);
						}
					});
					hurtSound.play();
					enemyHealth--;
					enemyHealthBar.value = (enemyHealth / enemyMaxHealth) * 100; 
				}
				else
				{
					damages[1].text = "MISS!";
					missSound.play();
				}

				damages[1].x = eSprite.x + 2 - (damages[1].width / 2);
				damages[1].y = eSprite.y + 4 - (damages[1].height / 2);
				damages[1].alpha = 0;
				damages[1].visible = true;

				if (enemyHealth > 0)
				{
					enemyAttack();
				}

				FlxTween.num(damages[0].y, damages[0].y - 12, 1, {ease: FlxEase.circOut}, updateDamageY);
				FlxTween.num(0, 1, .2, {ease: FlxEase.circInOut, onComplete: doneDamageIn}, updateDamageAlpha);

			case FLEE:
				if (FlxG.random.bool(50))
				{
					outcome = ESCAPE;
					results.text = "ESCAPED!";
					fledSound.play();
					results.visible = true;
					results.alpha = 0;
					FlxTween.tween(results, {alpha: 1}, .66, {ease: FlxEase.circInOut, onComplete: doneResultsIn});
				}
				else
				{
					enemyAttack();
					FlxTween.num(damages[0].y, damages[0].y - 12, 1, {ease: FlxEase.circOut}, updateDamageY);
					FlxTween.num(0, 1, .2, {ease: FlxEase.circInOut, onComplete: doneDamageIn}, updateDamageAlpha);
				}
		}
		wait = true;
	}


	function enemyAttack()
	{

		if (FlxG.random.bool(30))
		{
			FlxG.camera.flash(FlxColor.WHITE, .2);
			FlxG.camera.shake(0.01, 0.2);
			hurtSound.play();
			damages[0].text = "1";
			pHealth--;
			updatepHealth();
		}
		else
		{
			damages[0].text = "MISS!";
			missSound.play();
		}

		
		damages[0].x = pSprite.x + 2 - (damages[0].width / 2);
		damages[0].y = pSprite.y + 4 - (damages[0].height / 2);
		damages[0].alpha = 0;
		damages[0].visible = true;
	}


	function updateDamageY(damageY:Float)
	{
		damages[0].y = damages[1].y = damageY;
	}


	function updateDamageAlpha(damageAlpha:Float)
	{
		damages[0].alpha = damages[1].alpha = damageAlpha;
	}

	function doneDamageIn(_)
	{
		FlxTween.num(1, 0, .66, {ease: FlxEase.circInOut, startDelay: 1, onComplete: doneDamageOut}, updateDamageAlpha);
	}


	function doneResultsIn(_)
	{
		FlxTween.num(1, 0, .66, {ease: FlxEase.circOut, onComplete: finishFadeOut, startDelay: 1}, updateAlpha);
	}


	function doneDamageOut(_)
	{
		damages[0].visible = false;
		damages[1].visible = false;
		damages[0].text = "";
		damages[1].text = "";

		if (pHealth <= 0)
		{
		
			outcome = DEFEAT;
			loseSound.play();
			results.text = "DEFEAT!";
			results.visible = true;
			results.alpha = 0;
			FlxTween.tween(results, {alpha: 1}, 0.66, {ease: FlxEase.circInOut, onComplete: doneResultsIn});
		}
		else if (enemyHealth <= 0)
		{
		
			outcome = VICTORY;
			winSound.play();
			results.text = "VICTORY!";
			results.visible = true;
			results.alpha = 0;
			FlxTween.tween(results, {alpha: 1}, 0.66, {ease: FlxEase.circInOut, onComplete: doneResultsIn});
		}
		else
		{
		
			wait = false;
			pointer.visible = true;
		}
	}
}