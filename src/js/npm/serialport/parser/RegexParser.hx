package js.npm.serialport.parser;

@:jsRequire("@serialport/parser-regex")
extern class RegexParser extends js.node.stream.Transform<RegexParser> {
	function new( options: { regex: EReg, ?encoding : String } ) : Void;
}
