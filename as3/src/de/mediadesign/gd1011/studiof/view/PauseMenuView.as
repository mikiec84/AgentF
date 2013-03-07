/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 06.03.13
 * Time: 21:00
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import starling.display.Button;
	import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class PauseMenuView extends Sprite
	{
		public var continueButton:Button;
		public var restartButton:Button;
		public function PauseMenuView(assets:AssetManager, level:Number)
		{
			addChild(assets.getImage("Lv"+(level+1)+"_PausenmenüHG"));
			var config:Object = JSONReader.read("viewconfig")["pausemenu"];
			continueButton = new TopSecretButton(Localization.getString("continue"),JSONReader.read("viewconfig")["startscreen"]["button-size"]);
			continueButton.x = config.x;
			continueButton.y = config.y;
			addChild(continueButton);

			restartButton = new TopSecretButton(Localization.getString("restart"),JSONReader.read("viewconfig")["startscreen"]["button-size"]);
			restartButton.x = continueButton.x ;
			restartButton.y = continueButton.y+ continueButton.height + config.padding;
			addChild(restartButton);
		}
	}
}
