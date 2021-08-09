package entity;

import mappa.Mappa;

class Hero extends Entity {
	var hp:Int = 50;
	var mappa:Mappa;

	override public function new(X:Int, Y:Int) {
		super();
		this.x = X;
		this.y = Y;
		this.sprite = new h2d.Bitmap(hxd.Res.human_m.toTile());
		this.addChild(this.sprite);
		this.mappa = Mappa.instance;
		hxd.Window.getInstance().addEventTarget(this.movimento);
	}

	public function movimento(event:hxd.Event) {}
}
