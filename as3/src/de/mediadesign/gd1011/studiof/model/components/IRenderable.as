/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 09:49
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components
{
    import flash.events.IEventDispatcher;

    public interface IRenderable
    {
        function render(dispatcher:IEventDispatcher):void;
    }
}
