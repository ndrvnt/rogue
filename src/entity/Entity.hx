package entity;

@:publicFields
class Entity extends h2d.Object {
	var sprite:h2d.Bitmap;
	var tipo:Int;

	public function new() {
		super();
	}

	public function update(dt:Float) {}

	public function delete() {}

	public function colpito(danno:Float) {}

	public function iscolpito(obj:Entity) {}
}
