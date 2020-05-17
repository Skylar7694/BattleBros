package;

import Player;
import Enemy;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

using flixel.util.FlxSpriteUtil;
class PlayersChoice extends Player
{
    
    // var combatBackground:FlxSprite;
    // var healthTrack:FlxSprite;
    // var countHealth:FlxText;
    // var text:FlxText;
    // var choice:Array<String> = ["Fight", "Defend", "Heal", "Flee"];
    // creates the battle sequence
       
  public function new() 
  { 
  
    super();
    
    
    //healthTrack = new FlxText(16, 2, 0, "3 / 3", 8);
    //healthTrack.setBorderStyle(SHADOW, FlxColor.BLACK, 1, 1);
/*
    while (pHealth>0 ){
        for(val in choice){
            combatBackground = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.GRAY);
            combatBackground.drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);
        }   
        */
    }
   
    /*
    while(playersturn==1){
        //choose option by opening the option menu 
        if(choice==0){
            //do damage
            return playersTurn=0;
        }
        else if(choice==1){
            // reduce damage
            return playersTurn=0;
        }
        else if(choice==2){
            // increase health
            return playersTurn=0;
        }else{
            //end game
            var text:FlxText;
            text= new FlxText(0, 0, 0,"You have fled and are a coward... Game Over", 32);
            text.setFormat(null,32,FlxColor.RED,FlxTextAlign.CENTER);
            add(text);
        }
    }

    While(PlayerTurn!=1){
        // choose rand int for enemy
        if(option==0){
            //fight
            return playersTurn=1;
        }
        else if(option=1){
            //defend
            return playersTurn=1;
        }
        else{
            // heal
            return playersTurn=1;
        }*/
    }
    
  
