package {
    import net.flashpunk.World;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    import net.flashpunk.tweens.misc.Alarm;

    public class GameWorld extends World
    {
        private var key_:KeyEntity;
        private var playerBucket_:Array = new Array();
        private var currentPlayer_:uint;
        private var alarm_:Alarm;

        public static const turnTime:Number = 1.5;
        public static const playerColours:Array = new Array(0xFF9933,
                                                            0x333333,
                                                            0x9900CC,
                                                            0xFFFFFF);

        public static const playerDirs:Array = new Array(
                new Array( 0, -1),
                new Array( 1,  0),
                new Array( 0,  1),
                new Array(-1,  0)
            )

        public function GameWorld(winner:uint = 0)
        {
            var bg:Image = new Image(A.bg);
            bg.color = playerColours[winner];
            addGraphic(bg);

            for (var i:uint = 0; i < 4; ++i)
            {
                add(new Goal(i, this));
            }

            key_ = new KeyEntity(FP.halfWidth,FP.halfHeight);
            key_.randomiseLetter();
            add(key_);
        }

        public override function begin():void
        {
            switchTurn();
        }

        public override function end():void
        {
            Input.define("move");
            key_.alarm_.cancel();
            alarm_.cancel();
        }

        public override function update():void
        {
            super.update();
        }

        public function switchTurn():void
        {
            alarm_ = FP.alarm(turnTime, switchTurn);

            if (playerBucket_.length == 0)
            {
                playerBucket_ = new Array(0, 1, 2, 3);

                for (var i:int = playerBucket_.length - 1; i >= 0; --i)
                {
                    // Random number
                    var j:int = Math.round(Math.random() * i);

                    // store the ith value
                    var temp:int = playerBucket_[i];
                    // put whatever is in index j in the ith position
                    playerBucket_[i] = playerBucket_[j];
                    // restore whatever was in the ith position to index j
                    playerBucket_[j] = temp;
                }
            }

            currentPlayer_ = playerBucket_.pop();
            key_.switchTurn(currentPlayer_);
        }

        public function win(player:uint):void
        {
            FP.world = new WinWorld(player);
        }
    }

}
