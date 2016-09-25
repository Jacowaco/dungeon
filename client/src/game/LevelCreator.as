package game
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	
	import tiles.TileMap;

	public class LevelCreator extends EventDispatcher
	{
		public static const EASY:String = "easy";
		public static const MAP_IS_READY:String = "mapIsReady";

		private var screenNumber:int = 0;
		private var levels:TileMap;		

		public function LevelCreator()
		{
			
		}
		
		private function onMapReady(e:Event):void
		{
			dispatchEvent(new Event(LevelCreator.MAP_IS_READY));
		}
		
		public function init():void
		{
			levels = new TileMap(Game.path("./tiles/"), "levels.json");
			levels.addEventListener(TileMap.MAP_READY, onMapReady);				
		}
		
		public function getLevelDefinition(difficulty:String):Array
		{
			var layers:Array = [];
			layers.push(levels.getLayer(difficulty+":1")); //levels.getLayer("level_" + (number + 1).toString())
			layers.push(levels.getLayer(difficulty+":2")); //levels.getLayer("level_" + (number + 1).toString())
			return layers;
		}
		
	}
}