package tiles
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import game.Thing;
	
	public class Screen extends Sprite
	{
		
		public var startPos:Vector2D;
		public var goalPos:Vector2D;
		
		public function Screen(screenDefinition:TileLayer)
		{
			super();
			create(screenDefinition);
		}
		
		private function create(tl:TileLayer):void
		{			
			// creo una nueva capa y la llamo como se llama en el tiled
			// ahí guardo todos los sprites que forman esa capa
			for(var x:int = 0; x < tl.getColsCount(); x++)
			{
				for(var y:int = 0 ; y < tl.getRowsCount(); y++)
				{					
					var currentTile:Tile = tl.getTile(x,y);		
					
					if(currentTile.gid == 0) continue; // si es un tile vacio
					
					if(currentTile.name == "start") {
						startPos = new Vector2D(x * currentTile.dimension.x, x * currentTile.dimension.y); // si es un tile vacio
						continue;
					}
					
					if(currentTile.name == "goal") {
						startPos = new Vector2D(x * currentTile.dimension.x, x * currentTile.dimension.y); // si es un tile vacio
						continue;
					}
					
					var asset:MovieClip = AssetCreator.createAsset(currentTile.name);					
					asset.x = x * currentTile.dimension.x;//* scale 
					asset.y = y * currentTile.dimension.y;//* scale
					asset.name = currentTile.name;
					addChild(new Thing(asset));
				}
			}
		}
	}
}
