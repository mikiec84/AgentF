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
	import starling.textures.Texture;

	public class TopSecretButton extends Button
	{
		public function TopSecretButton(label:String,size:Number)
		{
			var bitmapData:BitmapData = new TopSecretTexture(label, size);
			var texture:Texture = Texture.fromBitmapData(bitmapData);

			super(texture);
		}

	}
}
