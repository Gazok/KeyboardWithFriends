package {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class KeyEntity extends Entity
    {
        private var keyGraphic_:Image = new Image(A.key);
        private var letterText_:Text = new Text("F",0,0, { color: 0x666666,
                                                           size: 26,
                                                           font: "keyFont" });

        public function KeyEntity(x:Number = 0, y:Number = 0)
        {
            super(x,y);

            letterText_.centerOrigin();
            letterText_.alpha = 0.75;
            keyGraphic_.centerOrigin();
            keyGraphic_.scaleX = 0.1;
            keyGraphic_.scaleY = 0.1;
            addGraphic(keyGraphic_);
            addGraphic(letterText_);

            randomiseLetter();
        }

        public override function update():void
        {
            if (Input.check("key"))
            {
                x += 1;
            }
        }

        public function randomiseLetter():void
        {
            var c:int = Math.round(FP.random*25) + 65;

            letterText_.text = String.fromCharCode(c);
            Input.define("key", c);
        }

    }
}
