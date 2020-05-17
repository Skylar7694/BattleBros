package;

import flixel.group.FlxGroup.FlxTypedGroup;
import AssetPaths;
import flixel.FlxG;
import Enemy;
import Player;
//import Choice;
import ChoiceHud;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	
	var enemy:Enemy;
	var player:Player;
	var choiceHud:ChoiceHud;
	//var choice:PlayersChoice;
	private var background:FlxSprite;

	public var choices:FlxTypedGroup<FlxText>;

	override public function create()
	{
		//creates Enemy and Player objects 
		enemy = new Enemy();
		player = new Player();
		choiceHud = new ChoiceHud();
		//choiceTxt = new ChoiceHud();
	//	choice = new PlayersChoice();
		
		super.create();
		//creates background and sound
		background=new FlxSprite();
		background.loadGraphic(AssetPaths.BackGround__jpg);
		FlxG.sound.playMusic(AssetPaths.game_music__mp3);

		add(background);
		add(enemy);
		add(player);
		//add(choice);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
