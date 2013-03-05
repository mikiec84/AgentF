/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 18.02.13
 * Time: 08:51
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.services.LevelProcess;
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

    import starling.display.Sprite;

    public class DeleteUnitCommand extends Command
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
            var unit:Unit = event.dataObj;
            var view:Sprite = null;

            // delete Renderable in Vector
            for (var i:int = new int(); i < renderProcess.targets.length; i++)
            {
                if (unit.position == renderProcess.targets[i].position)
                {
                    view = renderProcess.targets[i].view;
                    renderProcess.deleteRenderableByID(i);
                }
            }

            // delete Movable in Vector
            for (var i:int = 0; i < moveProcess.targets.length; i++)
            {
                if (moveProcess.targets[i] is Unit && unit.position == (moveProcess.targets[i] as Unit).position)
                {
                    moveProcess.removeEntity(i);
                }
            }

            if (view != null)
            {
                var removeFromGameEvent:GameEvent = new GameEvent(ViewConsts.REMOVE_SPRITE_FROM_GAME, view);
                dispatcher.dispatchEvent(removeFromGameEvent);
            }

        }
    }
}
