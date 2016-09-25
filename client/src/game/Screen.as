package game
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import tiles.AssetCreator;
	import tiles.Tile;
	import tiles.TileLayer;
	
	public class Screen extends Sprite
	{		
		public var startPos:Vector2D;	
		public var dimension:Vector2D;
		public var obstacles:Array = [];
		
		public function Screen(layer:TileLayer)
		{
			super();
			var currentTile:Tile = layer.getTile(0,0);					
			startPos = new Vector2D(settings.avatar.defaultPosition[0] * currentTile.dimension.x, settings.avatar.defaultPosition[1] * currentTile.dimension.y);
			dimension = new Vector2D(currentTile.dimension.x * layer.getColsCount(), currentTile.dimension.x * layer.getRowsCount()); 
			
			create(layer);
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
						startPos = new Vector2D(x * currentTile.dimension.x, y * currentTile.dimension.y + currentTile.dimension.y); // si es un tile vacio
						continue;
					}
					
					var asset:MovieClip = AssetCreator.createAsset(currentTile.name);					
					asset.x = x * currentTile.dimension.x;//* scale 
					asset.y = y * currentTile.dimension.y;//* scale
					asset.name = currentTile.name;
					obstacles.push(new Obstacle(asset)); 
					if(obstacles.length > 0) addChild(obstacles[obstacles.length - 1]);
					
				}
			}
		}
	}
}
