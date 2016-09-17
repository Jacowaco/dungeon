package avtr
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import game.Thing;
	

	public class AvatarState
	{	
		protected var context:Avatar;
		public function enter():void{throw new Error("unninplemented")};
		public function exit():void{throw new Error("unninplemented")};
		public function update():void{throw new Error("unninplemented")};
//		public function onKeyDown(ke:KeyboardEvent):void{throw new Error("unninplemented")};
//		public function onKeyUp(ke:KeyboardEvent):void{throw new Error("unninplemented")};

		// checkCollision solo va a mirar alguna plataforma sobre la que puedo eventualmente estar parado
		// y devuelve por intermedio de testPlatform() 
		// testPlatform() debe devolver la plataforma sobre la cual me encuentro efectivamente parado o null
//		public function checkCollisions(platforms:Array):void
//		{
//			var gato:Rectangle = context.getTarget();   
//			
//			for each(var p:Thing in platforms){					
//				if(!p.active) continue;
//				var plat:Rectangle = p.getTarget();								
//				if(gato.bottom > plat.top) continue;  //
//				if(gato.left > plat.right) continue;  //
//				if(gato.right < plat.left) continue;  //  define el area solo por encima de la plataforma
//				
//				handleCollition(p);				
//			}								
//		}
		
		
		public function handleCollition(p:Thing):void
		{
			throw new Error("unninplemented");
		}
		
		// devuelve un vector de direccion segun como esten apretadas las teclas
//		public function resolveDirection():Vector2D
//		{
//			var xdir:Number = context.left ? -1 : 0 + context.rigth ? 1 : 0;			
//			var ydir:Number = context.jump ? -1 : 0; // + keys[Keyboard.DOWN] ? 1 : 0;
//			return new Vector2D(xdir, ydir);
//		}
		
		
		

	}
}