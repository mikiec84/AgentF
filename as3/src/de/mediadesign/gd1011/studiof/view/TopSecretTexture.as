/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 05.03.13
 * Time: 12:29
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import flash.display.BitmapData;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class TopSecretTexture extends BitmapData
	{
		private var _label:TextField;
		private var _format:TextFormat;
		public function TopSecretTexture(label:String,size:Number, color:uint = 0xcb1d01, bgColor:uint = 0x0, border:Boolean = true, opaque:Boolean = true)
		{
			Font.registerFont(Top_Secret_WL);
			Font.registerFont(Top_Secret);
			_label = new TextField();
			_label.embedFonts = true;
			_label.text = "["+label+"]";
			var font:String = "Top Secret";
			if(!border)
			{
				font = "Top Secret Without Lines";
				_label.text = label;
			}
			_format = new TextFormat(font, size, color);
			_format.kerning = true;
			_label.setTextFormat(_format);
			_label.autoSize = TextFieldAutoSize.LEFT;

			super(_label.width,_label.height, !opaque,  bgColor);
			this.draw(_label);
		}
	}
}
