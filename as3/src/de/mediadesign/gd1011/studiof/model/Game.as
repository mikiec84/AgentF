/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
	import de.mediadesign.gd1011.studiof.assets.Assets;
    import de.mediadesign.gd1011.studiof.services.IProcess;

    import starling.events.EnterFrameEvent;

	public class Game
	{
		public var currentScore:int;

        private var player:Unit;

        public var objectsThatHaveToBeUpdated:Vector.<IProcess>;

		public function Game():void
		{

		}

        public function update(e:EnterFrameEvent):void
        {
            for each (var target:IProcess in objectsThatHaveToBeUpdated)
            {
                target.update(e.passedTime);
            }
        }

	}
}
