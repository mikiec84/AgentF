/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 06.03.13
 * Time: 11:09
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.FortFox;
    import de.mediadesign.gd1011.studiof.model.FortFoxBoss;
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.services.LevelProcess;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

    import starling.display.Image;
    import starling.display.MovieClip;

    import starling.display.Sprite;
    import starling.utils.AssetManager;

    public class RegsiterFortCommand extends Command
    {
        [Inject]
        public var assets:AssetManager;

        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var level:LevelProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var fortFox:FortFox;

        override public function execute():void
        {

            var fortView:Sprite = new Sprite();
            fortView.x = GameConsts.STAGE_WIDTH;
            //var fortFox = new FortFox();
            fortView.addChild(new Image(assets.getTexture("Fort_BackLayer")));
            fortView.addChild(new Image(assets.getTexture("Fort_MidLayer")));
            fortView.addChild(new Image(assets.getTexture("Fort_UpperLayer")));
            var door = new MovieClip(assets.getTextures("Clack_High_"), 1);
            door.stop();
            fortView.addChild(door);
            door = new MovieClip(assets.getTextures("Clack_Low_"), 1);
            door.stop();
            fortView.addChild(door);

            moveProcess.addEntity(fortFox);
            renderProcess.registerRenderable(new Renderable(fortFox.position, fortView));

            var addEnemySpriteToGameEvent:GameEvent = new GameEvent(ViewConsts.ADD_SPRITE_TO_GAME, fortView);
            dispatcher.dispatchEvent(addEnemySpriteToGameEvent);
        }
    }
}
