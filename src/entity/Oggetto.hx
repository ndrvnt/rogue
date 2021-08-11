package entity;

import h2d.col.Point;

class Oggetto extends Entity {
	override public function new(pos:Point) {
		super();
		this.x = pos.x * 32;
		this.y = pos.y * 32;
		this.sprite = this.getSprite();
		this.addChild(this.sprite);
	}

	private function getSprite():h2d.Bitmap {
		var sprite:h2d.Bitmap = new h2d.Bitmap(hxd.Res.cyan.toTile());
		return sprite;
	}

	public function usa(target:Entity) {
		target.hp += 100;
	}
}
