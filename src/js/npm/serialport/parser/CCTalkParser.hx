package js.npm.serialport.parser;

/**
	A transform stream that emits `ccTalk` packets as they are received.

	@see https://en.wikipedia.org/wiki/CcTalk
**/
@:jsRequire("serialport", "CCTalkParser")
extern class CCTalkParser extends js.node.stream.Transform<CCTalkParser> {
	var maxDelayBetweenBytesMs:Int;

	/**
		@param maxDelayBetweenBytesMs Defaults to `50`.
	**/
	function new(?maxDelayBetweenBytesMs:Int):Void;
}
