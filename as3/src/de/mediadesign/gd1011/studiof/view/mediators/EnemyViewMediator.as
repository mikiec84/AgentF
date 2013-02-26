/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 20.02.13
 * Time: 11:36
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
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

        override public function initialize():void
        {
			var img:Image;
			switch(enemyView.enemyType)
			{
				case(ViewConsts.PLAYER):
                    img = new MovieClip(assets.getTextures("Player_Idle_"),30);
                    Starling.juggler.add(img as MovieClip);
                    (img as MovieClip).play();
                    img.y = 0;
					break;
				case(ViewConsts.FLYING_ENEMY):
                    img = new MovieClip(assets.getTextures("E1 Idle_"),30);
                    Starling.juggler.add(img as MovieClip);
                    (img as MovieClip).play();
                    img.y = -150;
                    break;
				case(ViewConsts.FLOATING_ENEMY):
                    img = new MovieClip(assets.getTextures("E2 Idle_"),30);
                    Starling.juggler.add(img as MovieClip);
                    (img as MovieClip).play();
                    img.y = -100;
                    break;
				case(ViewConsts.UNDERWATER_ENEMY):
					img = new MovieClip(assets.getTextures("E3 Idle_"),15);
					Starling.juggler.add(img as MovieClip);
					(img as MovieClip).play();
					break;
			}
			enemyView.addChild(img);

            addContextListener(ViewConsts.SHOW_DAMAGE, damage);
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
