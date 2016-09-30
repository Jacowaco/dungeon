package game
{
	import com.qb9.flashlib.geom.Vector2D;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import tiles.AssetCreator;
	import tiles.Tile;
	import tiles.TileLayer;
	
	public class Screen extends Sprite
	{		
		
		// el screen guarda la lista de sus obstaculos.
		public var obstacles:Array = [];
		// y el lugar desde donde debe arrancar el avatar esa pantalla
		private var start:Vector2D;
		private var dim:Vector2D;
		
		public function Screen(layer:TileLayer)
		{			
			var currentTile:Tile = layer.getTile(0,0);	
			dim = new Vector2D(currentTile.dimension.x * layer.getColsCount(), currentTile.dimension.x * layer.getRowsCount());
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
						start = new Vector2D(x * currentTile.dimension.x, y * currentTile.dimension.y + currentTile.dimension.y); // si es un tile vacio
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
			
			if(!start) defaultStart();
		}
		
		private function defaultStart():Vector2D
		{
			var tileSize:int = 20;
		 	return new Vector2D(x * tileSize, (y * tileSize) + tileSize); 				
		}
		
		public function get dimension():Vector2D{
			return dim;
		}
	}
}
