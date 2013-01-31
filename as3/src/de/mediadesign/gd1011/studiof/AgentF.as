package de.mediadesign.gd1011.studiof {

	import flash.display.Sprite;

	import starling.core.Starling;

	public class AgentF extends Sprite {

	private var _starling:Starling;
    public function AgentF() {
        _starling = new Starling(Game, stage);
		_starling.start();
    }
}
}
