package ui;

import tipodati.BaloonData;

/*
	Baloon con il testo che al via fa animazione verso alto e tende a scomparire
 */
class Baloon extends h2d.Object {
	private var WW:Float;
	private var HH:Float;

	public function new(specifiche:BaloonData) {
		super();

		var font:h2d.Font = hxd.res.DefaultFont.get();
		trace(font.size);
		font.resizeTo(specifiche.fontSize);
		var tf = new h2d.Text(font);
		tf.maxWidth = specifiche.maxWidth;
		tf.text = specifiche.testo;
		tf.textColor = specifiche.textColor;
		var customGraphics = new h2d.Graphics();
		customGraphics.beginFill(specifiche.bgcolor);
		customGraphics.lineStyle(specifiche.bordo, specifiche.bordoColore);
		customGraphics.drawRect(0, 0, tf.textWidth + 30, tf.textHeight + 20);
		customGraphics.endFill();

		this.addChild(customGraphics);
		this.addChild(tf);
		tf.x += 15;
		tf.y += 10;
	}

	public function w():Float {
		return this.WW;
	}

	public function h():Float {
		return this.HH;
	}

	public function update(dt:Float) {}
}
