package;

import Choice;
import flixel.FlxSprite;
import AssetPaths;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

enum BattleState{Start; PlayerTurn; EnemyTurn; Won; Lost;}

    public GameObject player;
    public GameObject Enemy;
class BattleSequence extends PlayersChoice{

    void Start(){
        state =BattleState.START;
        SetupBattle();
    }

    void SetupBattle(){

    }
}