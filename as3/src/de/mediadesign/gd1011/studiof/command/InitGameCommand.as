/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 13:39
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.model.Level;
    import de.mediadesign.gd1011.studiof.model.Player;
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.services.GameLoop;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;

    import flash.display.BitmapData;

    import robotlegs.bender.bundles.mvcs.Command;

    import starling.display.Image;
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

        override public function execute():void
        {
            gameLoop.registerProcess(moveProcess);
            gameLoop.registerProcess(renderProcess);
            level.setPlayer(new Player());
            moveProcesses.addEntity(level.player);

//            var test3:BitmapData = new AgentF_texture(0,0);
//            var img3:Image = new Image(Texture.fromBitmapData(test3));
            var a:Sprite = new Sprite();
//            a.addChild(img3);

            renderProcesses.registerRenderable(new Renderable(level.player.position, a));
        }
    }
}
