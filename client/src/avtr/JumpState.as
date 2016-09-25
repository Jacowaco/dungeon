package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.Obstacle;
	
	public class JumpState extends FallState
	{
		
		public function JumpState(context:Avatar){
			super(context);
		}
		
		override public function enter():void{
			logger.info("enter jump state");			
			var jump:Vector2D = new Vector2D(context.vel.x, -context.jumpForce);		
			context.vel = context.vel.add(jump);			
		}
		
		override public function exit():void{
			logger.info("exit jump state");
			
		}		
	}
}