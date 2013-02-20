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
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.FortFoxBoss;
    import de.mediadesign.gd1011.studiof.model.Level;
    import de.mediadesign.gd1011.studiof.model.Player;
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.services.GameLoop;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;
    import de.mediadesign.gd1011.studiof.view.EnemyView;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

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
        public var dispatcher:IEventDispatcher;

        override public function execute():void
        {
            gameLoop.registerProcess(moveProcess);
            gameLoop.registerProcess(renderProcess);

            level.setPlayer(new Player(level));
            moveProcess.addEntity(level.player);
            level.fortFox = new FortFoxBoss(level);

            for (var index:int = 0; index<level.enemies.length; index++)
            {
                moveProcess.addEntity(level.enemies[index]);

                if (level.enemies[index].currentPlatform < 2)
                    var enemyView:EnemyView = new EnemyView(ViewConsts.FLYING_ENEMY, level.enemies[index].ID);
                if (level.enemies[index].currentPlatform == 2)
                    var enemyView:EnemyView = new EnemyView(ViewConsts.FLOATING_ENEMY, level.enemies[index].ID);
                if (level.enemies[index].currentPlatform > 2)
                    var enemyView:EnemyView = new EnemyView(ViewConsts.UNDERWATER_ENEMY, level.enemies[index].ID);

                renderProcess.registerRenderable(new Renderable(level.enemies[index].position, enemyView));
                var addEnemySpriteToGameEvent:GameEvent = new GameEvent(GameConsts.ADD_SPRITE_TO_GAME, enemyView);
                dispatcher.dispatchEvent(addEnemySpriteToGameEvent);
            }

            //var img3:Image = Assets.getImage("AgentF_texture");
            var playerView:EnemyView = new EnemyView(ViewConsts.PLAYER);/*
            playerView.addChild(img3);*/

            renderProcess.registerRenderable(new Renderable(level.player.position, playerView));
            var addSpriteToGameEvent:GameEvent = new GameEvent(GameConsts.ADD_SPRITE_TO_GAME, playerView);
            dispatcher.dispatchEvent(addSpriteToGameEvent);
        }
    }
}
