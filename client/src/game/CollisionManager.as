package game
{
	import avtr.Avatar;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import tiles.TileLayer;
	import tiles.TileMap;
	
	public class CollisionManager
	{
		
		private var floor:Array = [];
		private var obstacle:Array = [];
		private var goal:Object;
		//http://higherorderfun.com/blog/2012/05/20/the-guide-to-implementing-2d-platformers/
		private var currentScreen:Screen;
		
		public function CollisionManager(screen:Screens)
		{
			
		}
		
		public function resolve(screen:Screen, avatar:Avatar):Boolean
		{
			if (currentScreen != screen){
				cacheScreen(screen);
				currentScreen = screen;
			}
			
			if(checkFloor(avatar)) {  // true si estoy parado sobre algo...
				avatar.setIdleState();
			}
			
			if(checkObstacles(avatar)) {  // true si estoy parado sobre algo...
				avatar.setIdleState();
			}
//			
			
			return false;
		}
		
		private function cacheScreen(screen:Screen):void
		{
			addColliders(screen);
		}
		
		private function addColliders(screen:Screen):void
		{
			logger.info("caching screen: ", screen);
			for(var i:int = 0; i < screen.numChildren; i++){
				switch ((screen.getChildAt(i) as Obstacle).name){
					case "floor":
						floor.push(screen.getChildAt(i));
						break;
					case "obstacle":
						obstacle.push(screen.getChildAt(i));
						break;				
					
					case "goal":
						goal = screen.getChildAt(i);
						break;										
				}
			}		 
		}
		
		private function checkObstacles(avatar:Avatar):Boolean
		{
			for each(var obj:Obstacle in obstacle){
				if(checkSideCollition(obj, avatar)) return true;
				if(checkTopCollition(obj, avatar)) return true;
			}
			return false;
		}
		
		

		
		
		private function checkFloor(avatar:Avatar):Boolean
		{
			for each(var obj:Obstacle in floor){
				if(checkTopCollition(obj, avatar)) return true;
			}
			
			return false;
		}
		
		
		private function checkTopCollition(obj:Obstacle, avatar:Avatar):Boolean
		{
			var point:Point = avatar.target(Avatar.BOTTOM).localToGlobal(new Point());
			if(obj.hitTestPoint( point.x, point.y, true)){						
				avatar.moveBy(0, obj.getBounds(obj.stage).top - avatar.target(Avatar.BOTTOM).localToGlobal(new Point).y);  // fuerzo a que el gato se pare en la plataforma
				avatar.move();
				obj.debug();
				return true;
			} 
			
			return false;
		}
		
		
		
		private function checkSideCollition(obj:Obstacle, avatar:Avatar):Boolean
		{
			var dir:int = avatar.facingRight() ? 1 : -1  ;			
			var target:Point = avatar.target(Avatar.RIGHT).localToGlobal(new Point);// avatar.target(dir ? Avatar.RIGHT : Avatar.LEFT).localToGlobal(new Point);  siempre es right
//			var target:Point = new Point(avatar.target(Avatar.RIGHT).x,avatar.target(Avatar.RIGHT).y); // localToGlobal(new Point);
			if(obj.hitTestPoint(target.x, target.y)){		
				var boundarie:Number = dir == 1 ? obj.getBounds(obj).left : obj.getBounds(obj).right;
				var global:Point = obj.localToGlobal(new Point(boundarie,0));
				avatar.moveBy(global.x - target.x, 0);  
				obj.debug();
				return true;
			}
			return false;
			
		}
		
		private function checkGoal(avatar:Avatar){
			var target:Point = avatar.target(Avatar.BOTTOM).localToGlobal(new Point);// avatar.target(dir ? Avatar.RIGHT : Avatar.LEFT).localToGlobal(new Point);  siempre es right			
			if(goal.hitTestPoint(target.x, target.y)){	
				trace("goal");
				return true;
			}
			return false;
		}
		
	}
}