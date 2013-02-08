/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:59
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import de.mediadesign.gd1011.studiof.services.JSONReader;

    import starling.display.Sprite;

    public class GUI extends Sprite
    {
		private var _config:Object;
		private var _top:int = 0;
		private var _vCenter:int = 0;
		private var _bottom:int = 0;
		private var _left:int = 0;
		private var _hCenter:int = 0;
		private var _right:int = 0;

		public function GUI()
        {
			_config=JSONReader.read("viewconfig")["GUI"];

			_top = _config["padding"];
//			_vCenter = stage.stageHeight/2;
//			_bottom = stage.stageHeight-_config["padding"];

			_left = _config["padding"];
//			_hCenter = stage.stageWidth/2;
//			_right = stage.stageWidth-_config["padding"];
        }

		public function addElement(element:GUIElement):void
		{
		}

		public function removeElement(element:GUIElement):void
		{
		}
    }
}
