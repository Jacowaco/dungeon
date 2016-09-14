package game
{
	import flash.display.Sprite;
	
	import tiles.Screen;
	import tiles.TileMap;
	
	public class Level extends Sprite
	{
		private var map:TileMap;
		
		public function Level()
		{
			super();
			
			map = new TileMap(Game.path("./tiles/"), "levels.tmx");
			
			createLevel();
			
		}
		
		private function createLevel():void
		{
			trace("map: -----------");
			trace(map.numLayers);
			trace(map.getTileLayer("layer_1"));
//			addChild(new Screen(map.getTileLayer("level_1")));
		}
	}
}