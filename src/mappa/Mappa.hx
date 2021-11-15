package mappa;

import h3d.parts.Data.Randomized;
import entity.Oggetto;
import entity.Enemy;
import entity.Hero;
import h2d.col.Point;
import entity.Quad;
import hxd.Math;
import entity.Tile;
import util.Myevent;

@:publicFields
class Mappa extends h2d.Object {
	var bg:h2d.Object;
	var entita:h2d.Object;
	var mappa:Array<Array<Tile>>;
	var mappaInt:Array<Array<Int>>;
	var hero:Hero;
	var mostri:Array<Enemy>;
	var oggetti:Array<Oggetto>;
	var heroStart:Point;
	var RIGHE:Int = 18; // 28; //
	var COLONNE:Int = 25; // 40; //

	public static final instance:Mappa = new Mappa();

	private function new() {
		super();
		this.bg = new h2d.Object();
		this.entita = new h2d.Object();
		this.addChild(this.bg);
		this.addChild(this.entita);
	}

	public function init() {
		this.hero = new Hero();
	}

	public function PulisciNemici() {
		for (m in this.mostri) {
			this.entita.removeChild(m);
		}
		this.mostri = [];
	}

	private function generaMappa() {
		this.mappaInt = new Array<Array<Int>>();
		for (y in 0...RIGHE) {
			this.mappaInt.push(new Array<Int>());
			for (x in 0...COLONNE) {
				this.mappaInt[y].push(-1);
			}
		}

		var q:Quad = new Quad(0, 0, this.COLONNE, this.RIGHE);
		q.suddividi();

		var lista:Array<Quad> = [q];
		var foglie:Array<Quad> = [];

		var tmp:Quad;
		while (lista.length != 0) {
			tmp = lista.pop();
			tmp.suddividi();

			if (tmp.l != null) {
				lista.push(tmp.l);
				lista.push(tmp.r);
			} else {
				if (tmp.w > 8 && tmp.h > 8) {
					foglie.push(tmp);
				}
			}
		}

		if (foglie.length == 1) {
			foglie = [];
			q.suddividi();
			lista.push(q);
			while (lista.length != 0) {
				tmp = lista.pop();
				tmp.suddividi();

				if (tmp.l != null) {
					lista.push(tmp.l);
					lista.push(tmp.r);
				} else {
					if (tmp.w > 8 && tmp.h > 8) {
						foglie.push(tmp);
					}
				}
			}
		}

		for (i in 0...foglie.length) {
			var offW:Int = Random.int(1, 4);
			var offH:Int = Random.int(1, 4);
			var offX:Int = Math.floor(offW / 2);
			var offY:Int = Math.floor(offH / 2);
			foglie[i].room = new Quad(foglie[i].x + offX, foglie[i].y + offY, foglie[i].w - offW, foglie[i].h - offH);
			this.generaStanza(foglie[i].x + offX, foglie[i].y + offY, foglie[i].w - offW, foglie[i].h - offH);
		}

		for (i in 0...(foglie.length - 1)) {
			var sq:Quad = foglie[i];
			var fq:Quad = foglie[i + 1];
			var c1:Point = sq.centro();
			var c2:Point = fq.centro();
			var dx = Math.floor(c1.x - c2.x) + 1;
			var dy = Math.floor(c1.y - c2.y) + 1;
			if (dx > dy) {
				// prima x e poi y
				var lastStep:Int = 0;
				for (X in 0...dx) {
					lastStep = X;
					this.mappaInt[Math.floor(c1.y)][Math.floor(c1.x - X)] = 0;
				}
				if (dy > 0) {
					for (Y in 0...dy) {
						this.mappaInt[Math.floor(c1.y - Y)][Math.floor(c1.x - lastStep)] = 0;
					}
				} else {
					dy = -1 * dy;
					for (Y in 0...dy) {
						this.mappaInt[Math.floor(c1.y + Y)][Math.floor(c1.x - lastStep)] = 0;
					}
				}
			} else {
				var lastStep:Int = 0;
				for (Y in 0...dy) {
					lastStep = Y;
					this.mappaInt[Math.floor(c1.y - Y)][Math.floor(c1.x)] = 0;
				}
				if (dx > 0) {
					for (X in 0...dx) {
						this.mappaInt[Math.floor(c1.y - lastStep)][Math.floor(c1.x - X)] = 0;
					}
				} else {
					dx = -1 * dx;
					for (X in 0...dx) {
						this.mappaInt[Math.floor(c1.y - lastStep)][Math.floor(c1.x + X)] = 0;
					}
				}
			}
		}

		for (y in 0...this.RIGHE) {
			for (x in 0...this.COLONNE) {
				if (this.mappaInt[y][x] == 0) {
					if (this.mappaInt[y + 1][x] == -1) {
						this.mappaInt[y + 1][x] = 1;
					}
					if (this.mappaInt[y - 1][x] == -1) {
						this.mappaInt[y - 1][x] = 1;
					}
					if (this.mappaInt[y][x + 1] == -1) {
						this.mappaInt[y][x + 1] = 1;
					}
					if (this.mappaInt[y][x - 1] == -1) {
						this.mappaInt[y][x - 1] = 1;
					}

					if (this.mappaInt[y - 1][x - 1] == -1) {
						this.mappaInt[y - 1][x - 1] = 1;
					}
					if (this.mappaInt[y + 1][x - 1] == -1) {
						this.mappaInt[y + 1][x - 1] = 1;
					}
					if (this.mappaInt[y + 1][x + 1] == -1) {
						this.mappaInt[y + 1][x + 1] = 1;
					}
					if (this.mappaInt[y - 1][x + 1] == -1) {
						this.mappaInt[y - 1][x + 1] = 1;
					}
				}
			}
		}

		// l'eroe parte dalla prima stanza
		this.entita.removeChildren();
		this.entita.addChild(this.hero);
		this.hero.setPos(foglie[0].centro());

		this.mostri = new Array<Enemy>();
		var nm:Int = Random.int(2, 4);
		for (n in 0...nm) {
			var nf:Int = Random.int(1, foglie.length - 1);
			var tmp:Enemy = new Enemy(foglie[nf].randomPoint());
			this.mostri.push(tmp);
			this.entita.addChild(tmp);
		}

		this.oggetti = new Array<Oggetto>();
		nm = Random.int(1, 3);
		for (n in 0...nm) {
			var nf:Int = Random.int(1, foglie.length - 1);
			var tmp:Oggetto = new Oggetto(foglie[nf].randomPoint(), this.dammiOggetto());
			this.oggetti.push(tmp);
			this.entita.addChild(tmp);
		}

		var t:Point = foglie[foglie.length - 1].randomPoint();
		this.mappaInt[Math.ceil(t.y)][Math.ceil(t.x)] = 2;
	}

	public function generaTabella() {
		this.generaMappa();
		this.mappa = new Array<Array<Tile>>();

		this.bg.addChild(new h2d.Bitmap(hxd.Res.human_m.toTile()));
		for (y in 0...RIGHE) {
			this.mappa.push(new Array<Tile>());
			for (x in 0...COLONNE) {
				var tmpTile = new Tile(this.mappaInt[y][x], (x * 32), (y * 32));
				this.mappa[y].push(tmpTile);
				this.bg.addChild(tmpTile);
			}
		}
	}

	private function dammiOggetto():Int {
		var i:Int = Random.int(1, 100);
		if (i < 80) {
			return 1;
		} else {
			return 2;
		}
	}

	public function muoviEnemy() {
		for (i in 0...this.mostri.length) {
			//	trace(this.mostri[i]);
			this.mostri[i].muovi();
		}
	}

	public function isWalkable(X:Int, Y:Int):Bool {
		return (this.mappa[Y][X].tipo == 0 || this.mappa[Y][X].tipo == 2);
	}

	public function isStair(X:Int, Y:Int):Bool {
		trace(this.mappa[Y][X].tipo);
		return (this.mappa[Y][X].tipo == 2);
	}

	public function controlloFight() {
		var ind:Int = -1;
		for (i in 0...this.mostri.length) {
			if (this.mostri[i].x == this.hero.x && this.mostri[i].y == this.hero.y) {
				// combattimento
				if (this.hero.hp > this.mostri[i].hp) {
					this.hero.hp -= this.mostri[i].hp;
					this.mostri[i].morto = true;
					ind = i;
					trace(this.hero.hp);
				} else {
					// TODO: morto
					trace("#### MORTO###");
					Game.instance.morteHero();
					break;
				}
			}
		}
		if (ind > -1) {
			this.mostri.splice(ind, 1)[0].muori();
		}
	}

	public function collisioneOggetti(X:Float, Y:Float):Oggetto {
		this.controlloFight();
		var trovato:Oggetto = null;
		var ind:Int = -1;
		for (i in 0...this.oggetti.length) {
			if (this.oggetti[i].x == X && this.oggetti[i].y == Y) {
				ind = i;
			}
		}
		if (ind > -1) {
			trovato = this.oggetti.splice(ind, 1)[0];
			this.entita.removeChild(trovato);
		}
		return trovato;
	}

	private function generaStanza(X:Int, Y:Int, W:Int, H:Int) {
		var WW:Int = X + W;
		var HH:Int = Y + H;
		for (y in Y...HH) {
			for (x in X...WW) {
				if (y == Y || y == HH - 1 || x == X || x == WW - 1) {
					this.mappaInt[y][x] = 1;
				} else {
					this.mappaInt[y][x] = 0;
				}
			}
		}
	}
}
