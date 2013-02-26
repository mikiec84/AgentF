/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 26.02.13
 * Time: 09:11
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.view.PlayerView;

    import flash.events.IEventDispatcher;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    import starling.core.Starling;

    import starling.display.Image;
    import starling.display.MovieClip;

    import starling.utils.AssetManager;

    public class PlayerViewMediator extends StarlingMediator
    {
        [Inject]
        public var playerView:PlayerView;

        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var assets:AssetManager;

        public var images:Vector.<Image>;
        private var currentImg:Image;

        override public function initialize():void
        {
            // ###### Default state ######
            images = new Vector.<Image>();
            currentImg = new MovieClip(assets.getTextures("Player_Idle_"),30);
            Starling.juggler.add(currentImg as MovieClip);
            images.push(currentImg);
            (currentImg as MovieClip).play();
            playerView.addChild(currentImg);
            // ##################
            currentImg = new MovieClip(assets.getTextures("Player_Fall_"),30);
            images.push(currentImg);
            Starling.juggler.add(currentImg as MovieClip);
            currentImg = new MovieClip(assets.getTextures("Player_Jump_"),30);
            images.push(currentImg);
            Starling.juggler.add(currentImg as MovieClip);

            addContextListener(ViewConsts.CHANGE_ANIM, changeAnimation);
            addContextListener(ViewConsts.SHOW_DAMAGE, damage);
        }

        public function changeAnimation(event:GameEvent):void
        {
            playerView.removeChildren(0, playerView.numChildren-1);
            switch(event.dataObj)
            {
                case(GameConsts.IDLE):
                    currentImg = images[0];
                    break;
                case(GameConsts.FALL):
                    currentImg = images[1];
                    break;
                case(GameConsts.JUMP):
                    currentImg = images[2];
                    break;
            }
            (currentImg as MovieClip).play();
            playerView.addChild(currentImg);
        }

        override public function destroy():void
        {
            removeContextListener(ViewConsts.CHANGE_ANIM, changeAnimation);
            removeContextListener(ViewConsts.SHOW_DAMAGE, damage);
        }

        private function damage(e:GameEvent):void
        {
            if (playerView.ID == e.dataObj.ID)
            {
                playerView.getDamage();
            }
        }
    }
}
