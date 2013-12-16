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
        public var alarm_:Alarm;
        private var holdTicks_:uint = 0;

        public function KeyEntity(x:Number = 0, y:Number = 0, c:String = "F", col:uint = 3)
        {
            super(x,y);

            letterText_.centerOrigin();
            letterText_.text = c;
            letterText_.blend = flash.display.BlendMode.OVERLAY;
            keyGraphic_.centerOrigin();
            keyGraphic_.scaleX = 0.1;
            keyGraphic_.scaleY = 0.1;
            keyGraphic_.color = col;
            addGraphic(keyGraphic_);
            addGraphic(letterText_);

            width = keyGraphic_.width * 0.1;
            height = keyGraphic_.height * 0.1;
            centerOrigin();
            type = "key";
        }

        public override function added():void
        {
        }

        public override function removed():void
        {
        }

        public override function update():void
        {
            const tickFactor:Number = 0.1;

            if (Input.check("move"))
            {
                const dirX:int = GameWorld.playerDirs[currentPlayer_][0];
                const dirY:int = GameWorld.playerDirs[currentPlayer_][1];
                const moveX:Number = dirX * speed_;
                const moveY:Number = dirY * speed_;

                x += moveX + dirX*holdTicks_ * tickFactor;
                y += moveY + dirY*holdTicks_ * tickFactor;

                const offsetSpeed:Number = 3;
                const dispFromCentreX:int = FP.halfWidth - x;
                const centreDirX:int = dispFromCentreX / Math.abs(dispFromCentreX);
                const dispFromCentreY:int = FP.halfHeight - y;
                const centreDirY:int = dispFromCentreY / Math.abs(dispFromCentreY);

                if (Math.abs(dispFromCentreX) < offsetSpeed && dirY != 0)
                {
                    x = FP.halfWidth;
                }
                else if (dirY != 0)
                {
                    x += Math.abs(moveY) * centreDirX * offsetSpeed;
                }
                else if (Math.abs(dispFromCentreY) < offsetSpeed && dirX != 0)
                {
                    y = FP.halfHeight;
                }
                else if (dirX != 0)
                {
                    y += Math.abs(moveX) * centreDirY * offsetSpeed;
                }

                ++holdTicks_;
            }
            if (Input.released("move"))
            {
                holdTicks_ = 0;
            }
            /*
            const e:Entity = collide("goal", 0, 0);
            if (e)
            {
                x = FP.halfWidth;
                y = FP.halfHeight;
                FP.console.log("colliding: (",x,",",y,",",width,",",height,")",
                " (",e.x,",",e.y,",",e.width,",",e.height,")");

            }
            */
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

        public function setLetter(c:int):void
        {
            letterText_.text = String.fromCharCode(c);
        }

    }
}
