package js.npm.serialport.parser;

typedef InterByteTimeoutOptions = {
	> js.node.stream.Transform.TransformNewOptions,

	/**
		The period of silence in milliseconds after which data is emitted.
	**/
	interval:Int,

	/**
		The maximum number of bytes after which data will be emitted (defaults to `65536`).
	**/
	?maxBufferSize:Int
}

/**
	A transform stream that buffers data and emits it after not receiving any bytes for the specified amount of time or hitting a max buffer size.
**/
@:jsRequire("serialport", "InterByteTimeoutParser")
extern class InterByteTimeoutParser extends js.node.stream.Transform<InterByteTimeoutParser> {
	var maxBufferSize:Int;
	var interval:Int;
	function new(options:InterByteTimeoutOptions):Void;
}
