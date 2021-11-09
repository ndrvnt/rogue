package scene;

import h2d.Interactive;

class Menu extends h2d.Object {
	var inter:Interactive;

	public static final instance:Menu = new Menu();

	private function new() {
		super();
	}

	public function init() {
		var tf = new h2d.Text(hxd.res.DefaultFont.get());
		tf.x = 90;
		tf.y = 90;
		tf.scaleX = 4;
		tf.scaleY = 4;
		tf.text = "ROUGUE...";
		this.addChild(tf);

		var tf2 = new h2d.Text(hxd.res.DefaultFont.get());
		tf2.x = 160;
		tf2.y = 160;
		tf2.text = "press any key to start.";
		this.addChild(tf2);
	}
}
