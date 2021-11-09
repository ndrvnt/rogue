package ui;

import h2d.Bitmap;

class BGImage extends h2d.Object {
	var sfondo:h2d.Bitmap;

	public function new() {
		super();
	}

	public function init() {
		this.sfondo = new h2d.Bitmap(hxd.Res.bg_image.menubg.toTile());
		this.addChild(this.sfondo);
	}

	public function cambiaSfondo(nomeFile:String) {
		this.removeChild(this.sfondo);
		this.sfondo = new h2d.Bitmap(hxd.Res.load(nomeFile).toTile());
		this.addChild(this.sfondo);
	}

	public function getWidth():Float {
		return this.sfondo.width;
	}

	public function getHeight():Float {
		return this.sfondo.height;
	}
}
