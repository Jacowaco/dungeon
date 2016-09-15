package game
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import tiles.Screen;
	import tiles.TileMap;
	
	import utils.Utils;
	
	public class Level extends Sprite
	{
		private var levelDefinition:TileMap;
		private var screen:Screen;
		
		public function Level()
		{
			super();
			
			levelDefinition = new TileMap(Game.path("./tiles/"), "levels.tmx");
			levelDefinition.addEventListener(TileMap.MAP_READY, onMapReady);
			
			
			
		}
		
		private function onMapReady(e:Event):void
		{
			trace("map ready: ");
			
			screen = new Screen(levelDefinition.getLayer("level_1"));
//			trace(screen);
		}
	}
}