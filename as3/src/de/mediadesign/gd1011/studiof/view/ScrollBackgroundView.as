/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 13.02.13
 * Time: 13:30
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import starling.display.Sprite;

	public class ScrollBackgroundView extends Sprite
    {
		private var _layerID:String;
        public function ScrollBackgroundView(layerID:String)
        {
			_layerID = layerID;
        }

		public function get layerID():String
		{
			return _layerID;
		}
    }
}
