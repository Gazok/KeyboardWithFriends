package {
    import net.flashpunk.World;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class GameWorld extends World
    {
        private var key_:KeyEntity;

        public function GameWorld()
        {
            Input.define("randomise", Key.SPACE);

            key_ = new KeyEntity(300,300);
            add(key_);
        }

        public override function update():void
        {
            if (Input.check("randomise"))
            {
                key_.randomiseLetter();
            }
        }

    }

}
