/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 26.02.13
 * Time: 09:54
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

    public class ChangeUnitStateCommand extends Command
    {
        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var event:GameEvent;

        override public function execute():void
        {
            var changeAnimEvent:GameEvent = new GameEvent(ViewConsts.CHANGE_ANIM, event.dataObj);
            dispatcher.dispatchEvent(changeAnimEvent);
        }
    }
}