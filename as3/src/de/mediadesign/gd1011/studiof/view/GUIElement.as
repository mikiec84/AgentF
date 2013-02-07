/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 07.02.13
 * Time: 13:14
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{

	import starling.display.Sprite;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class GUIElement extends Sprite
	{
		private var _hAlign:String = HAlign.LEFT;
		private var _vAlign:String = VAlign.TOP;

		public function GUIElement()
		{
		}

		public function set hAlign(align:String):void
		{
			if(HAlign.isValid(align))
				_hAlign = align;
		}

		public function get hAlign():String
		{
			return _hAlign;
		}

		public function set vAlign(align:String):void
		{
			if(VAlign.isValid(align))
				_vAlign = align;
		}

		public function get vAlign():String
		{
			return _vAlign;
		}

	}
}
