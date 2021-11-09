package ui;

import h2d.Interactive;
import util.Myevent;

@:publicFields
class SimpleButton extends h2d.Object {
	var W:Float;
	var H:Float;

	public function new(testo:String, textColor:Int, bgcolor:Int, Evento:String) {
		super();
		var font:h2d.Font = hxd.res.DefaultFont.get();
		var tf = new h2d.Text(font);
		tf.text = testo;
		tf.textColor = textColor;
		var customGraphics = new h2d.Graphics();
		customGraphics.beginFill(bgcolor);
		customGraphics.drawRect(0, 0, tf.textWidth + 30, tf.textHeight + 20);
		customGraphics.endFill();

		this.addChild(customGraphics);
		this.addChild(tf);
		tf.x += 15;
		tf.y += 10;
		this.W = tf.textWidth + 30;
		this.H = tf.textHeight + 20;
		var interaction = new h2d.Interactive(tf.textWidth + 30, tf.textHeight + 20, customGraphics);
		interaction.onClick = function(event:hxd.Event) {
			Myevent.instance.emit(Evento);
		}
	}
}
