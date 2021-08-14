import mappa.Inventario;
import mappa.Mappa;

@:publicFields
class Game extends hxd.App {
	var mappa:Mappa;
	var inventario:Inventario;
	var scenaMappa:h2d.Scene;
	var scenaInventario:h2d.Scene;

	override function init() {
		super.init();
		this.scenaMappa = new h2d.Scene(); // create a new scene
		setScene(this.scenaMappa); // set it as the current scene
		this.mappa = Mappa.instance;
		scenaMappa.addChild(this.mappa);
		this.mappa.generaTabella();
		this.scenaInventario = new h2d.Scene();
		this.inventario = Inventario.instance;
		this.scenaInventario.addChild(this.inventario);
	}

	public function mostraInventario() {
		this.inventario.aggiorna();
		setScene(this.scenaInventario);
	}

	public function mostraMappa() {
		setScene(this.scenaMappa);
	}

	override function update(dt:Float):Void {}

	private function controlloHit() {}

	public static var instance:Game;

	static function main() {
		#if js
		hxd.Res.initEmbed();
		#else
		hxd.res.Resource.LIVE_UPDATE = true;
		hxd.Res.initLocal();
		#end
		instance = new Game();
	}
}
