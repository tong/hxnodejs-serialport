package js.npm.serialport.parser;

@:jsRequire("@serialport/parser-ready")
extern class ReadyParser extends js.node.stream.Transform<ReadyParser> {
	function new( options: { ?delimiter: String } ) : Void;
}
