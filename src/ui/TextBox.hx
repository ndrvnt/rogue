package ui;

import h2d.Text;
import tipodati.BaloonData;

class TextBox extends h2d.Object {
	var testo:String;
	var tmp:String;
	var ind:Int = 0;
	var len:Int = 0;
	var accum:Float = 0;
	var tf:Text;

	public function new(specifiche:BaloonData) {
		super();
		var font:h2d.Font = hxd.res.DefaultFont.get();
		font.resizeTo(specifiche.fontSize);
		var tt:Text = new h2d.Text(font);
		tt.maxWidth = specifiche.maxWidth;
		tt.text = specifiche.testo;
		this.tf = new h2d.Text(font);
		this.tf.maxWidth = specifiche.maxWidth;
		this.testo = specifiche.testo;
		this.len = this.testo.length;
		this.tmp = this.testo.charAt(0);
		this.tf.text = this.testo.charAt(0);
		this.tf.textColor = specifiche.textColor;
		var customGraphics = new h2d.Graphics();
		customGraphics.beginFill(specifiche.bgcolor);
		customGraphics.lineStyle(specifiche.bordo, specifiche.bordoColore);
		customGraphics.drawRect(0, 0, tt.textWidth + 30, tt.textHeight + 20);
		customGraphics.endFill();

		this.addChild(customGraphics);
		this.addChild(this.tf);
		this.tf.x += 15;
		this.tf.y += 10;
	}

	public function update(dt:Float) {
		if (this.ind < this.len) {
			this.accum += dt;
			if (this.accum > 0.06) {
				this.accum = 0;
				this.ind++;
				this.tmp += this.testo.charAt(this.ind);
				this.tf.text = this.tmp;
			}
		}
	}
}
