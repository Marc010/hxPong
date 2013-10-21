package entities;

import com.haxepunk.graphics.Text;

/**
 * ...
 * @author Marco
 */

class Score extends Text
{
	private var score:Int = 0;

	public function new(x:Float, y:Float)
	{
		super("0", x, y);
		
		// Set display size
		set_size(55);
	}
		
	public function increase()
	{
		// Increase score by 1
		score++;
		set(score);
	}
	
	public function reset()
	{
		// Set score to 0
		set(0);
	}
	
	private inline function set(newscore:Int)
	{
		// Convert score to String and display it as text
		set_text(Std.string(newscore));
	}
}