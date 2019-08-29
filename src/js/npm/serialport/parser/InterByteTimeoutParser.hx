package js.npm.serialport.parser;

/**
	A transform stream that emits data as a buffer after not recieving any bytes for the specified amount of time.
**/
@:jsRequire("@serialport/parser-inter-byte-timeout")
extern class InterByteTimeoutParser extends js.node.stream.Transform<InterByteTimeoutParser> {
	function new(options:{interval:Int, ?maxBufferSize:Int}):Void;
}
