package;

import AssetPaths;
import Enemy;
import Player;
import CombatSequence;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxState;

class PlayState extends FlxState
{
	var enemy:Enemy;
	var player:Player;
	private var background:FlxSprite;

	override public function create()
	{
		//creates Enemy and Player objects 
		enemy = new Enemy();
		player = new Player();
		combat = new CombatSequence();

		super.create();
		//creates background 
		background=new FlxSprite();
		background.loadGraphic(AssetPaths.BackGround__jpg);
	

		add(background);
		add(enemy);
		add(player);

	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
