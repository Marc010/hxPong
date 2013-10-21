package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.prototype.Rect;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import scenes.MainScene;

/**
 * ...
 * @author Marco
 */

class Racket extends Entity
{
	private var speed:Float;
	private var controllable:Bool;
	private var trackedEntity:Entity;

	public function new(x:Float, y:Float, rect:Rect, controllable:Bool=false) 
	{	
		super(x, y, rect);
		
		this.controllable = controllable;
		speed = 8;
			
		type = "racket";
		setHitbox(rect.width, rect.height);
		
		// Define Keys if ball is controlled by player
		if (controllable)
		{
			Input.define("up", [Key.UP, Key.W]);
			Input.define("down", [Key.DOWN, Key.S]);
		}
	}
	
	public override function update()
	{
		move();
		super.update();
	}
	
	public function follow(entity:Entity)
	{
		// Set racket to follow a entity on the x axis
		this.trackedEntity = entity;
	}
	
	private inline function move()
	{
		// If the racket is controlled by player check for inputs,
		// change speed and check for collisions with the top/bottom bounds
		if (controllable)
		{
			if (Input.check("up"))
			{
				y -= speed;
				handleCollisionsTop();
			}
			if (Input.check("down"))
			{
				y += speed;
				handleCollisionsBottom();
			}
		}
		// If the racket is not controlled by player and has a entity to follow
		// move towards that entity on the x axis
		// Afterwards check for collisions with top/bottom bounds
		else if (trackedEntity != null)
		{
			moveTowards(x, trackedEntity.y, speed);
			handleCollisionsTop();
			handleCollisionsBottom();
		}
		
	}
	
	private inline function handleCollisionsTop()
	{
		// If the racket is above the bounds
		// set rackets top position to the top of the bounds
		if (y < 0) { y = 0; }
	}
	
	private inline function handleCollisionsBottom()
	{
		// If the racket is below the bounds
		// set rackets bottom position to the bottom of the bounds
		if (y > HXP.height - height) { y = HXP.height - height; }
	}
	
}
