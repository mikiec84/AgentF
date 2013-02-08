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
	import feathers.controls.ScrollContainer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.themes.MetalWorksMobileTheme;

	import flash.sampler.getSavedThis;

	import starling.core.Starling;

	import starling.display.Sprite;
	import starling.events.Event;

	public class GUI extends Sprite
    {
		private var _theme:MetalWorksMobileTheme;

		public function GUI()
        {
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE,init);

        }

		private function init(e:Event=null):void
		{
			_theme = new MetalWorksMobileTheme(this.stage);

			var button:Button = new Button();
			button.label = "Pause";
			button.validate();
			addChild(button);
		}
    }
}
