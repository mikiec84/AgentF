/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 20.02.13
 * Time: 11:36
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.view.EnemyView;

    import flash.events.IEventDispatcher;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.utils.AssetManager;

    public class EnemyViewMediator extends StarlingMediator
    {
        [Inject]
        public var enemyView:EnemyView;

        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var assets:AssetManager;

        public var images:Vector.<Image>;
        private var currentImg:Image;

        override public function initialize():void
        {
            switch(enemyView.enemyType)
            {
                case(ViewConsts.PLAYER):
                    // ###### Default state ######
                    images = new Vector.<Image>();
                    currentImg = new MovieClip(assets.getTextures("Player_Idle_"),30);
                    Starling.juggler.add(currentImg as MovieClip);
                    images.push(currentImg);
                    (currentImg as MovieClip).play();
                    currentImg.x = -140;
                    currentImg.y = 20;
                    enemyView.addChild(currentImg);
                    // ##################
                    currentImg = new MovieClip(assets.getTextures("Player_Fall_"),30);
                    images.push(currentImg);
                    Starling.juggler.add(currentImg as MovieClip);
                    currentImg = new MovieClip(assets.getTextures("Player_Jump_"),30);
                    images.push(currentImg);
                    Starling.juggler.add(currentImg as MovieClip);
                    addContextListener(ViewConsts.CHANGE_ANIM, changeAnimation);
                    break;
                case(ViewConsts.FLYING_ENEMY):
                    currentImg = new MovieClip(assets.getTextures("E1 Idle_"),30);
                    Starling.juggler.add(currentImg as MovieClip);
                    (currentImg as MovieClip).play();
                    currentImg.y = -150;
                    enemyView.addChild(currentImg);
                    break;
                case(ViewConsts.FLOATING_ENEMY):
                    currentImg = new MovieClip(assets.getTextures("E2 Idle_"),30);
                    Starling.juggler.add(currentImg as MovieClip);
                    (currentImg as MovieClip).play();
                    currentImg.y = -50;
                    enemyView.addChild(currentImg);
                    break;
                case(ViewConsts.UNDERWATER_ENEMY):
                    currentImg = new MovieClip(assets.getTextures("E3 Idle_"),15);
                    Starling.juggler.add(currentImg as MovieClip);
                    (currentImg as MovieClip).play();
                    currentImg.y = 50;
                    enemyView.addChild(currentImg);
                    break;
            }
            addContextListener(ViewConsts.SHOW_DAMAGE, damage);
        }

        public function changeAnimation(event:GameEvent):void
        {
            enemyView.removeChildren(0, enemyView.numChildren-1);
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
            enemyView.addChild(currentImg);
        }

        override public function destroy():void
        {
            removeContextListener(ViewConsts.SHOW_DAMAGE, damage);
        }

        private function damage(e:GameEvent):void
        {
            if (enemyView.ID == e.dataObj.ID)
            {
                enemyView.getDamage();
            }
        }
    }
}