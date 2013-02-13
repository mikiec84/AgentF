/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 13:39
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.Level;
    import de.mediadesign.gd1011.studiof.model.Player;
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.services.Assets;
    import de.mediadesign.gd1011.studiof.services.GameLoop;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;

    import flash.display.BitmapData;
    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;

    import starling.textures.Texture;

    public class InitGameCommand extends Command
    {
        [Inject]
        public var gameLoop:GameLoop;

        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var level:Level;

        [Inject]
        public var moveProcesses:MoveProcess;

        [Inject]
        public var renderProcesses:RenderProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

        override public function execute():void
        {
            gameLoop.registerProcess(moveProcess);
            gameLoop.registerProcess(renderProcess);
            level.setPlayer(new Player());
            moveProcesses.addEntity(level.player);

            var q:Quad = new Quad(120, 120, 0x0F00F00, false);


            var img3:Image = Assets.getImage("AgentF_texture");
            var a:Sprite = new Sprite();
            a.addChild(img3);

            renderProcesses.registerRenderable(new Renderable(level.player.position, a));

            var ab:GameEvent = new GameEvent(GameConsts.ADD_SPRITE_TO_GAME, GameConsts.ADD_SPRITE_TO_GAME, a);
            dispatcher.dispatchEvent(ab);
        }
    }
}
