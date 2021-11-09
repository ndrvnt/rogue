package ui;

import util.Myevent;

class IngButton extends h2d.Object {
	public function new(immagine:String, Evento:String) {
		super();
		var sprite = new h2d.Bitmap(hxd.Res.load(immagine).toTile());
		this.addChild(sprite);
		var interaction = new h2d.Interactive(sprite.width, sprite.height, this);
		interaction.onClick = function(event:hxd.Event) {
			Myevent.instance.emit(Evento);
		}
	}
}
