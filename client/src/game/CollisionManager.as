package game
{
	import avtr.Avatar;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import tiles.TileLayer;
	import tiles.TileMap;
	
	public class CollisionManager extends EventDispatcher
	{
		
		private var floors:Array = [];
		private var bricks:Array = [];
		private var pits:Array = [];
		private var goal:Object;
		//http://higherorderfun.com/blog/2012/05/20/the-guide-to-implementing-2d-platformers/
		private var currentScreen:Screens;
		private var avatar:Avatar;
		
		public function CollisionManager(screens:Screens, avatar:Avatar)
		{
			currentScreen = screens;
			this.avatar = avatar;
			for each(var s:Screen in screens.getScreens()){
				addColliders(s);
			}	
		}
		
		public function resolve():Boolean
		{
			
			if(checkFloor(avatar)) {  // true si estoy parado sobre algo...
				avatar.setIdleState();
			}
			
//			if(checkPit(avatar)) {  // true si estoy parado sobre algo...
//				//avatar.setIdleState();
//				avatar.getKilled();
//			}
//			
//			if(checkObstacles(avatar)) {  // true si estoy parado sobre algo...
//				avatar.setIdleState();
//			}

			return false;
		}
		
		private function cacheScreen(screens:Screens):void
		{
					
		}
		
		// me gusta separar los obstaculos porque cada uno tiene cualidades diferentes.
		// entonces esta bueno tratarlos por separado.
		private function addColliders(screen:Screen):void
		{
			for(var i:int = 0; i < screen.numChildren; i++){
				switch ((screen.getChildAt(i) as Obstacle).name){
					case Obstacle.FLOOR:
						floors.push(screen.getChildAt(i));
						break;
//					case Obstacle.BRICK:
//						bricks.push(screen.getChildAt(i));
//						break;									
//	
//					case Obstacle.PIT:
//						floors.push(screen.getChildAt(i));
//						break;
				}
			}		 
		}
		
		
		private function checkFloor(avatar:Avatar):Boolean
		{
			for each(var obj:Obstacle in floors){				
				if(checkTopCollition(obj, avatar)){
					obj.activate();	// lo activo...
					if(obj.kills()) avatar.getKilled();  // si el obstaculo esta en modo matar me mata...
					return true;
				}
			}			
			return false;
		}
		
		
//		private function checkPit(avatar:Avatar):Boolean
//		{
//			for each(var obj:Obstacle in pits){
//				if(checkTopCollition(obj, avatar)) return true;
//			}			
//			
//			return false;
//		}
		
		private function checkObstacles(avatar:Avatar):Boolean
		{
			for each(var obj:Obstacle in bricks){
				if(checkSideCollition(obj, avatar)) return true;
				if(checkTopCollition(obj, avatar)) return true;
			}
			return false;
		}
		
		// COLISIONES POR LADO
		// hitTestPoint solo funciona en coordenadas globales.
		// http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/DisplayObject.html#hitTestPoint()
		private function checkTopCollition(obj:Obstacle, avatar:Avatar):Boolean
		{
			var point:Point = avatar.target(Avatar.BOTTOM).localToGlobal(new Point());
			if(obj.hitTestPoint( point.x, point.y, true)){
				avatar.moveTo(avatar.position.x, obj.getBounds(currentScreen).top - avatar.target(Avatar.BOTTOM).y);
				avatar.updatePos();
				obj.debug();
				return true;
			} 			
			return false;
		}
		
		private function checkSideCollition(obj:Obstacle, avatar:Avatar):Boolean
		{
			var dir:int = avatar.facingRight() ? 1 : -1;
			var boundarie:Number;
			var newX:Number;
			var target:Point = avatar.target(Avatar.RIGHT).localToGlobal(new Point);
			if(obj.hitTestPoint(target.x, target.y)){								
				boundarie = dir == 1 ? obj.getBounds(currentScreen).left : obj.getBounds(currentScreen).right;
				newX = boundarie + (dir == 1 ? -avatar.target(Avatar.RIGHT).x : avatar.target(Avatar.RIGHT).x);
				avatar.moveTo(newX, avatar.position.y);
				avatar.updatePos();
				
				obj.debug();
				return true;
			}
			target = avatar.target(Avatar.LEFT).localToGlobal(new Point);
			if(obj.hitTestPoint(target.x, target.y)){								
				boundarie = dir == 1 ? obj.getBounds(currentScreen).right : obj.getBounds(currentScreen).left;
				newX = boundarie + (dir == 1 ? -avatar.target(Avatar.LEFT).x : avatar.target(Avatar.LEFT).x);
				avatar.moveTo(newX, avatar.position.y);
				avatar.updatePos();
				
				obj.debug();
				return true;
			}
			return false;			
		}
		
		
	}
}