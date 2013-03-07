/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 05.03.13
 * Time: 12:17
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import de.mediadesign.gd1011.studiof.model.Score;
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import starling.display.Button;
	import starling.display.Sprite;

	public class LevelEndScreen extends Sprite
	{
		public var nextButton:Button;
		public function LevelEndScreen(width:Number, height:Number,  score:Number, highscore:Score)
		{
            highscore.inputScore("AgentF", score);
            highscore.saveScore();

			var viewconfig:Object = JSONReader.read("viewconfig")["startscreen"];
			var title:TopSecretTextfield = new TopSecretTextfield(Localization.getString("highscore"),viewconfig["title-size"]);
			title.x = title.y = viewconfig["padding"];
			addChild(title);

            for (var i:int = 0; i<highscore.entries.length; i++)
            {
                var content:String;

                if (i == 9)
                {
                    content = (i+1).toString()+": "+highscore.entries[i].name+" "+highscore.entries[i].points+"00";
                }
                else
                {
                    content = (i+1).toString()+":  "+highscore.entries[i].name+" "+highscore.entries[i].points+"00";
                }
                var points:TopSecretTextfield = new TopSecretTextfield(content, 60);
                points.x = 400;
                points.y = (i+1)*70+150;
                addChild(points);
            }

			nextButton = new TopSecretButton(Localization.getString("next level"),viewconfig["button-size"]);
			nextButton.x = width-nextButton.width-viewconfig["padding"];
			nextButton.y = height-nextButton.height-viewconfig["padding"];

			addChild(nextButton);


		}
	}
}
