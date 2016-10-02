package game
{
	import avtr.Avatar;
	import game.obstacles.Obstacle;
	
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
		private var walls:Array = [];
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
		
		public function resolve():void
		{
			if (avatar.isDead()) return;
			
			if(checkFloor(avatar)) {  // true si estoy parado sobre algo...
				avatar.touchingFloor = true;
			}
			else {
				avatar.touchingFloor = false;
			}
			
			
//			if(checkPit(avatar)) {  // true si estoy parado sobre algo...
//				//avatar.setIdleState();
//				avatar.getKilled();
//			}
//			
			if(checkWalls(avatar)) {  // true si estoy parado sobre algo...
				//avatar.setIdleState();
			}
		}
		
		private function cacheScreen(screens:Screens):void
		{
					
		}
		
		// me gusta separar los obstaculos porque cada uno tiene cualidades diferentes.
		// entonces esta bueno tratarlos por separado.
		private function addColliders(screen:Screen):void
		{
			for (var i:int = 0; i < screen.numChildren; i++) {
				var tempObs:Obstacle = (screen.getChildAt(i) as Obstacle);
				switch (tempObs.name){
					case Obstacle.FLOOR:
						floors.push(tempObs);
						break;
					case Obstacle.BRICK:
						floors.push(tempObs);
						walls.push(tempObs);
						break;
					case Obstacle.PIT:
						floors.push(tempObs);
						break;
					case Obstacle.TRICK_FLOOR:
						floors.push(tempObs);
						break;
					case Obstacle.ZOMBIE:
						floors.push(tempObs);
						break;
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
		
		private function checkWalls(avatar:Avatar):Boolean
		{
			for each(var obj:Obstacle in walls){
				if(checkSideCollition(obj, avatar)) return false;
				//if(checkTopCollition(obj, avatar)) return true;
			}
			return false;
		}
		
		// COLISIONES POR LADO
		// hitTestPoint solo funciona en coordenadas globales.
		// http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/DisplayObject.html#hitTestPoint()
		private function checkTopCollition(obj:Obstacle, avatar:Avatar):Boolean
		{
			//var point:Point = avatar.target(Avatar.BOTTOM).localToGlobal(new Point());
			var box:MovieClip = obj.asset.getChildByName("box") as MovieClip;
			//if(box.hitTestPoint( point.x, point.y, true)){
			if(box.hitTestObject(avatar.target(Avatar.BOTTOM))){
				avatar.moveTo(avatar.position.x, box.getBounds(currentScreen).top - avatar.target(Avatar.BOTTOM).y);
				avatar.updatePos();
				//obj.debug();
				return true;
			} 			
			return false;
		}
		
		private function checkSideCollition(obj:Obstacle, avatar:Avatar):Boolean
		{
			var dir:int = avatar.facingRight() ? 1 : -1;
			var boundarie:Number;
			var newX:Number;
			//var target:Point = avatar.target(Avatar.RIGHT).localToGlobal(new Point);
			var box:MovieClip = obj.asset.getChildByName("box") as MovieClip;
			//if(box.hitTestPoint(target.x, target.y)){								
			if(box.hitTestObject(avatar.target(Avatar.RIGHT))){								
				boundarie = dir == 1 ? box.getBounds(currentScreen).left : box.getBounds(currentScreen).right;
				newX = boundarie + (dir == 1 ? -avatar.target(Avatar.RIGHT).x : avatar.target(Avatar.RIGHT).x);
				avatar.moveTo(newX, avatar.position.y);
				avatar.updatePos();
				
				//obj.debug();
				return true;
			}
			//target = avatar.target(Avatar.LEFT).localToGlobal(new Point);
			//if(box.hitTestPoint(target.x, target.y)){								
			if(box.hitTestObject(avatar.target(Avatar.LEFT))){								
				boundarie = dir == 1 ? box.getBounds(currentScreen).right : box.getBounds(currentScreen).left;
				newX = boundarie + (dir == 1 ? -avatar.target(Avatar.LEFT).x : avatar.target(Avatar.LEFT).x);
				avatar.moveTo(newX, avatar.position.y);
				avatar.updatePos();
				
				//obj.debug();
				return true;
			}
			return false;			
		}
		
		
	}
}