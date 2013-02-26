/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 15:17
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{

    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.services.LevelProcess;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;
    import de.mediadesign.gd1011.studiof.view.BulletView;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

    import starling.display.Sprite;

    public class RegisterBulletCommand extends Command
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
            var infos:Array = event.dataObj;
            var unit:Unit = infos[0];
            var view:Sprite = new BulletView(infos[1]);

            moveProcess.addEntity(unit);
            renderProcess.registerRenderable(new Renderable(unit.position, view));

            var addToGameEvent:GameEvent = new GameEvent(ViewConsts.ADD_SPRITE_TO_GAME, view);
            dispatcher.dispatchEvent(addToGameEvent);

        }
    }
}
