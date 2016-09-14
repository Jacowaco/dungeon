package tiles
{
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	
	import tiles.*;
	
	public class AssetCreator
	{
		public function AssetCreator()
		{
			tiles.obstacle;
			tiles.floor;
		}
		
		public static function createAsset(name:String):MovieClip
		{
			var myClass:Class = getDefinitionByName("tiles."+name) as Class;			
			return new myClass() as MovieClip;
		}
	}
}