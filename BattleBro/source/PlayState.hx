package;

import AssetPaths;
import Enemy;
import Player;
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
		enemy = new Enemy();
		player = new Player();
		super.create();
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
