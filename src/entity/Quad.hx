package entity;

import h2d.col.Point;

@:publicFields
class Quad {
	var x:Int;
	var y:Int;
	var w:Int;
	var h:Int;
	var l:Quad;
	var r:Quad;
	var leaf:Bool;
	var connected:Bool;

	public function new(X:Int, Y:Int, W:Int, H:Int) {
		this.x = X;
		this.y = Y;
		this.w = W;
		this.h = H;
		this.r = null;
		this.l = null;
		this.leaf = true;
		this.connected = false;
	}

	public function centro():Point {
		var cx:Int = Math.floor(this.x + (this.w / 2));
		var cy:Int = Math.floor(this.y + (this.h / 2));
		var ret:Point = new Point(cx, cy);
		return ret;
	}

	public function suddividi() {
		if (this.w > 15 || this.h > 15) {
			if (this.w > this.h) {
				this.leaf = false;
				var nw = Math.floor(this.w / 2) + Random.int(-5, 5);
				this.l = new Quad(this.x, this.y, nw, this.h);
				this.r = new Quad(this.x + nw, this.y, (this.w - nw), this.h);
			} else {
				this.leaf = false;
				var nh = Math.floor(this.h / 2) + Random.int(-5, 5);
				this.l = new Quad(this.x, this.y, this.w, nh);
				this.r = new Quad(this.x, this.y + nh, this.w, (this.h - nh));
			}
		}
	}
}
