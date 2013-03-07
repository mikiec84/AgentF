/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 05.03.13
 * Time: 12:17
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;
	import de.mediadesign.gd1011.studiof.view.TopSecretTexture;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class LevelEndScreen extends Sprite
	{
		public var nextButton:Button;
		public function LevelEndScreen(width:Number, height:Number,  score:Number)
		{
			var viewconfig:Object = JSONReader.read("viewconfig")["startscreen"];
			var title:TopSecretTextfield = new TopSecretTextfield(Localization.getString("highscore"),viewconfig["title-size"]);
			title.x = title.y = viewconfig["padding"];
			addChild(title);

			var points:Image = new Image(Texture.fromBitmapData(new TopSecretTexture(score+"00 "+Localization.getString("points"),viewconfig["score-size"])));
			points.x = (width-points.width)/2;
			points.y = (height-points.height)/2;
			addChild(points);

			nextButton = new TopSecretButton(Localization.getString("next level"),viewconfig["button-size"]);
			nextButton.x = width-nextButton.width-viewconfig["padding"];
			nextButton.y = height-nextButton.height-viewconfig["padding"];

			addChild(nextButton);


		}
	}
}
