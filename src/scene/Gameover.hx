package scene;

class Gameover extends h2d.Object {
	public static final instance:Gameover = new Gameover();

	private function new() {
		super();
	}

	public function init() {
		var tf = new h2d.Text(hxd.res.DefaultFont.get());
		tf.x = 90;
		tf.y = 90;
		tf.textColor = 0xff0000;
		tf.scaleX = 4;
		tf.scaleY = 4;
		tf.text = "GAME OVER!";
		this.addChild(tf);

		var tf2 = new h2d.Text(hxd.res.DefaultFont.get());
		tf2.x = 160;
		tf2.y = 160;
		tf2.text = "press any key to restart.";
		this.addChild(tf2);
	}
}
