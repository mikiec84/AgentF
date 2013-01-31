package de.mediadesign.gd1011.studiof {

	import flash.display.Sprite;

	import starling.core.Starling;
	import starling.events.Event;

	public class AgentF extends Sprite {

	private var _starling:Starling;
    public function AgentF() {
		Starling.handleLostContext=true;

        _starling = new Starling(Game, stage);
		_starling.addEventListener(Event.ROOT_CREATED,init);
    }

	private function init(e:Event = null):void
	{
		_starling.start();
	}
}
}
