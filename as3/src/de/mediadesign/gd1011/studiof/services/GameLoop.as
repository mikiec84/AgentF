/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
	import starling.events.EnterFrameEvent;

	public class GameLoop
	{
        private var _processes:Vector.<IProcess>;
		public function GameLoop():void
		{
            _processes = new Vector.<IProcess>();
		}

        public function registerProcess(process:IProcess):void
        {
			if(_processes.indexOf(process) == -1)
            	_processes.push(process);
        }

        public function update(e:EnterFrameEvent):void
        {
            for each (var target:IProcess in _processes)
                target.update(e.passedTime);
        }
	}
}
