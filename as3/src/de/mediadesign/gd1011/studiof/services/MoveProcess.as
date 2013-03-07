/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 08.02.13
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services {
    import de.mediadesign.gd1011.studiof.model.IMovable;

    public class MoveProcess implements IProcess
    {
        public var targets:Vector.<IMovable>;

        private var _running:Boolean;

        public function MoveProcess()
        {
            targets = new Vector.<IMovable>();
            start();
        }

        public function update(time:Number):void
        {
            if (!_running)
                return
            for each(var target:IMovable in targets)
            {
                target.move(time);
            }
        }

        public function addEntity(target:IMovable):void
        {
            targets.push(target);
        }

        public function removeEntity(entity:*):void
        {
			if(entity is int)
            	targets.splice(entity, 1);
			else if (entity is IMovable)
				targets.splice(targets.indexOf(entity),1);
        }

        public function start():void
        {
            _running = true
        }

        public function stop():void
        {
            _running = false;
        }

		public function clear():void
		{
			targets = new Vector.<IMovable>();
		}
	}
}
