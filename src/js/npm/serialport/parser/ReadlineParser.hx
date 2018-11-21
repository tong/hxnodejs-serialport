package js.npm.serialport.parser;

@:jsRequire("@serialport/parser-readline")
extern class ReadlineParser extends js.node.stream.Transform<ReadlineParser> {
	function new( ?options: { delimiter: String, ?encoding : String } ) : Void;
}
