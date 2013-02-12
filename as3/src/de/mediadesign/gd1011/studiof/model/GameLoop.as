/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.services.IProcess;

    import starling.events.EnterFrameEvent;

    public class GameLoop
	{
        private var player:Unit;

        public var processes:Vector.<IProcess>;

		public function GameLoop():void
		{

		}

        public function update(e:EnterFrameEvent):void
        {
            for each (var target:IProcess in processes)
            {
                target.update(e.passedTime);
            }
        }

	}
}
