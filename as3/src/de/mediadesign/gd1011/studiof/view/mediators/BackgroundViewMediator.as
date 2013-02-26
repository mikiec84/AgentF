/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 09:48
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.view.BackgroundView;
	import de.mediadesign.gd1011.studiof.view.ScrollBackgroundView;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    import starling.display.Image;

    import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class BackgroundViewMediator extends StarlingMediator
    {
        [Inject]
        public var bgView:BackgroundView;

		[Inject]
		public var assets:AssetManager;

        override public function initialize():void
        {
            addContextListener(ViewConsts.ADD_BG, add);
        }

        override public function destroy():void
        {

        }

        private function add(event:GameEvent):void
        {
			var layerID:String = (event.dataObj as ScrollBackgroundView).layerID;
			if(bgView.bgLayer[layerID]==null)
			{
				bgView.bgLayer[layerID] = new Sprite();
				bgView.addChild(bgView.bgLayer[layerID] as Sprite);
			}
			(bgView.bgLayer[layerID] as Sprite).addChild(event.dataObj);
        }
    }
}
