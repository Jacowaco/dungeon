package game.obstacles
{
	import flash.display.MovieClip;
	import flash.geom.Point;

	public class Hook extends Obstacle
	{
		private var box:MovieClip;
		private var _hookPos:Point;
		
		public function Hook(mc:MovieClip)
		{
			super(mc);
			myType = Obstacle.HOOK;
			box = (asset.getChildByName("box") as MovieClip).getChildByName("hook") as MovieClip;
			//trace((asset.getChildByName("box") as MovieClip), box);
			_hookPos = new Point();
		}
		
		override public function activate():void
		{
			// aca no hago nada...
			// el piso nunca me mata
		}
		
		
		
		public function get hookPos():Point
		{
			//_hookPos.x = parent.x + asset.x + box.x + box.width / 2;
			//_hookPos.y = parent.y + asset.y + box.y + box.height / 2;
			//_hookPos.x = parent.x + asset.x + box.parent.x + box.localToGlobal(new Point).x + box.width / 2;
			//_hookPos.y = parent.y + asset.y + box.parent.y + box.localToGlobal(new Point).y + box.height / 2;
//			_hookPos.x = parent.x + asset.x + box.parent.x + box.x;// + box.width / 2;
//			_hookPos.y = parent.y + asset.y + box.parent.y + box.y;// + box.height / 2;
			
			_hookPos.x = parent.x + asset.x + box.parent.x + box.x;// + box.width / 2;
			_hookPos.y = parent.y + asset.y + box.parent.y + box.y;// + box.height / 2;
			
			//trace(_hookPos, parent.x, asset.x, box.parent.x, box.localToGlobal(new Point));
			
			return _hookPos;
//			return box.localToGlobal(new Point);
		}
		
	}
}