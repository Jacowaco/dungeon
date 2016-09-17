package game
{
	import assets.*;
	
	import avtr.Avatar;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import tiles.Screen;
	import tiles.TileMap;
	
	import utils.Utils;
	
	public class Level extends Sprite
	{
		private var levels:TileMap;
		private var screens:Array = [];
		private var avatar:Avatar;
		private var collisions:CollisionManager;
		
		public function Level()
		{
			super();			
			levels = new TileMap(Game.path("./tiles/"), "levels.json");
			levels.addEventListener(TileMap.MAP_READY, onMapReady);
			
			
		}
		
		private var screenNumber:int = 0;
		
		private function onMapReady(e:Event):void
		{
			trace("map ready: ");			
			avatar = new Avatar();			
			
			createScreen(screenNumber);
			addChild(avatar);
			
		}
		
		var s:Screen ;
		private function createScreen(number:int):void
		{
			if(s){ 
				removeChild(s);
				s = null;
			}
			
			s = new Screen(levels.getLayer("level_" + (number + 1).toString()));
			addChild(s);			
			collisions = new CollisionManager(s as Screen);
			
			trace((s as Screen).startPos);
			avatar.position = (s as Screen).startPos;
			avatar.setIdleState();
					
			addEventListener(Event.ENTER_FRAME, onEnterFrame);			
		}
		
		private function onEnterFrame(e:Event):void
		{


			if(collisions.checkFloor(avatar)) {  // true si estoy parado sobre algo...
				avatar.setIdleState();
			}
			
			if(collisions.checkObstacles(avatar)) {  // true si estoy parado sobre algo...
				avatar.setIdleState();
			}
			
			
			if(!avatar.isJumping()) avatar.setFallState();
			avatar.update();
			
			if(collisions.checkGoal(avatar)) {  // true si estoy parado sobre algo...
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				screenNumber = (screenNumber + 1) % 2;
				setTimeout(createScreen, 100, screenNumber);
				
			}
			
		}
		
		
		// engania piuchanga para prbar
		private var flag:Boolean = false;		
		private function switchScreen():void
		{
			flag = !flag;
			if(flag){
				removeChild(screens[0]); addChild(screens[1]);				
				
			}else
			{
				removeChild(screens[1]); addChild(screens[0]);
			}
		}
		
		public function keyDown(key:KeyboardEvent):void
		{
			avatar.onKeyDown(key);

		}
		
		public function keyUp(key:KeyboardEvent):void
		{
			avatar.onKeyUp(key);	
		}
	}
}