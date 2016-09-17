package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	
	import game.Thing;
	
	
	public class IdleState extends AvatarState
	{		
//		var platform:Thing;
		
		public function IdleState(context:Avatar){
			this.context = context;
		}
	
		override public function enter():void
		{
//			logger.info("enter idle state");
//			platform = context.platform;
//			logger.info("platform: ", platform);
			offset = context.contact.pos.x - context.position.x;		
			trace(offset);
		}
		
		override public function exit():void{
//			logger.info("exit idle state");
		}
		
		var offset:Number = 0;
		
		override public function update(keys:Object):void
		{
			context.moveTo(context.contact.pos.x - offset, context.position.y);		
			if(resolveDirection(keys).x != 0) context.walk();
		}
		
		override public function onKeyDown(ke:KeyboardEvent):void
		{
			if(ke.keyCode == Keyboard.SPACE) {
				context.jump();
				return;
			}
			
//			if(ke.keyCode == Keyboard.LEFT || ke.keyCode == Keyboard.RIGHT){
//				context.walk();	
//			}
		}
		
		override public function onKeyUp(ke:KeyboardEvent):void{
			
		}
		
		override public function handleCollition(p:Thing):void
		{
			
//			trace(p == platform, p.isOn());			
			if(p == context.contact && !p.isOn()){				
				context.fall();
				p.active = false;
			}
		}
	}
}