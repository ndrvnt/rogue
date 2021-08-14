package mappa;

import entity.Oggetto;
import entity.Zaino;

class Inventario extends h2d.Object {
	var inventario:Array<Oggetto>;
	var font:h2d.Font;

	public static final instance:Inventario = new Inventario();

	private function new() {
		super();
		// this.font = hxd.res.DefaultFont.get();
		this.inventario = Zaino.instance.inventario;
	}

	public function aggiorna() {
		this.removeChildren();
		for (ind in 0...this.inventario.length) {
			this.inventario[ind].x = 0;
			this.inventario[ind].y = ind * 64;

			this.inventario[ind].scaleX = 2;
			this.inventario[ind].scaleY = 2;

			var tf = new h2d.Text(hxd.res.DefaultFont.get());
			tf.x = 68;
			tf.y = ind * 64;
			tf.scaleX = 2;
			tf.scaleY = 2;
			tf.text = "Pozione";

			this.addChild(this.inventario[ind]);
			this.addChild(tf);
		}
	}
}
