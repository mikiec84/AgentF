package de.mediadesign.gd1011.studiof.model.components
{
    public class EnemyInitPositioning
    {
        public var spawned:Boolean;
        public var xPos:int;

        public function EnemyInitPositioning(spawned:Boolean, xPos:int)
        {
            this.spawned = spawned;
            this.xPos = xPos;
        }
    }
}
