package js.npm.serialport.parser;

typedef ByteLengthOptions = {
	> js.node.stream.Transform.TransformNewOptions,

	/**
		The number of bytes on each data event.
	**/
	length:Int
}

/**
	A transform stream that emits data as a buffer after a specific number of bytes are received.
	Runs in O(n) time.
**/
@:jsRequire("serialport", "ByteLengthParser")
extern class ByteLengthParser extends js.node.stream.Transform<ByteLengthParser> {
	var length:Int;
	function new(options:ByteLengthOptions):Void;
}
