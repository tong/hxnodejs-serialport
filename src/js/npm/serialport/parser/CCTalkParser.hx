package js.npm.serialport.parser;

/**
	A transform stream that emits `ccTalk` packets as they are received.

	@see https://en.wikipedia.org/wiki/CcTalk
**/
@:jsRequire("@serialport/parser-cctalk")
extern class CCTalkParser extends js.node.stream.Transform<CCTalkParser> {
	function new() : Void;
}
