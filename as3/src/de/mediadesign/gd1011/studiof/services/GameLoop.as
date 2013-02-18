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
    import de.mediadesign.gd1011.studiof.model.Level;
    import de.mediadesign.gd1011.studiof.model.ScrollableBG;

    import starling.events.EnterFrameEvent;

    public class GameLoop
	{
        public var processes:Vector.<IProcess>;

        public var currentLevel:Level;

        [Inject]
        public var moveProcess:MoveProcess;

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

        public function update(e:EnterFrameEvent):void
        {
            for each (var target:IProcess in processes)
            {
                target.update(e.passedTime);
            }

            if (currentLevel.player.shootNow())
            {
                currentLevel.player.shootBullet(e.passedTime);
            }
            for (var index:int = 0; index<currentLevel.enemies.length; index++)
                currentLevel.enemies[index].shootBullet(e.passedTime);
            //trace(currentLevel.scrollBGs.length);
            if (currentLevel.scrollBGs[0].position.x < 0 && currentLevel.scrollBGs.length < 4 )
            {
                initScroll();
            }
            if (currentLevel.scrollBGs[0].position.x < -844)
            {
                currentLevel.scrollBGs.shift();
            }
            currentLevel.collisionDetection();
            for (var index2:int = 0; index2<currentLevel.enemies.length; index2++) {
                for (var index3:int = 0; index3<currentLevel.enemies[index2].ammunition.length; index3++) {
                    if (currentLevel.enemies[index2].ammunition[index3].healthPoints < 1) {
                        currentLevel.enemies[index2].ammunition[index3].position.y += 200;
                    }
                }
                if (currentLevel.enemies[index2].healthPoints < 1) {
                    currentLevel.enemies[index2].position.y += 200;
                }
            }
            if (currentLevel.player.healthPoints < 1) {
                currentLevel.player.position.y += 200;
            }
            for (var index4:int = 0; index4<currentLevel.player.ammunition.length; index4++) {
                if (currentLevel.player.ammunition[index4].healthPoints < 1) {
                    currentLevel.player.ammunition[index4].position.y += 100;
                }
            }
            //trace(currentLevel.player.counter);
            //trace("Lebenspunkte des Spielers: "+currentLevel.player.healthPoints);
        }
	}
}
