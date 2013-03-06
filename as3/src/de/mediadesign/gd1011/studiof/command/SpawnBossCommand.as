package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.FortFoxBoss;
    import de.mediadesign.gd1011.studiof.model.Unit;
	import de.mediadesign.gd1011.studiof.services.LevelProcess;
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.services.GameLoop;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;
    import de.mediadesign.gd1011.studiof.view.EnemyView;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

    import starling.display.Image;
    import starling.display.MovieClip;

    import starling.display.Sprite;
    import starling.utils.AssetManager;

    public class SpawnBossCommand extends Command
    {
        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var level:LevelProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

        override public function execute():void
        {
            if (level.boss is FortFoxBoss)
            {
                var bossView:Sprite = new EnemyView(ViewConsts.FORTFOX, GameConsts.BOSS_SPAWN);
            }
            else
            {
                var bossView:Sprite = new EnemyView(ViewConsts.NAUTILUS, GameConsts.BOSS_SPAWN);

            }
            moveProcess.addEntity(level.boss as Unit);
            renderProcess.registerRenderable(new Renderable(level.boss.position, bossView));

            var addEnemySpriteToGameEvent:GameEvent = new GameEvent(ViewConsts.ADD_SPRITE_TO_GAME, bossView);
            dispatcher.dispatchEvent(addEnemySpriteToGameEvent);
        }
    }
}
