/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.model.components.HighscoreEntry;

    import flash.net.SharedObject;

    public class Score
    {
        private var _entries:Array;
        private var saveData:SharedObject;

        [PostConstruct]
        public function onCreated():void
        {
            saveData = SharedObject.getLocal("AgentFHighScoreSave");
            if (saveData.data.highscore != null) {
                _entries = saveData.data.highscore;
            }
            else
            {
                _entries = new Array;
            }
        }

        public  function inputScore(userName:String, userScore:int):void
        {
            _entries.push(new HighscoreEntry(userName, userScore));

            if (_entries.length > 1)
                _entries.sortOn("points", Array.DESCENDING | Array.NUMERIC);

            if (_entries.length > 10)
                var a:Object = _entries.pop();
        }

        public function saveScore():void
        {
            saveData.data.highscore = _entries;
            saveData.flush();
        }

        public function get entries():Array {
            return _entries;
        }
    }
}
