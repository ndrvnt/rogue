package entity;

import mappa.Mappa;

@:publicFields
class Tile extends Entity {
	var mappa:Mappa;

	override public function new(tipo:Int, X:Int, Y:Int) {
		super();
		this.tipo = tipo;
		this.sprite = this.getSprite();
		this.addChild(this.sprite);
		this.x = X;
		this.y = Y;
		this.mappa = Mappa.instance;
	}

	// override public function update(dt:Float) {}
	public function isWalkable():Bool {
		return (this.tipo == 0);
	}

	private function getSprite():h2d.Bitmap {
		var sprite:h2d.Bitmap = new h2d.Bitmap(hxd.Res.pavimento.dngn_unseen.toTile());
		switch (this.tipo) {
			case 0: // floor
				// sprite = new h2d.Bitmap(hxd.Res.floor.crystal_floor5.toTile());
				var t:Int = Random.int(1, 5);
				switch (t) {
					case 1: sprite = new h2d.Bitmap(hxd.Res.pavimento.crystal_floor1.toTile());
					case 2: sprite = new h2d.Bitmap(hxd.Res.pavimento.crystal_floor2.toTile());
					case 3: sprite = new h2d.Bitmap(hxd.Res.pavimento.crystal_floor3.toTile());
					case 4: sprite = new h2d.Bitmap(hxd.Res.pavimento.crystal_floor4.toTile());
					case 5: sprite = new h2d.Bitmap(hxd.Res.pavimento.crystal_floor5.toTile());
				}
			case 1: // wall
				// sprite = new h2d.Bitmap(hxd.Res.muro.brick_gray0.toTile());
				var t:Int = Random.int(0, 3);
				switch (t) {
					case 0: sprite = new h2d.Bitmap(hxd.Res.muro.brick_gray0.toTile());
					case 1: sprite = new h2d.Bitmap(hxd.Res.muro.brick_gray1.toTile());
					case 2: sprite = new h2d.Bitmap(hxd.Res.muro.brick_gray2.toTile());
					case 3: sprite = new h2d.Bitmap(hxd.Res.muro.brick_gray3.toTile());
				}
			case 2: // wall
				sprite = new h2d.Bitmap(hxd.Res.pavimento.stairs_down.toTile());
			case 3: // wall
				sprite = new h2d.Bitmap(hxd.Res.deco.elephant_statue.toTile());
			case 4: // wall
				sprite = new h2d.Bitmap(hxd.Res.arrow.toTile());
			case 5: // wall
				sprite = new h2d.Bitmap(hxd.Res.flail.toTile());
			case _:
				sprite = new h2d.Bitmap(hxd.Res.pavimento.dngn_unseen.toTile());
				// return sprite;
		}
		return sprite;
	}
}
