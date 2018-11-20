package js.npm.serialport.parser;

import haxe.extern.EitherType;
import js.node.Buffer;

@:jsRequire("@serialport/parser-delimiter")
extern class DelimiterParser extends js.node.stream.Transform<DelimiterParser> {
	function new( options: { delimiter: EitherType<String,EitherType<Buffer,Array<Int>>>, ?includeDelimiter : Bool } ) : Void;
}
