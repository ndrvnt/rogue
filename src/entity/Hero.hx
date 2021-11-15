package entity;

import mappa.Inventario;
import h2d.col.Point;
import mappa.Mappa;

class Hero extends Entity {
	var mappa:Mappa;
	var onMove:Int = -1;
	var zaino:Inventario;
	var inventario:Bool = false;
	var menu:Bool = true;

	override public function new() {
		super();
		this.hp = 100;
		this.forza = 100;

		this.sprite = new h2d.Bitmap(hxd.Res.human_m.toTile());
		this.addChild(this.sprite);
		this.zaino = Inventario.instance;
		this.mappa = Mappa.instance;
		this.gg = Game.instance;
		hxd.Window.getInstance().addEventTarget(this.movimento);
	}

	public function setPos(pos:Point) {
		this.x = pos.x * 32;
		this.y = pos.y * 32;
	}

	public function movimento(event:hxd.Event) {
		if (event.kind == EKeyDown || event.kind == EKeyUp) {
			if (this.menu) {
				switch (event.kind) {
					case EKeyDown:
						this.menu = false;
						this.gg.inizioGioco();
					case _:
				}
			}
			if (!this.inventario) {
				switch (event.kind) {
					case EKeyDown:
						if (event.keyCode == 73) {
							this.inventario = true;
							this.gg.mostraInventario();
							return;
						}
						if (this.onMove == -1) {
							this.onMove = event.keyCode;
							var X:Int = Math.floor(this.x / 32);
							var Y:Int = Math.floor(this.y / 32);
							if (event.keyCode == 87) {
								if (this.mappa.isWalkable(X, Y - 1)) {
									this.y -= 32;
									Y -= 1;
								}
							}
							if (event.keyCode == 83) {
								if (this.mappa.isWalkable(X, Y + 1)) {
									this.y += 32;
									Y += 1;
								}
							}
							if (event.keyCode == 65) {
								if (this.mappa.isWalkable(X - 1, Y)) {
									this.x -= 32;
									X -= 1;
								}
							}
							if (event.keyCode == 68) {
								if (this.mappa.isWalkable(X + 1, Y)) {
									this.x += 32;
									X += 1;
								}
							}
							if (this.mappa.isStair(X, Y)) {
								this.gg.cambiaMappa();
								return;
							}
							var ogg:Oggetto = this.mappa.collisioneOggetti(this.x, this.y);
							if (ogg != null) {
								this.zaino.aggiungi(ogg);
							}
						}
					case EKeyUp:
						if (this.onMove > -1) {
							if (this.onMove == event.keyCode) {
								this.onMove = -1;
								this.mappa.muoviEnemy();
							}
						}
					case _:
				}
			} else {
				switch (event.kind) {
					case EKeyDown:
						if (event.keyCode == 85) {
							this.zaino.usaOggetto();
						}
						if (event.keyCode == 83) {
							this.zaino.pos = (this.zaino.pos + 1) % this.zaino.inventario.length;
						}
						if (event.keyCode == 87) {
							this.zaino.pos = (this.zaino.pos - 1);
							if (this.zaino.pos < 0)
								this.zaino.pos = this.zaino.inventario.length - 1;
						}
						if (event.keyCode == 73) {
							this.inventario = false;
							this.gg.mostraMappa();
							return;
						}
					case _:
				}
				this.zaino.aggiorna();
			}
		}
	}
}
