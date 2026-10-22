package js.npm.serialport.parser;

import haxe.extern.EitherType;
import js.node.Buffer;

typedef DelimiterOptions = {
	> js.node.stream.Transform.TransformNewOptions,

	/**
		The delimiter on which to split incoming data.
	**/
	delimiter:EitherType<String, EitherType<Buffer, Array<Int>>>,

	/**
		Should the delimiter be included at the end of data (defaults to `false`).
	**/
	?includeDelimiter:Bool
}

/**
	A transform stream that emits data each time a byte sequence is received.
	To use the Delimiter parser, provide a delimiter as a string, buffer, or array of bytes.
	Runs in O(n) time.
**/
@:jsRequire("serialport", "DelimiterParser")
extern class DelimiterParser extends js.node.stream.Transform<DelimiterParser> {
	var includeDelimiter:Bool;
	var delimiter:Buffer;
	function new(options:DelimiterOptions):Void;
}
