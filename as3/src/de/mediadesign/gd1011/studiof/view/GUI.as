/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:59
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import feathers.controls.Button;
	import feathers.controls.ScreenNavigator;
	import feathers.themes.MetalWorksMobileTheme;

	import starling.display.Sprite;

	public class GUI extends Sprite
    {
		private var _theme:MetalWorksMobileTheme;
		private var _navigator:ScreenNavigator;

		public function GUI()
        {
			_theme = new MetalWorksMobileTheme(this);
			_navigator = new ScreenNavigator();
			var button:Button = new Button();
			button.label = "Pause";
			addChild(button);
        }
    }
}
