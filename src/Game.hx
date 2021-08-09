import mappa.Mappa;

@:publicFields
class Game extends hxd.App {
	var mappa:Mappa;

	override function init() {
		super.init();
		var myscene = new h2d.Scene(); // create a new scene
		setScene(myscene); // set it as the current scene
		this.mappa = Mappa.instance;

		myscene.addChild(this.mappa.generaTabella());
	}

	override function update(dt:Float):Void {}

	private function controlloHit() {}

	public static var inst:Game;

	static function main() {
		#if js
		hxd.Res.initEmbed();
		#else
		hxd.res.Resource.LIVE_UPDATE = true;
		hxd.Res.initLocal();
		#end
		inst = new Game();
	}
}
