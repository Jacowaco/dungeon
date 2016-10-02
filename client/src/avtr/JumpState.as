package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.obstacles.Obstacle;
	
	public class JumpState extends FallState
	{
		public function JumpState(context:Avatar){
			super(context);
		}
		
		override public function enter():void{
			logger.info("enter jump state");			
			var jump:Vector2D = new Vector2D(context.vel.x, -context.jumpForce);		
			context.vel = context.vel.add(jump);
			context.touchingFloor = false;
		}
		
		override public function exit():void{
			logger.info("exit jump state");
			
		}
		
		override public function checkState():void 
		{
			if (context.touchingFloor)
			{
				if (context.left || context.right) context.setWalkState();
				else context.setIdleState();
			}
		}
		
		override public function update():void 
		{
			if (context.touchingFloor) context.vel = new Vector2D();
			else context.addGravity();
			context.addController();
			context.move();
		}
	}
}