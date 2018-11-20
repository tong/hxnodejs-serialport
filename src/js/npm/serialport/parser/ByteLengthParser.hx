package js.npm.serialport.parser;

@:jsRequire("@serialport/parser-byte-length")
extern class ByteLengthParser extends js.node.stream.Transform<ByteLengthParser> {
	function new( options: { length: Int } ) : Void;
}
