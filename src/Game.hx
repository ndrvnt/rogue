import scene.Gameover;
import scene.Menu;
import mappa.Inventario;
import mappa.Mappa;

@:publicFields
class Game extends hxd.App {
	var mappa:Mappa;
	var inventario:Inventario;
	var scenaMappa:h2d.Scene;
	var scenaInventario:h2d.Scene;
	var scenaMenu:h2d.Scene;
	var scenaGameover:h2d.Scene;
	var cambio:Bool = true;
	var menu:Menu;
	var gameover:Gameover;

	override function init() {
		super.init();
		this.scenaMappa = new h2d.Scene();
		this.scenaInventario = new h2d.Scene();
		this.scenaMenu = new h2d.Scene();
		this.scenaGameover = new h2d.Scene();
		this.menu = Menu.instance;
		this.menu.init();
		this.scenaMenu.addChild(this.menu);
		this.gameover = Gameover.instance;
		this.gameover.init();
		this.scenaGameover.addChild(this.gameover);
		this.mappa = Mappa.instance;
		this.inventario = Inventario.instance;
		this.scenaInventario.addChild(this.inventario);
		scenaMappa.addChild(this.mappa);
		this.mappa.generaTabella();
		setScene(this.scenaMenu);
	}

	public function mostraInventario() {
		if (this.cambio) {
			this.cambio = false;
			this.inventario.aggiorna();
			setScene(this.scenaInventario);
			var timer = new haxe.Timer(500);
			timer.run = function() {
				this.cambio = true;
			}
		}
	}

	public function mostraMappa() {
		if (this.cambio) {
			this.cambio = false;
			setScene(this.scenaMappa);
			var timer = new haxe.Timer(500);
			timer.run = function() {
				this.cambio = true;
			}
		}
	}

	public function inizioGioco() {
		this.mostraMappa();
	}

	public function morteHero() {
		this.inventario.svuota();
		this.mappa.hero.menu = true;
		this.mappa.generaTabella();
		setScene(this.scenaGameover);
	}

	public function cambiaMappa() {
		this.mappa.generaTabella();
		///setScene(this.scenaGameover);
	}

	override function update(dt:Float):Void {}

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
