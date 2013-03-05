/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 05.03.13
 * Time: 12:29
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
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
		public function TopSecretTexture(label:String,size:Number)
		{
			Font.registerFont(Top_Secret);
			_label = new TextField();
			_label.embedFonts = true;
			_label.text = "["+label+"]";
			_format = new TextFormat("Top Secret", size, 0xcb1d01);
			_format.kerning = true;
			_label.setTextFormat(_format);
			_label.autoSize = TextFieldAutoSize.LEFT;

			super(_label.width,_label.height, false,  0x0);
			this.draw(_label);
		}
	}
}
