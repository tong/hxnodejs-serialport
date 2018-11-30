package js.npm.serialport.parser;

import haxe.extern.EitherType;
import js.node.Buffer;

/**
	A transform stream that emits data each time a byte sequence is received.
	To use the Delimiter parser, provide a delimiter as a string, buffer, or array of bytes.
	Runs in O(n) time.
**/
@:jsRequire("@serialport/parser-delimiter")
extern class DelimiterParser extends js.node.stream.Transform<DelimiterParser> {
	function new( options: { delimiter: EitherType<String,EitherType<Buffer,Array<Int>>> } ) : Void;
}
