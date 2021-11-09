package util;

// import h2d.domkit.Object;
// @:publicFields
// class Evento {
// 	var nome:String;
// 	var fun:Object->Void;
// }
class Myevent {
	private var eventi:Map<String, Int->Void>;

	public static final instance:Myevent = new Myevent();

	private function new() {
		this.eventi = new Map<String, Int->Void>();
	}

	public function on(nome:String, f:Int->Void) {
		this.eventi[nome] = f;
	}

	public function emit(nome:String, param:Int) {
		this.eventi[nome](param);
	}
}
