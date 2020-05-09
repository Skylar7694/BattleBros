package;

import flixel.FlxSprite;
import AssetPaths;
import flixel.FlxState;

class Player extends FlxSprite
{
    //set up enemy variables
    private var pHealth:Int=300;
    private var attack:Int=30;
    private var defend:Int=-30;
    private var heal:Int=50;

    
  public function new() 
  {
    super();
    loadGraphic(AssetPaths.Player__jpg);
    this.setPosition(50, 340);

  }

}