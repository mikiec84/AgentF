/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 26.02.13
 * Time: 10:34
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.view.TopSecretTexture;

	import flash.display.BitmapData;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import starling.display.Button;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.HAlign;

	public class TopSecretTextfield extends Image
	{
		private var _text:String;
		private var _size:Number;
		private var _color:uint;
		private var _align:String;
		private var _bgColor:uint;
		private var _border:Boolean;
		private var _opaque:Boolean;
		public function TopSecretTextfield(label:String,size:Number, color:uint = 0xcb1d01, align:String = HAlign.LEFT, bgColor:uint = 0x0, border:Boolean = true, opaque:Boolean = true)
		{
			_text = label;
			_size = size;
			_color = color;
			_align = align;
			_bgColor = bgColor;
			_border = border;
			_opaque = opaque;
			super(getTexture());
			adjust();
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(label:String):void
		{
			_text = label;
			createNewImage();
		}

		override public function get color():uint
		{
			return _color;
		}

		override public function set color(color:uint):void
		{
			_color = color;
			createNewImage();
		}

		public function get size():Number
		{
			return _size;
		}

		public function set size(size:Number):void
		{
			_size = size;
			createNewImage();
		}


		private function getTexture():Texture
		{
			var bitmapData:BitmapData = new TopSecretTexture(_text, _size,_color, _bgColor, _border, _opaque);
			var texture:Texture = Texture.fromBitmapData(bitmapData);
			bitmapData.dispose();
			return texture;
		}

		private function createNewImage():void
		{
			texture = getTexture();
			readjustSize();
			adjust();
		}

		private function adjust():void
		{
			switch (_align)
			{
				case (HAlign.LEFT):
					break;
				case (HAlign.CENTER):
					pivotX = width / 2;
					break;
				case (HAlign.RIGHT):
					pivotX = width;
					break;
			}
		}

	}
}
