package js.npm.serialport.parser;

import haxe.extern.EitherType;
import js.lib.RegExp;
import js.node.Buffer;

typedef RegexParserOptions = {
	> js.node.stream.Transform.TransformNewOptions,

	/**
		The regular expression to use to split incoming text.
		Note: Haxe `EReg` is not a JS `RegExp`, use `new js.lib.RegExp(...)`.
	**/
	regex:EitherType<RegExp, EitherType<String, Buffer>>,

	/**
		Defaults to `utf8`.
	**/
	?encoding:String
}

/**
	A transform stream that uses a regular expression to split the incoming text upon.
	Data is emitted as string controllable by the encoding option (defaults to `utf8`).
**/
@:jsRequire("serialport", "RegexParser")
extern class RegexParser extends js.node.stream.Transform<RegexParser> {
	var regex:RegExp;
	function new(options:RegexParserOptions):Void;
}
