package game
{
	import com.qb9.flashlib.lang.foreach;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import tiles.TileLayer;

	
	public class Screens extends Sprite
	{
		private var screens:Array;
		private var flag:Boolean = false;		

		// todas las pantallas puestas una a continuacion de la otra
		public function Screens(levelDef:Array)
		{
			logger.info("Screens");			
			trace(levelDef);
			screens = [];
			for each(var layer:TileLayer in levelDef){
				logger.info("creating screen:" + layer);
				screens.push(new Screen(layer));												
			}
			
			var id:int = 0;
			for each(var s:Screen in screens){				
				s.x = id * s.dimension.x;
				if(screens.length > 0) {
					addChild(s);	
				}
				id++;
			}
		}
		
		public function getScreens():Array			
		{
			return screens;
		}

	}
}