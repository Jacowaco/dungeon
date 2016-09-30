package tiles
{
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	
	import tiles.*;
	
	public class AssetCreator
	{
		public function AssetCreator()
		{
			tiles.brick;
			tiles.floor;
			tiles.goal;
			tiles.pit;
			tiles.trickFloor;
			tiles.zombie;
			tiles.hook;
			tiles.bat;
		}
		
		public static function createAsset(name:String):MovieClip
		{
//			trace("tiles."+name);
			var myClass:Class = getDefinitionByName("tiles."+name) as Class;			
			return new myClass() as MovieClip;
		}
	}
}