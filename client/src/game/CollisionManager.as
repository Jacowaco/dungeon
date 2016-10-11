package game
{
	import avtr.Avatar;
	import game.obstacles.Hook;
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
		private var hooks:Array = [];
		private var monsters:Array = [];
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
			
			if(checkFloor()) {  // true si estoy parado sobre algo...
				avatar.touchingFloor = true;
			}
			else {
				avatar.touchingFloor = false;
			}
			
			checkWalls();
			checkHooks();
			checkMonsters();
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
					case Obstacle.HOOK:
						hooks.push(tempObs);
						break;
					case Obstacle.BAT:
						monsters.push(tempObs);
						break;
				}
			}		 
		}
		
		
		private function checkFloor():Boolean
		{
			for each(var obj:Obstacle in floors){				
				if(checkTopCollition(obj)){
					obj.activate();	// lo activo...
					if(obj.kills()) avatar.getKilled();  // si el obstaculo esta en modo matar me mata...
					return true;
				}
			}			
			return false;
		}
		
		private function checkWalls():Boolean
		{
			for each(var obj:Obstacle in walls){
				if(checkSideCollition(obj)) return false;
			}
			return false;
		}
		
		// COLISIONES POR LADO
		// hitTestPoint solo funciona en coordenadas globales.
		// http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/DisplayObject.html#hitTestPoint()
		private function checkTopCollition(obj:Obstacle):Boolean
		{
			var box:MovieClip = obj.asset.getChildByName("box") as MovieClip;
			if(box.hitTestObject(avatar.target(Avatar.BOTTOM))){
				avatar.moveTo(avatar.position.x, box.getBounds(currentScreen).top - avatar.target(Avatar.BOTTOM).y);
				avatar.revertPosition();
				return true;
			} 			
			return false;
		}
		
		private function checkSideCollition(obj:Obstacle):Boolean
		{
			var dir:int = avatar.isFacingRight() ? 1 : -1;
			var boundarie:Number;
			var newX:Number;
			var box:MovieClip = obj.asset.getChildByName("box") as MovieClip;
			if(box.hitTestObject(avatar.target(Avatar.RIGHT))){								
				boundarie = dir == 1 ? box.getBounds(currentScreen).left : box.getBounds(currentScreen).right;
				newX = boundarie + (dir == 1 ? -avatar.target(Avatar.RIGHT).x : avatar.target(Avatar.RIGHT).x);
				avatar.moveTo(newX, avatar.position.y);
				avatar.revertPosition();
				return true;
			}
			if(box.hitTestObject(avatar.target(Avatar.LEFT))){								
				boundarie = dir == 1 ? box.getBounds(currentScreen).right : box.getBounds(currentScreen).left;
				newX = boundarie + (dir == 1 ? -avatar.target(Avatar.LEFT).x : avatar.target(Avatar.LEFT).x);
				avatar.moveTo(newX, avatar.position.y);
				avatar.revertPosition();
				return true;
			}
			return false;			
		}
		
		
		private function checkHooks():Boolean
		{
			for each(var obj:Obstacle in hooks){
				if(checkHookCollition(obj)) return false;
			}
			return false;
		}
		
		private function checkHookCollition(obj:Obstacle):Boolean
		{
			var box:MovieClip = obj.asset.getChildByName("box") as MovieClip;
			if (box.hitTestObject(avatar.target(Avatar.BODY))) {
				avatar.hookTo(obj as Hook);
				return true;
			}
			return false;
		}
		
		private function checkMonsters():Boolean
		{
			for each(var obj:Obstacle in monsters){
				if(checkMonsterCollition(obj)) return false;
			}
			return false;
		}
		
		private function checkMonsterCollition(obj:Obstacle):Boolean
		{
			var box:MovieClip = obj.asset.getChildByName("box") as MovieClip;
			if (box.hitTestObject(avatar.target(Avatar.BODY))) {
				obj.activate();	// lo activo...
				if(obj.kills()) avatar.getKilled();  // si el obstaculo esta en modo matar me mata...
				return true;
			}
			return false;
		}
	}
}