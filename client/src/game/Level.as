package game
{
	import assets.*;
	
	import avtr.Avatar;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import tiles.TileMap;
	
	import utils.Utils;
	
	public class Level extends Sprite
	{
		private var collisions:CollisionManager;
		private var screens:Screens;
		private var avatar:Avatar;

		// el level es una suceción de screens
		public function Level(levelDef:Array)
		{
			screens = new Screens(levelDef);
			addChild(screens);
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
//				screenNumber = (screenNumber + 1) % 2;
//				setTimeout(createScreen, 100, screenNumber);
//				
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