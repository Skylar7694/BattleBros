package;

import flixel.FlxSprite;
import AssetPaths;
import flixel.FlxState;

class Player extends FlxSprite
{
    //set up Player variables
     var pHealth:Int=300;
     var attack:Int=30;
     var defend:Int=-30;
     var heal:Int=50;

    
  public function new() 
  {
    super();
    loadGraphic(AssetPaths.Player__jpg);
    this.setPosition(50, 340);

  }

}