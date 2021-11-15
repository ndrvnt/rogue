package entity;

import mappa.Mappa;
import util.Myevent;
import h2d.col.Point;

class Oggetto extends Entity {
	var consumabile:Bool;

	override public function new(pos:Point, tipo:Int) {
		super();
		this.tipo = tipo;
		this.x = pos.x * 32;
		this.y = pos.y * 32;
		this.sprite = this.getSprite();
		this.addChild(this.sprite);
	}

	private function getSprite():h2d.Bitmap {
		var sprite:h2d.Bitmap;
		switch (this.tipo) {
			case 1:
				sprite = new h2d.Bitmap(hxd.Res.cyan.toTile());
			case 2:
				sprite = new h2d.Bitmap(hxd.Res.opal.toTile());
			case _:
				sprite = new h2d.Bitmap(hxd.Res.cyan.toTile());
		}

		return sprite;
	}

	public function usa(target:Mappa) {
		trace(this.tipo);
		switch (this.tipo) {
			case 1:
				target.hero.hp += 100;
			case 2:
				target.PulisciNemici();
			case _:
				target.hero.hp += 100;
		}
	}
}
