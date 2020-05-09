package;

import Player;
import Enemy;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.util.FlxColor;

class Combat extends PlayState
{
    var pHealth=100;
    //creates the battle sequence
    public function playersTurn(){
        while (pHealth>0){
            var choice=new Array<Fight,Defend,Heal,Flee>();
            var textBox:FlxText;
            textBox= new FlxText(choice);
            textBox.setFormat(null,32,FlxColor.RED);
            return choice;
        }
    }
   
  public function new() 
  {
    var pHealth = new Player();
    super();
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
    
  }

}