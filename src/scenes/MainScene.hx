package scenes;

import com.haxepunk.graphics.prototype.Rect;
import com.haxepunk.HXP;
import com.haxepunk.math.Vector;
import com.haxepunk.Scene;
import entities.Ball;
import entities.Racket;
import entities.Score;
import scenes.MainScene.Side;

/**
 * ...
 * @author Marco
 */

enum Side { LEFT; RIGHT; }

class MainScene extends Scene
{	
	private var leftRacket:Racket;
	private var rightRacket:Racket;
	private var leftScore:Score;
	private var rightScore:Score;
	private var ball:Ball;
	
	private var sideOffset:Int = 35;
	private var textOffset:Int = 55;
	private var startBallSpeed:Vector;
	
	public override function begin()
	{
		var rect:Rect = new Rect(10, 80, 0xFFA477);
		startBallSpeed = new Vector(4, 1);
		
		leftRacket = new Racket(sideOffset, HXP.halfHeight, rect, true);
		rightRacket = new Racket(HXP.width - rect.width - sideOffset,
								 HXP.halfHeight, rect);
		add(leftRacket);
		add(rightRacket);
		
		leftScore = new Score(HXP.halfWidth - textOffset, HXP.height * 0.15);
		rightScore = new Score(HXP.halfWidth + textOffset, HXP.height * 0.15);
		addGraphic(leftScore);
		addGraphic(rightScore);
		
		ball = new Ball(50, HXP.halfHeight, startBallSpeed);
		add(ball);
		
		// Set the right racket to follow the ball
		rightRacket.follow(ball);
	}
	
	public override function update()
	{
		handleScore();
		super.update();
		
		trace(startBallSpeed);
	}
	
	private inline function handleScore()
	{
		// If ball collided with left/right bounds,
		// increase score on opposite site and reset Ball
		if (ball.hasCollidedLeft())
		{
			rightScore.increase();
			resetBall(RIGHT);
		}
			
		if (ball.hasCollidedRight())
		{
			leftScore.increase();
			resetBall(LEFT);
		}
	}
	
	private inline function resetBall(side:Side)
	{
		ball.setPos(HXP.halfWidth, HXP.height * 0.30);
		
		if (side == LEFT)
		{
			ball.setSpeed(new Vector(startBallSpeed.x * -1, startBallSpeed.y));
		}
		
		if (side == RIGHT)
		{
			ball.setSpeed(startBallSpeed);
		}

	}
}
