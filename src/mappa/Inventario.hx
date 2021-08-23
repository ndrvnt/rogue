package mappa;

import entity.Oggetto;

@:publicFields
class Inventario extends h2d.Object {
	var inventario:Array<Oggetto>;
	var font:h2d.Font;
	var pos:Int = 0;
	var gg:Game;

	public static final instance:Inventario = new Inventario();

	private function new() {
		super();
		this.inventario = new Array<Oggetto>();
	}

	public function aggiungi(ogg:Oggetto) {
		this.inventario.push(ogg);
	}

	public function attiva() {
		trace("Attivo inventario");
		this.gg = Game.instance;
		hxd.Window.getInstance().addEventTarget(this.cambiaPos);
	}

	public function disattiva() {
		trace("disattivo inventario");
		this.gg = null;
		hxd.Window.getInstance().removeEventTarget(this.cambiaPos);
	}

	public function cambiaPos(event:hxd.Event) {
		// trace(event.keyCode);
		switch (event.kind) {
			case EKeyDown:
				if (event.keyCode == 85) {
					this.usaOggetto();
				}
				if (event.keyCode == 83) {
					this.pos = (this.pos + 1) % this.inventario.length;
				}
				if (event.keyCode == 87) {
					this.pos = (this.pos - 1);
					if (this.pos < 0)
						this.pos += this.inventario.length;
				}
				if (event.keyCode == 73) {
					this.gg.mostraMappa();
					return;
				}
			case _:
		}
		this.aggiorna();
	}

	public function aggiorna() {
		this.removeChildren();

		if (this.inventario.length == 0) {
			this.pos = 0;
		} else {
			for (ind in 0...this.inventario.length) {
				if (ind == this.pos) {
					var base:Int = (ind * 64) + 16;
					var g = new h2d.Graphics(this);
					g.lineStyle(2, 0xFF0000);
					g.moveTo(1, base);
					g.lineTo(30, base + 16);
					g.lineTo(1, base + 32);
					g.lineTo(1, base);
				}

				this.inventario[ind].x = 20;
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

	public function usaOggetto() {
		if (this.inventario.length == 0) {
			return;
		}
		var ogg:Oggetto = this.inventario.splice(this.pos, 1)[0];
		switch (ogg.tipo) {
			case 1:
				this.gg.mappa.hero.hp += 50;
			case _:
		}
		this.pos = 0;
		this.aggiorna();
	}
}
