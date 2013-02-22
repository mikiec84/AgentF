/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 21.02.13
 * Time: 09:48
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.services.LevelProcess;
    import de.mediadesign.gd1011.studiof.model.ScrollableBG;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

    public class StopScrollBGCommand extends Command
    {
        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var event:GameEvent;

        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var level:LevelProcess;

        override public function execute():void
        {
            // delete Movable in Vector
            for (var i:int = 0; i < moveProcess.targets.length; i++)
            {
                if (moveProcess.targets[i] is ScrollableBG)
                {
                    moveProcess.removeEntity(i);
                }
            }

        }
    }
}
