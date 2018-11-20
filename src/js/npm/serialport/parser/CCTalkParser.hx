package js.npm.serialport.parser;

@:jsRequire("@serialport/parser-cctalk")
extern class CCTalkParser extends js.node.stream.Transform<CCTalkParser> {
	function new() : Void;
}
