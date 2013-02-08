/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:49
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.manager
{
    import flash.geom.Point;

    import starling.events.Touch;

    public interface IMovementManager
    {
        function tick(allRelevantUnits:Vector):void;                 // muss auf jeder frame aufgerufen werden, bewegt und managed alles
        function handleTouch(touch:Touch,  location:Point):void;     // notwendig für die kontrolle über den player (touch=e.getTouch(stage), location=e.getTouch(stage).getLocation(stage))
        function getCurrentPlayerPosition():int;                     // gibt y koordinate des points zurück der getweent wird
    }
}
