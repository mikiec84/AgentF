/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 15.02.13
 * Time: 16:14
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	public class LevelConfiguration
	{
		private var _levelPacks:Object;
		private var _enemyPattern:Object;
		public function LevelConfiguration()
		{
			_levelPacks = JSONReader.read("level/level");
			_enemyPattern = JSONReader.read("level/pattern");
		}
		public function get numLevelPacks():int
		{
			return _levelPacks.length;
		}
		public function getLevelCount(levelPack:int):int
		{
			return _levelPacks[levelPack].length;
		}
		public function getEnemySequence(levelPack:int, level:int):Array
		{
			var patterns:Vector.<Array>= new Vector.<Array>();
			for each(var pattern:Object in _levelPacks[levelPack][level]["enemy-sequence"])
			{
				for(var i:int = 0; i < pattern["count"];i++)
					patterns.push(_enemyPattern[pattern["pattern"] as Number]);
			}

			var sequence:Array = new Array(0);
			for(var j:int = patterns.length; j >0;j--)
			{
				var chosenPattern:int = Math.floor(Math.random()*j);
				sequence = sequence.concat(patterns[chosenPattern]);
				patterns.splice(chosenPattern,1);
			}
			return sequence;
		}

	}
}
