/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 26.02.13
 * Time: 10:34
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import flash.display.BitmapData;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import starling.display.Button;
	import starling.textures.Texture;

	public class TopSecretButton extends Button
	{
		private var _label:TextField;
		private var _format:TextFormat;
		public function TopSecretButton(label:String,size:Number)
		{
			Font.registerFont(Top_Secret);
			_label = new TextField();
			_label.embedFonts = true;
			_label.text = "["+label+"]";
			_format = new TextFormat("Top Secret", size, 0xcb1d01);
			_format.kerning = true;
			_label.setTextFormat(_format);
			_label.autoSize = TextFieldAutoSize.LEFT;

			var bitmapData:BitmapData = new BitmapData(_label.width,_label.height, false,  0x0);
			bitmapData.draw(_label);

			var texture:Texture = Texture.fromBitmapData(bitmapData);

			super(texture);
		}

	}
}
