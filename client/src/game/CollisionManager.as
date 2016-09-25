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
		
		
		public function CollisionManager(screen:Screen)
		{
			addColliders(screen);
		}
		
		private function addColliders(screen:Screen):void
		{
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
		
		
		public function checkFloor(avatar:Avatar):Boolean
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
		
		public function checkObstacles(avatar:Avatar):Boolean
		{
			for each(var obj:Obstacle in obstacle){
				if(checkSideCollition(obj, avatar)) return true;
				if(checkTopCollition(obj, avatar)) return true;
			}
			return false;
		}
		
		private function checkSideCollition(obj:Obstacle, avatar:Avatar):Boolean
		{
			var dir:int = avatar.facingRight() ? 1 : -1  ;			
			var target:Point = avatar.target(Avatar.RIGHT).localToGlobal(new Point);// avatar.target(dir ? Avatar.RIGHT : Avatar.LEFT).localToGlobal(new Point);  siempre es right			
			if(obj.hitTestPoint(target.x, target.y)){		
				var collider:Number = dir == 1 ? obj.getBounds(obj).left : obj.getBounds(obj).right;
				avatar.moveBy(collider - target.x, 0);  
				obj.debug();
				return true;
			}
			return false;
				
		}
		
		public function checkGoal(avatar:Avatar){
			var target:Point = avatar.target(Avatar.BOTTOM).localToGlobal(new Point);// avatar.target(dir ? Avatar.RIGHT : Avatar.LEFT).localToGlobal(new Point);  siempre es right			
			if(goal.hitTestPoint(target.x, target.y)){	
				trace("goal");
				return true;
			}
			return false;
		}
		
	}
}