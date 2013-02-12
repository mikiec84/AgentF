/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 15:17
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;

    import robotlegs.bender.bundles.mvcs.Command;

    import starling.events.Event;

    public class AddEnemyCommand extends Command
    {
        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var event:Event;

        override public function execute():void
        {
//            moveProcess.registerMovable();
//            renderProcess.registerRenderable();
        }
    }
}
