package;

import flixel.FlxState;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	var gameWidth:Int = 960;
	var gameHeight:Int = 640; 
	var initialState:Class<FlxState> = PlayState; 

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
