/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.manager
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.services.IProcess;
    import de.mediadesign.gd1011.studiof.services.JSONReader;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.Render;

    import flash.events.EventDispatcher;

    import flash.events.IEventDispatcher;

    import starling.events.EnterFrameEvent;

    public class Game
	{
        [Inject]
        public var alleMoveableProzesse:MoveProcess;
        [Inject]
        public var alleRenderableProzesse:Render;
        [Inject]
        public var MM:MovementManager;
        [Inject]
        public var UM:UnitManager;

        public var currentScore:int;
        private var _dispatcher:IEventDispatcher;
        private var movePosEvent:GameEvent;

        public var player:Unit;

        public var objectsThatHaveToBeUpdated:Vector.<IProcess>;

		public function Game():void
		{
            objectsThatHaveToBeUpdated = new Vector.<IProcess>();
            movePosEvent = new GameEvent("MPE", "MPE");

            player = new Unit("Player");

            objectsThatHaveToBeUpdated.push(alleRenderableProzesse);
            objectsThatHaveToBeUpdated.push(alleMoveableProzesse);

            alleMoveableProzesse.addEntity(player.moveData);
            alleRenderableProzesse.addEntity(player.renderData);

            UM.addPlayer(player);
        }

        public function update(e:EnterFrameEvent):void
        {   if(_dispatcher == null) return;

            for each (var target:IProcess in objectsThatHaveToBeUpdated)
            {
                target.update(e.passedTime, MM, _dispatcher);
            }

            _dispatcher.dispatchEvent(movePosEvent);
//            playerPos = new PositionComponent();
//            var player = new Unit();
//            playerPos = player._movement.position;
        }

        public function gibMirDispatcher(dis:IEventDispatcher):void
        {
            _dispatcher = dis;
        }

	}
}
