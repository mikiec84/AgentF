/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.Level;
    import de.mediadesign.gd1011.studiof.model.ScrollableBG;
    import de.mediadesign.gd1011.studiof.model.Unit;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.framework.api.LogLevel;

    import starling.events.EnterFrameEvent;

    public class GameLoop
	{
        public var processes:Vector.<IProcess>;

        public var currentLevel:Level;

        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var rules:Rules;

        [Inject]
        public var dispatcher:IEventDispatcher;

		public function GameLoop(currentLevel:Level):void
		{
            processes = new Vector.<IProcess>();
            this.currentLevel = currentLevel;
		}

        public function initScroll():void
        {
            currentLevel.scrollBGs.push(new ScrollableBG());
            currentLevel.initScrollBG(currentLevel.scrollBGs[currentLevel.scrollBGs.length-1]);
        }

        public function registerProcess(process:IProcess):void
        {
            processes.push(process);
        }

        public function updateLP():void
        {
            var updateLifePointEvent:GameEvent = new GameEvent(ViewConsts.UPDATE_LIFEPOINTS, currentLevel.player.healthPoints);
            dispatcher.dispatchEvent(updateLifePointEvent);
        }

        public function  checkStatus():void
        {
            //Lost
            if (currentLevel.player.healthPoints<1)
            {
                var ab:GameEvent = new GameEvent(ViewConsts.SHOW_GAMEOVER, false);
                dispatcher.dispatchEvent(ab);
                currentLevel.stopAllUnits();
            }

            //trace(currentLevel.fortFox.healthPoints);

            // End of Level 1, start Boss Level 1
            if (currentLevel.enemies.length != 0)
            {
                if (currentLevel.player.healthPoints > 0
                        && (currentLevel.enemies[currentLevel.enemies.length-1].healthPoints < 1
                        || currentLevel.enemies[currentLevel.enemies.length - 1].position.x < 0))
                {
                    if(!currentLevel.fortFox.initialized && !currentLevel.fortFox.moveLeftRunning)
                    {
                        currentLevel.stopScrollBG();
                        currentLevel.spawnBoss();
                    }
                }
            }

            if (currentLevel.fortFox.healthPoints <= 0 && currentLevel.fortFox.initialized)
            {
                currentLevel.currentLevel+=1;
                var ab:GameEvent = new GameEvent(ViewConsts.SHOW_GAMEOVER, true);
                dispatcher.dispatchEvent(ab);
                currentLevel.stopAllUnits();
            }
            //Boss Spawn
            else if (currentLevel.enemies.length == 0)
            {
                if(!currentLevel.fortFox.initialized && !currentLevel.fortFox.moveLeftRunning)
                {
                    currentLevel.stopScrollBG();
                    currentLevel.spawnBoss();
                }
            }
            // Win
            if (currentLevel.nautilus.healthPoints <= 0 && currentLevel.nautilus.initialized)
            {
                currentLevel.currentLevel+=1;
                var ab:GameEvent = new GameEvent(ViewConsts.SHOW_GAMEOVER, true);
                dispatcher.dispatchEvent(ab);
                currentLevel.stopAllUnits();
            }

            //Boss Spawn
            else if (currentLevel.enemies.length == 0)
            {
                if(!currentLevel.nautilus.initialized && !currentLevel.nautilus.moveLeftRunning)
                {
                    currentLevel.stopScrollBG();
                    currentLevel.spawnBoss();
                }
            }
        }

        public function update(e:EnterFrameEvent):void
        {
            if(currentLevel.player== null)
                return;

            for each (var target:IProcess in processes)
            {
                target.update(e.passedTime);
            }
            // player shooting
            if (currentLevel.player.shootNow())
            {
                currentLevel.player.shootBullet(e.passedTime);
            }
            currentLevel.nautilus.shootBullet(e.passedTime);
            // Enemy shooting
            for (var index:int = 0; index<currentLevel.enemies.length; index++)
                currentLevel.enemies[index].shootBullet(e.passedTime);

            // scrolling background
            if (currentLevel.scrollBGs[0].position.x < 0 && currentLevel.scrollBGs.length < 4 )
            {
                initScroll();
            }
            if (currentLevel.scrollBGs[0].position.x < - GameConsts.STAGE_WIDTH/2)
            {
                currentLevel.scrollBGs.shift();
            }
            updateLP();
            checkStatus();
        }
	}
}
