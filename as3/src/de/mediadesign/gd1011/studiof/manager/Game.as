/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.manager
{
    import de.mediadesign.gd1011.studiof.model.*;
	import de.mediadesign.gd1011.studiof.assets.Assets;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
    import de.mediadesign.gd1011.studiof.model.components.Renderable;
    import de.mediadesign.gd1011.studiof.services.IProcess;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.Render;

    import starling.events.EnterFrameEvent;

	public class Game
	{
        [Inject]
        public var alleMoveableProzesse:MoveProcess;
        [Inject]
        public var alleRenderableProzesse:Render;


        public var playerPos:PositionComponent;
        public var currentScore:int;

		public function Game():void
		{

		}

        [PostConstruct]
        public function execute():void
        {

            var player = new Unit("Player");
            playerPos = player._movement.position;
            alleMoveableProzesse.addEntity(player._movement);
            alleRenderableProzesse.addEntity(player.renderData);
        }

        public function update(e:EnterFrameEvent):void
        {
                alleMoveableProzesse.update();
                alleRenderableProzesse.update();
        }

	}
}
