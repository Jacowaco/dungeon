package game
{
	import assets.*;
	import com.qb9.flashlib.geom.Vector2D;
	import game.obstacles.Obstacle;
	
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
	
	public class PlatformGame extends Sprite
	{
		public static const END:String = "LevelEnd";
		
		public static var currentLevel:int = 0;
		
		private var collisions:CollisionManager;
		
		private var screens:Screens;
		private var avatar:Avatar;
		private var camera:Sprite;
		private var rlim:int;

		// aca solo me encargo de jugar. :)
		public function PlatformGame(levelDef:Array)
		{
			
			camera = new Sprite();		
			// el objeto Screens es el que sabe como armar la pantalla
			// una vez que tengo eso como un sprite, lo atachea
			screens = new Screens(levelDef);	
			camera.addChild(screens);
			
			//
			avatar = new Avatar();			
			camera.addChild(avatar);
			
			addChild(camera);
			
			// la logica es mas o menos igual a lo anterior:
			// separo las cosas de los metodos (los algoritmos)
			collisions = new CollisionManager(screens, avatar);
			collisions.addEventListener(PlatformGame.END, onEnd);
			
			//TODO mejorar la camara
			rlim = settings.camera.rightLimit;
			
			//avatar.adde
			avatar.setFallState();
			
			var startScreen:Screen = screens.getScreens()[currentLevel];
			var _start:Vector2D = startScreen.start;
			avatar.position = new Vector2D(startScreen.x + _start.x, startScreen.y + _start.y);
			avatar.revertPosition();
			
			//trace(screens.getScreens()[0].x, screens.getScreens()[1].x);
		}
		
		public function onEnterFrame(e:Event):void
		{						
			// esto esta feo pero funciona:
			// la idea es que si no estoy saltando, fuerzo el estado del avatar a caer.
			// si colisiona con algo se queda quieto
			//if(!avatar.isJumping()) avatar.setFallState();			
			
			avatar.update();
			
			collisions.resolve(); // si colisiono, el manager de colisiones le va a hacer algo a mi avatar. le dejo esa responsabiliadd
			
			cameraUpdate();
			
			checkCheckpoint();
		}
		
		// clasico
		private function cameraUpdate():void
		{
			var currentPos:Point = avatar.stagePos();
			if(currentPos.x > settings.camera.rightLimit){
				camera.x += rlim - currentPos.x;
			}
		}
		
		private function checkCheckpoint():void
		{
			for (var i:int = 0; i < screens.getScreens().length; i++)
			{
				if (avatar.position.x >= screens.getScreens()[i].x)
				{
					if (currentLevel < i)
					{
						currentLevel = i;
						trace("reached checkpoint", currentLevel);
					}
				}
			}
		}
		
		// la unica interacción que recibo del mundo exterior
		// falta pause() y resume();
		public function onKeyDown(key:KeyboardEvent):void
		{
			avatar.onKeyDown(key);
		}
		
		public function onKeyUp(key:KeyboardEvent):void
		{
			avatar.onKeyUp(key);	
		}
		
		private function onEnd(e:Event):void
		{
			
		}
		
		public function dispose():void
		{
			screens.dispose();
		}
	}
}