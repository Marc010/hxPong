package entities;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.masks.Circle;
import com.haxepunk.math.Vector;

/**
 * ...
 * @author Marco
 */

class Ball extends Entity
{
	public var radius:Int = 15;
	
	private var velocity:Vector;
	private var speedIncrease:Float;
	private var maxSpeed:Float;
	private var emitter:Emitter;
	
	private var collidedLeft:Bool;
	private var collidedRight:Bool;
	
	public function new(x:Float, y:Float, velocity:Vector) 
	{
		super(x, y);
		
		this.x = x;
		this.y = y;
		this.velocity = velocity;
		
		maxSpeed = 14;
		speedIncrease = 1.1;
		
		graphic = Image.createCircle(radius);
		
		type = "ball";
		set_mask(new Circle(radius));
		
		// Set up emitter
		emitter = new Emitter(Image.createCircle(4));
		emitter.newType("fire");
		emitter.setColor("fire", 0xF2800D, 0xF5C70A);
	}
	
	public override function update()
	{
		handleCollisions();
		move();
		emitter.emitInCircle("fire", centerX, centerY, radius);
		super.update();
	}
	
	public function setPos(x:Float, y:Float)
	{
		// Sets the positon of the Ball
		this.x = x;
		this.y = y;
	}
	
	public function setSpeed(velocity:Vector)
	{
		// Sets the velocity of the Ball
		this.velocity.x = velocity.x;
		this.velocity.y = velocity.y;
	}
	
	public function hasCollidedLeft():Bool
	{
		// Returns if the Ball collided with the left side since last time called
		if (collidedLeft)
		{
			collidedLeft = false;
			return true;
		}
		
		return false;
	}
	
	public function hasCollidedRight():Bool
	{
		// Returns if the Ball collided with the right side since last time called
		if (collidedRight)
		{
			collidedRight = false;
			return true;
		}
		
		return false;
	}
	
	private inline function handleCollisions()
	{
		// Check if the Ball collided with a racket
		var collidedRacket = collide("racket", x, y);
		
		if (collidedRacket != null) 
		{
			/*
			 * Bounces back and sets balls top position below the
			 * Rackets bottom position
			 * if collided against Racket from below
			 */
			if (top > collidedRacket.bottom)
			{
				velocity.y *= -1;
				y = collidedRacket.bottom + 2 * radius;
			}
			/*
			 * Bounces back and sets balls bottom position below the
			 * Rackets top position
			 * if collided against Racket from above
			 */
			else if (bottom < collidedRacket.top)
			{
				velocity.y *= -1;
				y = collidedRacket.top - 2 * radius;
			}
			// If collided against Racket from left/right
			// bounce back and increase speed of ball
			else
			{
				velocity.x *= -1;
				
				if  (getSpeed(velocity) < maxSpeed)
				{
					velocity.x *= speedIncrease;
					velocity.y *= speedIncrease;
				}
			}
		}
		// If not collided against Racket
		else
		{
			// check if collided against left bounds
			if (left < 0)
			{
				collidedLeft = true;
			}
			// or else against right Wall
			else if (right > HXP.width)
			{
				collidedRight = true;
			}
			// Bounce back if collided against top or bottom bounds
			if (top < 0)
			{
				velocity.y *= -1;
				y = 0;
			}
			else if (bottom > HXP.height)
			{
				velocity.y *= -1;
				y = HXP.height - (2 * radius);
			}
		}

	}
	
	private inline function move() 
	{
		// Move the ball, called every frame
		x += velocity.x;
		y += velocity.y;
	}
	
	private inline function getSpeed(velocity:Vector):Float
	{
		// Returns the speed of the ball as float
		return Math.abs(velocity.x) + Math.abs(velocity.y);
	}
	
}
