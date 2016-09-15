package tiles
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Screen extends Sprite
	{
		
		private var elements:Array;
		
		public function Screen(screenDefinition:TileLayer)
		{
			super();
			elements = new Array();
			create(screenDefinition);
		}
		
		private function create(tl:TileLayer):void
		{			
			// creo una nueva capa y la llamo como se llama en el tiled
			// hay guardo todos los sprites que forman esa capa
//			elements[tl.name] = new Array();	
			
			// creo y atacheo todo a la capa.
			// lo que no se ve lo pongo invisible
			for(var x:int = 0; x < tl.getColsCount(); x++)
			{
				// para cada columna
				for(var y:int = 0 ; y < tl.getRowsCount(); y++)
				{	// para cada fila
					
					var currentTile:Tile = tl.getTile(x,y);					
					if(currentTile.gid == 0) continue; // si es un tile vacio
					
					var asset:MovieClip = AssetCreator.createAsset(currentTile.name);
					// los tiles se muestran centrados
					asset.x = x * currentTile.dimension.x + ( currentTile.dimension.x ) / 2;//* scale 
					asset.y = y * currentTile.dimension.y  + ( currentTile.dimension.x) / 2;//* scale
					asset.name = currentTile.name || "no name";
					addChild(asset);
				}
				
				elements[tl.name].push(asset);
			}
		}
	}
}
