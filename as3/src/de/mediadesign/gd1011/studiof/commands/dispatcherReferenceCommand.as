/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 11.02.13
 * Time: 11:05
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.commands
{
    import de.mediadesign.gd1011.studiof.manager.Game;

    import flash.events.EventDispatcher;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

    public class dispatcherReferenceCommand extends Command
    {
        [Inject]
        public var game:Game;
        [Inject]
        public var dispatcher:IEventDispatcher;

        override public function execute():void
        {
            game.gibMirDispatcher(dispatcher);
        }
    }
}
