/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 20.02.13
 * Time: 13:37
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

    public class DamageUnitCommand extends Command
    {
        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var event:GameEvent;

        override public function execute():void
        {
            var showDamageEvent:GameEvent = new GameEvent(GameConsts.SHOW_DAMAGE, event.dataObj);
            dispatcher.dispatchEvent(showDamageEvent);
        }
    }
}
