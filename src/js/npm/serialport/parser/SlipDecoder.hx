package js.npm.serialport.parser;

typedef SlipDecoderOptions = {
	> js.node.stream.Transform.TransformNewOptions,

	/**
		Custom start byte.
	**/
	?START:Int,

	/**
		Custom start escape byte.
	**/
	?ESC_START:Int,

	/**
		Custom escape byte.
	**/
	?ESC:Int,

	/**
		Custom end byte.
	**/
	?END:Int,

	/**
		Custom escape end byte.
	**/
	?ESC_END:Int,

	/**
		Custom escape escape byte.
	**/
	?ESC_ESC:Int
}

/**
	A transform stream that decodes SLIP encoded data.
	Runs in O(n) time, stripping out slip encoding and emitting decoded data.
	Optionally custom slip escape and delimiters can be provided.
**/
@:jsRequire("serialport", "SlipDecoder")
extern class SlipDecoder extends js.node.stream.Transform<SlipDecoder> {
	function new(?options:SlipDecoderOptions):Void;
}
