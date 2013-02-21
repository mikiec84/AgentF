/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 09:48
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.services.GameLoop;
    import de.mediadesign.gd1011.studiof.view.BackgroundView;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.display.Image;

	import starling.utils.AssetManager;

	public class BackgroundViewMediator extends StarlingMediator
    {
        [Inject]
        public var bgView:BackgroundView;

        [Inject]
        public var gameLoop:GameLoop;

		[Inject]
		public var assets:AssetManager;

        override public function initialize():void
        {
			bgView.addChild(new Image(assets.getTexture("Background1")));
            addContextListener(GameConsts.ADD_BG_TO_GAME, add);
            gameLoop.initScroll();
        }

        override public function destroy():void
        {

        }

        private function add(event:GameEvent):void
        {
            bgView.addChild(event.dataObj);
        }
    }
}
