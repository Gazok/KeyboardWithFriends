package {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.utils.Input;

    public class KeyEntity extends Entity
    {
        private var keyGraphic_:Image = new Image(A.key);
        private var letterText_:Text = new Text("F",0,0, { color: 0x000000,
                                                               size: 26,
                                                               font: "keyFont" });

        public function KeyEntity(x:Number = 0, y:Number = 0)
        {
            super(x,y);

            letterText_.centerOrigin();
            keyGraphic_.centerOrigin();
            keyGraphic_.scaleX = 0.1;
            keyGraphic_.scaleY = 0.1;
            addGraphic(keyGraphic_);
            addGraphic(letterText_);

            randomiseLetter();
        }

        public override function update():void
        {
        }

        public function randomiseLetter():void
        {
            var c:int = Math.round(FP.random*25) + 65;

            letterText_.text = String.fromCharCode(c);
        }

    }
}
