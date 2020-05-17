package;

import flixel.FlxG;
import flixel.FlxSprite;
import AssetPaths;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;


class ChoiceHud extends FlxText
{   
    
    var choiceHud:ChoiceHud = new ChoiceHud();
    var choicetext:FlxText;
    var choice:Array<String> = ["Fight", "Defend", "Heal", "Flee"];
    var i =0;
  public function new() 
  {
    super();
    for(val in choice){
        while(i< choice.length){ 
            choicetext= new FlxText(0, 0, 0, choice[i], 32);
            choicetext.setFormat(null,32,FlxColor.RED);
            this.setPosition(400 + (i*10), 500+ (i*10));   
            i++;
            
    //loadGraphic(AssetPaths.hudBackground__png);
    //this.setPosition(400, 500);
            } 
        }
    }   
}   
/*
    function AddChoices(){
        for(val in choice){
            while(i< choice.lengt for(val in choice){
                while(i< choice.length){ 
                    choicetext= new FlxText(0, 0, 0, choice[i], 32);
                    choicetext.setFormat(null,32,FlxColor.RED,FlxTextAlign.CENTER);
                    this.setPosition(400 + (i*10), 500+ (i*10));   
                    i++;){ 
                choicetext= new FlxText(0, 0, 0, choice[i], 32);
                choicetext.setFormat(null,32,FlxColor.RED,FlxTextAlign.CENTER);
                this.setPosition(400 + (i*10), 500+ (i*10));   
                i++;
            }
    }
    
  }*/

