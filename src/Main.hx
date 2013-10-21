import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import scenes.MainScene;

class Main extends Engine
{

	override public function init()
	{
		#if debug
		HXP.console.enable();
		#end
		
		HXP.scene = new MainScene();
		
		// Define global inputs
		Input.define("pause", [Key.P]);
	}

	public static function main() { new Main(); }
	
	public override function update()
	{
		handleInput();
		super.update();
	}
	
	public override function focusLost()
	{
		// If the game lost focus, pause the game
		HXP.engine.paused = true;
	}
	
	public override function focusGained()
	{
		// If the game gained focus, resume the game
		HXP.engine.paused = false;
	}
	
	private inline function handleInput()
	{
		// Pause/Resume the game if player pressed P key
		if (Input.check("pause"))
		{
			if (HXP.engine.paused == false)
			{
				HXP.engine.paused = true;
			}
			else { HXP.engine.paused = false; }
		}
	}
	
}
