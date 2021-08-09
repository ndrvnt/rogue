package entity;

import h2d.col.Point;
import mappa.Mappa;

class Hero extends Entity {
	var hp:Int = 50;
	var mappa:Mappa;
	var onMove:Int = -1;

	override public function new(pos:Point) {
		super();
		this.x = pos.x * 32;
		this.y = pos.y * 32;
		this.sprite = new h2d.Bitmap(hxd.Res.human_m.toTile());
		this.addChild(this.sprite);
		this.mappa = Mappa.instance;
		hxd.Window.getInstance().addEventTarget(this.movimento);
	}

	public function movimento(event:hxd.Event) {
		switch (event.kind) {
			case EKeyDown:
				if (this.onMove == -1) {
					this.onMove = event.keyCode;
					if (event.keyCode == 87) {
						if (this.mappa.isWalkable(Math.floor(this.x / 32), Math.floor(this.y / 32) - 1)) {
							this.y -= 32;
						}
					}
					if (event.keyCode == 83) {
						if (this.mappa.isWalkable(Math.floor(this.x / 32), Math.floor(this.y / 32) + 1)) {
							this.y += 32;
						}
					}
					if (event.keyCode == 65) {
						if (this.mappa.isWalkable(Math.floor(this.x / 32) - 1, Math.floor(this.y / 32))) {
							this.x -= 32;
						}
					}
					if (event.keyCode == 68) {
						if (this.mappa.isWalkable(Math.floor(this.x / 32) + 1, Math.floor(this.y / 32))) {
							this.x += 32;
						}
					}
				}
			case EKeyUp:
				trace('UP keyCode: ${event.keyCode}, charCode: ${event.charCode}');
				if (this.onMove > -1) {
					if (this.onMove == event.keyCode) {
						this.onMove = -1;
					}
				}
			case _:
		}
	}
}
