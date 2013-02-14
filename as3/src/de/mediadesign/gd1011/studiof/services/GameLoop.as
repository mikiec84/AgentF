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
            //trace(currentLevel.scrollBGs.length);
            if (currentLevel.scrollBGs[0].position.x < 0 && currentLevel.scrollBGs.length < 4 )
            {
                initScroll();
            }
            if (currentLevel.scrollBGs[0].position.x < -844)
            {
                currentLevel.scrollBGs.shift();
            }

        }
	}
}
