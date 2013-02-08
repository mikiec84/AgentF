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
		private var _hAlign = HAlign.LEFT;
		private var _vAlign = VAlign.TOP;

		public var previousElement:GUIElement = null;
		public var nextElement:GUIElement = null;

		public var guiContext:GUI = null;

		public function GUIElement()
		{
		}

		public function set hAlign(align:String):void
		{
			if(HAlign.isValid(align))
			{
				if(guiContext)
				{
					guiContext.removeElement(this);
					_hAlign = align;
					guiContext.addElement(this);
				}
				else
					_hAlign = align;
			}
		}

		public function get hAlign():String
		{
			return _hAlign;
		}

		public function set vAlign(align:String):void
		{
			if(VAlign.isValid(align))
			{
				if(guiContext)
				{
					guiContext.removeElement(this);
					_vAlign = align;
					guiContext.addElement(this);
				}
				else
					_vAlign = align;
			}

		}

		public function get vAlign():String
		{
			return _vAlign;
		}

	}
}