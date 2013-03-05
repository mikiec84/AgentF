/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 05.03.13
 * Time: 12:17
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.view.mediators.TopSecretTexture;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class LevelEndScreen extends Sprite
	{
		public function LevelEndScreen()
		{
			var text:Image = new Image(Texture.fromBitmapData(new TopSecretTexture("Highscore",60)));
			addChild(text);
		}
	}
}
