package js.npm.serialport.parser;

/**
	A transform stream that uses a regular expression to split the incoming text upon.
	To use the Regex parser provide a regular expression to split the incoming text upon.
	Data is emitted as string controllable by the encoding option (defaults to utf8).
**/
@:jsRequire("@serialport/parser-regex")
extern class RegexParser extends js.node.stream.Transform<RegexParser> {
	function new( options: { regex : EReg, ?encoding : String } ) : Void;
}
