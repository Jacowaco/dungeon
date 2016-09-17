package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import game.Thing;
	
	
	
	public class FallState extends AvatarState
	{
		public function FallState(context:Avatar){
			this.context = context;
		}
		
		override public function enter():void{
			logger.info("enter fall state");			
		}
		
		override public function exit():void{
			logger.info("exit fall state");
		}
		
		// fall state solo lo hace caer
		override public function update():void{						
			context.addGravity();
			context.addController();
			context.move();
		}
	}
}