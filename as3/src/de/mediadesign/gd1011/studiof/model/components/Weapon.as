/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:57
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components
{
    import de.mediadesign.gd1011.studiof.model.Unit;


    public class Weapon
    {
        public var ammunition:Vector.<Unit>;
        private var _weaponType:String;

        public function Weapon()
        {

        }

        public function get weaponType():String
        {
            return _weaponType;
        }

        public function set weaponType(value:String):void
        {
            _weaponType = value;
        }
    }
}
