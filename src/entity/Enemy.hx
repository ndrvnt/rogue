package entity;

import h2d.col.Point;

class Enemy extends Entity {
	override public function new(pos:Point) {
		super();
		this.x = pos.x * 32;
		this.y = pos.y * 32;
		this.hp = 25;
		this.sprite = this.getSprite();
		this.addChild(this.sprite);
		this.gg = Game.instance;
	}

	private function getSprite():h2d.Bitmap {
		var sprite:h2d.Bitmap = new h2d.Bitmap(hxd.Res.demonspawn_red_m.toTile());
		this.hp = 20;
		return sprite;
	}

	public function muovi() {
		var hX:Float = this.gg.mappa.hero.x;
		var hY:Float = this.gg.mappa.hero.y;

		var dx:Int = Math.floor(hX / 32 - this.x / 32);
		var dy:Int = Math.floor(hY - this.y);

		var move:Bool = false;

		if (dx > dy) {
			if (dx > 0) {
				if (this.gg.mappa.isWalkable(Math.floor(this.x / 32) + 1, Math.floor(this.y / 32))) {
					move = true;
					this.x += 32;
				}
			} else {
				if (this.gg.mappa.isWalkable(Math.floor(this.x / 32) - 1, Math.floor(this.y / 32))) {
					move = true;
					this.x -= 32;
				}
			}

			if (!move) {
				if (dy > 0) {
					if (this.gg.mappa.isWalkable(Math.floor(this.x / 32), Math.floor(this.y / 32) + 1)) {
						move = true;
						this.y += 32;
					}
				} else {
					if (this.gg.mappa.isWalkable(Math.floor(this.x / 32), Math.floor(this.y / 32) - 1)) {
						move = true;
						this.y -= 32;
					}
				}
			}
		} else {
			if (dy > 0) {
				if (this.gg.mappa.isWalkable(Math.floor(this.x / 32), Math.floor(this.y / 32) + 1)) {
					move = true;
					this.y += 32;
				}
			} else {
				if (this.gg.mappa.isWalkable(Math.floor(this.x / 32), Math.floor(this.y / 32) - 1)) {
					move = true;
					this.y -= 32;
				}
			}

			if (!move) {
				if (dx > 0) {
					if (this.gg.mappa.isWalkable(Math.floor(this.x / 32) + 1, Math.floor(this.y / 32))) {
						move = true;
						this.x += 32;
					}
				} else {
					if (this.gg.mappa.isWalkable(Math.floor(this.x / 32) - 1, Math.floor(this.y / 32))) {
						move = true;
						this.x -= 32;
					}
				}
			}
		}
		this.gg.mappa.controlloFight();
	}

	public function muori() {
		this.removeChild(this.sprite);
	}
}
