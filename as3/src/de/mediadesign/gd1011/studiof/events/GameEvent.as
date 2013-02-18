/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 14:39
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.events
{
    import flash.events.Event;

    public class GameEvent extends Event
    {
        public var id:String;
        public var dataObj:*;
        public var data:*;

        public function GameEvent(type:String, id:String = "", dataObj:* = null, data:* = null)
        {
            super(type, false, false);
            this.id = id;
            this.dataObj = dataObj;
            this.data = data;
        }
    }
}
