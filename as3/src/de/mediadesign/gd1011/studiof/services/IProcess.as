/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 08.02.13
 * Time: 10:03
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.manager.MovementManager;

    import flash.events.IEventDispatcher;

    public interface IProcess
    {
        function update(passedTime:Number, MM:MovementManager, dispatcher:IEventDispatcher):void;
    }
}
