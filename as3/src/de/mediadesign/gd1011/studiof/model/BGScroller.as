/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 22.02.13
 * Time: 19:07
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
	import de.mediadesign.gd1011.studiof.consts.GameConsts;
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import flash.events.IEventDispatcher;

	public class BGScroller
	{

		private var _scrollBGs:Vector.<BGTile>;
		private var _layerID:String;
		private var _bgConfig:Object;
		private var _scrolling:Boolean;
		private var _dispatcher:IEventDispatcher;
		private var _maxTiles:int;

		public function BGScroller(bgLayerID:String, dispatcher:IEventDispatcher)
		{
			_layerID = bgLayerID;
			_dispatcher = dispatcher;
			_bgConfig = JSONReader.read("config")["background"][bgLayerID];
			_scrollBGs = new Vector.<BGTile>();
			_maxTiles = Math.ceil(JSONReader.read("config")["gamebounds"]["width"]/(_bgConfig["width"]-1)+1);
			_scrolling = true;
			dispatcher.dispatchEvent(new GameEvent(ViewConsts.CREATE_BG_LAYER,bgLayerID));
		}

		public function update():void
		{

			if (_scrollBGs.length > 0	&&
					((_bgConfig["speed"]>0 && _scrollBGs[0].position.x < -_bgConfig["width"])	||			//If it moves left and ...
				 	 ( _scrollBGs[0].position.x >= JSONReader.read("config")["gamebounds"]["width"])))		//or it moves right and ...
				_scrollBGs.shift();

			while(_scrollBGs.length < _maxTiles)
				addScrollableBG();
		}
		private function addScrollableBG():void
		{
			var bg:BGTile = new BGTile(_layerID);
			_scrollBGs.push(bg);


			if(_bgConfig["speed"]<0 && _scrollBGs.length ==1)
				bg.position.x = JSONReader.read("config")["gamebounds"]["width"];

			if (_scrollBGs.length > 1)
				if(_bgConfig["speed"]>0)
					bg.position.x = _scrollBGs[_scrollBGs.length - 2].position.x + (_bgConfig["width"]) - 1;
				else
					bg.position.x = _scrollBGs[_scrollBGs.length - 2].position.x - (_bgConfig["width"]) + 1;
			bg.position.y = _bgConfig["vPosition"];
			bg.velocity.velocityX = _bgConfig["speed"];

			var registerBGEvent:GameEvent = new GameEvent(GameConsts.CREATE_BG, bg);
			_dispatcher.dispatchEvent(registerBGEvent);
			if(!_scrolling)
				bg.moving = false;
		}

		public function stopScrolling():void
		{
			_scrolling = false;
			for each(var bg:BGTile in _scrollBGs)
				bg.moving = false;
		}
	}
}
