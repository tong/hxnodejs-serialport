package js.npm.serialport.parser;

/**
	A transform stream that waits for a sequence of "ready" bytes before emitting a ready event and emitting data events
	To use the Ready parser provide a byte start sequence.
	After the bytes have been received a ready event is fired and data events are passed through.
**/
@:jsRequire("@serialport/parser-ready")
extern class ReadyParser extends js.node.stream.Transform<ReadyParser> {
	function new( options: { ?delimiter: String } ) : Void;
}
