package {
    import flash.display.BlendMode;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    import net.flashpunk.tweens.misc.Alarm;

    public class KeyEntity extends Entity
    {
        private const speed_:Number = 1;
        private var keyGraphic_:Image = new Image(A.key);
        private var letterText_:Text = new Text("F",0,0, { color: 0x333333,
                                                           size: 26,
                                                           font: "keyFont" });

        private var currentPlayer_:uint = 0;
        private var alarm_:Alarm;
        private var holdTicks_:uint = 0;

        public static const dirs:Array = new Array(
                new Array( 0, -1),
                new Array( 1,  0),
                new Array( 0,  1),
                new Array(-1,  0)
            )

        public function KeyEntity(x:Number = 0, y:Number = 0)
        {
            super(x,y);

            letterText_.centerOrigin();
            letterText_.blend = flash.display.BlendMode.OVERLAY;
            keyGraphic_.centerOrigin();
            keyGraphic_.scaleX = 0.1;
            keyGraphic_.scaleY = 0.1;
            addGraphic(keyGraphic_);
            addGraphic(letterText_);
        }

        public override function added():void
        {
            randomiseLetter();
        }

        public override function removed():void
        {
            alarm_.cancel();
        }

        public override function update():void
        {
            const tickFactor:Number = 0.1;

            if (Input.check("move"))
            {
                const dirX:int = dirs[currentPlayer_][0];
                const dirY:int = dirs[currentPlayer_][1];
                const moveX:Number = dirX * speed_;
                const moveY:Number = dirY * speed_;

                x += moveX + dirX*holdTicks_ * tickFactor;
                y += moveY + dirY*holdTicks_ * tickFactor;

                var dispFromCentreX:int = FP.halfWidth - x;
                var centreDirX:int = dispFromCentreX / Math.abs(dispFromCentreX);
                var dispFromCentreY:int = FP.halfHeight - y;
                var centreDirY:int = dispFromCentreY / Math.abs(dispFromCentreY);
                x += Math.abs(moveY) * centreDirX;
                y += Math.abs(moveX) * centreDirY;

                ++holdTicks_;
            }
            if (Input.released("move"))
            {
                holdTicks_ = 0;
            }
        }

        public function switchTurn(player:uint):void
        {
            holdTicks_ = 0;
            currentPlayer_ = player;
            keyGraphic_.color = GameWorld.playerColours[currentPlayer_];
        }

        public function randomiseLetter():void
        {
            var randomTime:Number = FP.random*3;
            randomTime = 1/randomTime + 4*GameWorld.turnTime;
            alarm_ = FP.alarm(randomTime, randomiseLetter);

            var randomLetter:int = Math.round(FP.random*25) + 65;

            letterText_.text = String.fromCharCode(randomLetter);
            Input.define("move", randomLetter);
        }

    }
}
