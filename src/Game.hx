import mappa.Inventario;
import mappa.Mappa;

@:publicFields
class Game extends hxd.App {
	var mappa:Mappa;
	var inventario:Inventario;
	var scenaMappa:h2d.Scene;
	var scenaInventario:h2d.Scene;
	var cambio:Bool = true;

	override function init() {
		super.init();
		this.scenaMappa = new h2d.Scene(); // create a new scene
		this.scenaInventario = new h2d.Scene();
		this.mappa = Mappa.instance;
		this.inventario = Inventario.instance;
		this.scenaInventario.addChild(this.inventario);
		scenaMappa.addChild(this.mappa);
		this.mappa.generaTabella();
		setScene(this.scenaMappa); // set it as the current scene
	}

	public function mostraInventario() {
		if (this.cambio) {
			this.cambio = false;
			this.mappa.hero.disattiva();
			this.inventario.attiva();
			this.inventario.aggiorna();
			setScene(this.scenaInventario);
			var timer = new haxe.Timer(500);
			timer.run = function() {
				this.cambio = true;
			}
		}
		// setScene(this.scenaInventario);
	}

	public function mostraMappa() {
		if (this.cambio) {
			this.cambio = false;
			this.mappa.hero.attiva();
			this.inventario.disattiva();
			setScene(this.scenaMappa);
			var timer = new haxe.Timer(500);
			timer.run = function() {
				this.cambio = true;
			}
		}
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
