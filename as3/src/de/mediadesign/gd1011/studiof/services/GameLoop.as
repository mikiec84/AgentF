/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.model.Level;
    import de.mediadesign.gd1011.studiof.model.Unit;

    import starling.events.EnterFrameEvent;

    public class GameLoop
	{
        public var processes:Vector.<IProcess>;

        public var currentLevel:Level;

        private var bullet:Unit;

		public function GameLoop(currentLevel:Level):void
		{
            processes = new Vector.<IProcess>();
            this.currentLevel = currentLevel;
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

            if (currentLevel.player.shootNow()) {
                currentLevel.player.shootBullet(e.passedTime);
            }
        }
	}
}
