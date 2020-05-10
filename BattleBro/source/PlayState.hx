package;

import AssetPaths;
import Enemy;
import Player;
//import Choice;
import ChoiceHud;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxState;

class PlayState extends FlxState
{
	var enemy:Enemy;
	var player:Player;
	var hud:ChoiceHud;
	//var choice:PlayersChoice;
	private var background:FlxSprite;

	override public function create()
	{
		//creates Enemy and Player objects 
		enemy = new Enemy();
		player = new Player();
		hud = new ChoiceHud();
		//choiceTxt = new ChoiceHud();
	//	choice = new PlayersChoice();

		super.create();
		//creates background 
		background=new FlxSprite();
		background.loadGraphic(AssetPaths.BackGround__jpg);
	

		add(background);
		add(enemy);
		add(player);
		add(hud);
		//add(choiceTxt);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
