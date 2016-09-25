package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.Obstacle;
	

	public class WalkState extends AvatarState
	{
		private var offset:Number = 0;
		
		public function WalkState(context:Avatar)
		{
			this.context = context;
		}
		
		override public function enter():void
		{
//			logger.info("enter walk state");	
		}
		
		override public function exit():void
		{
//			logger.info("exit walk state");			
		}
		
		override public function update():void
		{	
			
			context.addController();
			context.move();
			if(!(context.left || context.rigth)) {				
				context.setIdleState();
			}
		}

	}
}