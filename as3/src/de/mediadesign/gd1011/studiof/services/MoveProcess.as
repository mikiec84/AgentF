/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 08.02.13
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services {
    import de.mediadesign.gd1011.studiof.manager.MovementManager;
    import de.mediadesign.gd1011.studiof.model.components.Moveable;

    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    public class MoveProcess implements IProcess
    {
        private var targets:Vector.<Moveable>;

        public function MoveProcess()
        {
            targets = new Vector.<Moveable>();
        }

        public function update(passedTime:Number, MM:MovementManager, dispatcher:IEventDispatcher):void
        {
            for each(var target:Moveable in targets)
            {
                target.move(MM);
            }
        }

        public function addEntity(target:Moveable):void
        {
            targets.push(target);
        }
    }
}
