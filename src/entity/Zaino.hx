package entity;

@:publicFields
class Zaino extends h2d.Object {
	var inventario:Array<Oggetto>;

	public static final instance:Zaino = new Zaino();

	private function new() {
		super();

		this.inventario = new Array<Oggetto>();
	}

	public function aggiungi(ogg:Oggetto) {
		this.inventario.push(ogg);
		this.disegna();
	}

	private function disegna() {
		this.removeChildren();
		for (ind in 0...this.inventario.length) {
			this.inventario[ind].x = 0;
			this.inventario[ind].y = ind * 32;
			this.addChild(this.inventario[ind]);
		}
	}
}
