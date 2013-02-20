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
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.view.EnemyView;

    import flash.events.IEventDispatcher;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    public class EnemyViewMediator extends StarlingMediator
    {
        [Inject]
        public var enemyView:EnemyView;

        [Inject]
        public var dispatcher:IEventDispatcher;

        override public function initialize():void
        {
            addContextListener(GameConsts.SHOW_DAMAGE, damage);
        }

        override public function destroy():void
        {
            removeContextListener(GameConsts.SHOW_DAMAGE, damage);
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
