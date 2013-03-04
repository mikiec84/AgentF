/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 21.02.13
 * Time: 09:37
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model {
	import de.mediadesign.gd1011.studiof.model.components.PositionComponent;

	public interface IEndboss
    {
        function start():void;              //startet den boss und aktiviert die spawnbosscommand
		function stop():void;
		function resume():void;
        function reset():void;              //resettet nur interne Werte, muss noch woanders von moveProcess, renderProcess und stage entfernt werden!
		function move(time:Number):void;
		function get initialized():Boolean;
		function get healthPoints():int;
		function get moveLeftRunning():Boolean;
		function get position():PositionComponent;
        function get scrollLevel():Boolean;
        function get idleState():Boolean;
		function update(time:Number):void;

    }
}
