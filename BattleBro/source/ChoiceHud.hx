package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;


enum Choice
{
	Fight;
    Defend;
    Heal;
    Flee;
}
class ChoiceHud extends FlxTypedGroup<FlxSprite>
{   
    var background:FlxSprite;
    var choiceHud:ChoiceHud = new ChoiceHud();
    var choicetext:FlxText;
    var choices:Map<Choice, FlxText>;
    var i =0;
    var screen:FlxSprite;
  public function new() 
  {
    super();

    //screen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);

    //background = new FlxSprite().makeGraphic(120, 120, FlxColor.WHITE);
	//background.drawRect(1, 1, 118, 44, FlxColor.BLACK);
	//background.drawRect(1, 46, 118, 73, FlxColor.BLACK);
	background.screenCenter();
    add(background);

    choices = new Map();
    choices[Fight] = new FlxText(background.x + 30, background.y + 48, 85, "Fight", 22);
    choices[Defend] = new FlxText(background.x + 30, choices[Fight].y + choices[Fight].height + 8, 85, "Defend", 22);
    choices[Heal] = new FlxText(background.x + 30, choices[Defend].y + choices[Defend].height + 8, 85, "Heal", 22);
    choices[Flee] = new FlxText(background.x + 30, choices[Heal].y + choices[Heal].height + 8, 85, "Flee", 22);
    add(choices[Fight]);
    add(choices[Defend]);
    add(choices[Heal]);
    add(choices[Flee]);
    
    
    //for(val in choice){
    /*while(i< choice.length)
    { 
        choicetext= new FlxText(0, 0, 0, choice[i], 32);
        choicetext.setFormat(null,32,FlxColor.RED);
        this.setPosition(400 + (i*10), 500+ (i*10));   
        i++;
        
       
    } 
    //loadGraphic(AssetPaths.hudBackground__png);
    //this.setPosition(400, 500);
       // }*/
   }   
}   
