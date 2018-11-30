package js.npm.serialport.parser;

/**
	A transform stream that emits data after a newline delimiter is received.
	To use the Readline parser, provide a delimiter (defaults to \n).
	Data is emitted as string controllable by the encoding option (defaults to utf8).
**/
@:jsRequire("@serialport/parser-readline")
extern class ReadlineParser extends js.node.stream.Transform<ReadlineParser> {
	function new( ?options: { ?delimiter: String, ?encoding : String } ) : Void;
}
