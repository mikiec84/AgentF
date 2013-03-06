/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 06.03.13
 * Time: 21:00
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class LifePointsView extends Sprite
	{
		private var _point1:Image;
		private var _point2:Image;
		private var _point3:Image;
		public function LifePointsView(assets:AssetManager, level:Number)
		{
			var _config = JSONReader.read("viewconfig")["assetsets"]["level_"+(level+1)]["lifepoints"];
			addChild(assets.getImage("Lv"+(level+1)+"_Ast"));
			_point1 = assets.getImage("Lv"+(level+1)+"_Frucht");
			addChild(_point1);
			_point2 = assets.getImage("Lv"+(level+1)+"_Frucht");
			addChild(_point2);
			_point3 = assets.getImage("Lv"+(level+1)+"_Frucht");
			addChild(_point3);

			_point1.y = _config["top1"];
			_point2.y = _config["top2"];
			_point3.y = _config["top3"];
			_point1.x = _config["left-offset"];
			_point2.x = _point1.x + _point1.width +  _config["padding"];
			_point3.x = _point2.x + _point2.width +_config["padding"];
		}

		public function set points(p:Number):void
		{
			if(p < 3)
				removeChild(_point3);
			if(p<2)
				removeChild(_point2);
			if(p<1)
				removeChild(_point1);
		}
	}
}
