/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 15:17
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{

    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.Level;
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;
    import de.mediadesign.gd1011.studiof.view.BulletView;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;
    import robotlegs.bender.framework.api.LogLevel;

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
        public var level:Level;

        override public function execute():void
        {
            var view:Sprite = new BulletView();
            var unit:Unit = event.dataObj;

            moveProcess.addEntity(event.dataObj);
            renderProcess.registerRenderable(new Renderable(unit.position, view));

            var addToGameEvent:GameEvent = new GameEvent(GameConsts.ADD_SPRITE_TO_GAME, view);
            dispatcher.dispatchEvent(addToGameEvent);

        }
    }
}
