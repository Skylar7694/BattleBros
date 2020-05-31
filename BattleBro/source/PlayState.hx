package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flash.geom.Matrix;
import flash.geom.Point;
import AssetPaths;
import flixel.FlxG;
import Enemy;
import Player;
//import Choice;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.text.FlxText;

enum Choice
{
	Fight;
    Defend;
    Heal;
    Flee;
}

class PlayState extends FlxState
{
	
	var enemy:Enemy;
	var player:Player;
	private var background:FlxSprite;
	public var choices:FlxTypedGroup<FlxText>;

	override public function create()
	{
		//creates Enemy and Player objects 
		enemy = new Enemy();
		player = new Player();
		var choices:Map<Choice, FlxText>;
		
		super.create();
		//creates background and sound
		background=new FlxSprite();
		background.loadGraphic(AssetPaths.BackGround__jpg);
		FlxG.sound.playMusic(AssetPaths.game_music__mp3);

		choices = new Map();
		choices[Fight] = new FlxText(background.x + 400, background.y + 450, 100, "Fight", 20);
		choices[Defend] = new FlxText(background.x + 400, choices[Fight].y + choices[Fight].height + 8, 100, "Defend", 20);
		choices[Heal] = new FlxText(background.x + 500, background.y + 450, 100, "Heal", 20);
		choices[Flee] = new FlxText(background.x + 500, choices[Heal].y + choices[Heal].height + 8, 100, "Flee", 20);
	
			
		add(background);
		add(enemy);
		add(player);
		add(choices[Fight]);
		add(choices[Defend]);
		add(choices[Heal]);
		add(choices[Flee]);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
