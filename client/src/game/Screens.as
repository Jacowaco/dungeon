package game
{
	import com.qb9.flashlib.lang.foreach;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import tiles.TileLayer;

	
	public class Screens extends Sprite
	{
		
		// todas las pantallas puestas una atras de la otra
		public function Screens(levelDef:Array)
		{
			var id:int = 0;
			for each(var layer:TileLayer in levelDef){
				var s:Screen = new Screen(layer);
				s.x = id * s.dimension.x;
				s.y = id * s.dimension.y;
				addChild(s);				
				id++;
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			
		}
		

	}
}