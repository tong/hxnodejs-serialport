package js.npm.serialport.parser;

/**
	A transform stream that emits data as a buffer after a specific number of bytes are received.
	Runs in O(n) time.
**/
@:jsRequire("@serialport/parser-byte-length")
extern class ByteLengthParser extends js.node.stream.Transform<ByteLengthParser> {
	function new( options: { length : Int } ) : Void;
}
