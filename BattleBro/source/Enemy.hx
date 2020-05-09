package;

import flixel.FlxSprite;
import AssetPaths;
import flixel.FlxState;

class Enemy extends FlxSprite
{
    //set up enemy variables
    private var enHealth:Int=100;
    private var attack:Int=10;
    private var defend:Int=-10;
    private var heal:Int=20;

    
  public function new() 
  {
    super();
    loadGraphic(AssetPaths.enemy__png);
    this.setPosition(625, 75);

  }

}