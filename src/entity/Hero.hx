package entity;

import h2d.col.Point;
import mappa.Mappa;

class Hero extends Entity {
	var mappa:Mappa;
	var onMove:Int = -1;
	var zaino:Array<Oggetto>;

	override public function new(pos:Point) {
		super();
		this.hp = 100;
		this.x = pos.x * 32;
		this.y = pos.y * 32;
		this.sprite = new h2d.Bitmap(hxd.Res.human_m.toTile());
		this.addChild(this.sprite);
		this.zaino = new Array<Oggetto>();
		this.mappa = Mappa.instance;
		hxd.Window.getInstance().addEventTarget(this.movimento);
	}

	public function movimento(event:hxd.Event) {
		switch (event.kind) {
			case EKeyDown:
				if (this.onMove == -1) {
					this.onMove = event.keyCode;
					var X:Int = Math.floor(this.x / 32);
					var Y:Int = Math.floor(this.y / 32);
					if (event.keyCode == 87) {
						if (this.mappa.isWalkable(X, Y - 1)) {
							this.y -= 32;
						}
					}
					if (event.keyCode == 83) {
						if (this.mappa.isWalkable(X, Y + 1)) {
							this.y += 32;
						}
					}
					if (event.keyCode == 65) {
						if (this.mappa.isWalkable(X - 1, Y)) {
							this.x -= 32;
						}
					}
					if (event.keyCode == 68) {
						if (this.mappa.isWalkable(X + 1, Y)) {
							this.x += 32;
						}
					}
					var ogg:Oggetto = this.mappa.collisioneOggetti(this.x, this.y);
					if (ogg != null) {
						this.zaino.push(ogg);
					}
				}
			case EKeyUp:
				if (this.onMove > -1) {
					if (this.onMove == event.keyCode) {
						this.onMove = -1;
					}
				}
			case _:
		}
	}
}
