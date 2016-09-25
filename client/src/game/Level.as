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
		private var camera:Sprite;

		// el level es una suceción de screens
		public function Level(levelDef:Array)
		{
			
			camera = new Sprite();
			
			screens = new Screens(levelDef);	
			camera.addChild(screens);
			
			
			
			
			
			avatar = new Avatar();
			collisions = new CollisionManager(screens);
			
			
			camera.addChild(avatar);

			addChild(camera);			
			init();
		}
		
		private function init():void
		{
			
		}
		

		
		public function onEnterFrame(e:Event):void
		{

			collisions.resolve(screens.currentScreen(), avatar);
			if(!avatar.isJumping()) avatar.setFallState();
			avatar.update();
				
			screens.x --;
			
			
		}
		
		
		
		
		public function onKeyDown(key:KeyboardEvent):void
		{
			avatar.onKeyDown(key);

		}
		
		public function onKeyUp(key:KeyboardEvent):void
		{
			avatar.onKeyUp(key);	
		}
	}
}