package game
{
	import assets.*;
	
	import avtr.Avatar;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import tiles.TileMap;
	
	import utils.Utils;
	
	public class Level extends Sprite
	{
		public static const END:String = "LevelEnd";
		
		private var collisions:CollisionManager;
		
		private var screens:Screens;
		private var avatar:Avatar;
		private var camera:Sprite;
		private var rlim:int;

		// el level es una suceción de screens
		public function Level(levelDef:Array)
		{
			
			camera = new Sprite();			
			screens = new Screens(levelDef);	
			camera.addChild(screens);
			
			avatar = new Avatar();			
			camera.addChild(avatar);
			
			addChild(camera);
			
			collisions = new CollisionManager(screens);
			collisions.addEventListener(Level.END, onEnd);
			
			rlim = settings.camera.rightLimit;
			init();
		}
		
		private function init():void
		{
			
		}
		

		
		public function onEnterFrame(e:Event):void
		{			
			collisions.resolve(screens, avatar);
			
			
//			var bounds:Rectangle = new Rectangle(camera.x,-100,900,580);
//			screens.currentObstacles(bounds);
//			collisions.resolve(screens.currentObstacles(), avatar);
			
			if(!avatar.isJumping()) avatar.setFallState();			
			avatar.update();			
			
			cameraUpdate();
		}
		
		private function cameraUpdate():void
		{
			var currentPos:Point = avatar.stagePos();
			if(currentPos.x > settings.camera.rightLimit){
				camera.x += rlim - currentPos.x;
			}
		}
		
		
		
		public function onKeyDown(key:KeyboardEvent):void
		{
			avatar.onKeyDown(key);

		}
		
		public function onKeyUp(key:KeyboardEvent):void
		{
			avatar.onKeyUp(key);	
		}
		
		private function onEnd(e:Event)
		{
			
		}
	}
}