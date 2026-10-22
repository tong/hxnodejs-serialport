package js.npm.serialport.parser;

import haxe.extern.EitherType;
import js.node.Buffer;

typedef ReadlineOptions = {
	> js.node.stream.Transform.TransformNewOptions,

	/**
		Delimiter to use (defaults to `\n`).
	**/
	?delimiter:EitherType<String, EitherType<Buffer, Array<Int>>>,

	/**
		Include the delimiter at the end of the packet (defaults to `false`).
	**/
	?includeDelimiter:Bool,

	/**
		Defaults to `utf8`.
	**/
	?encoding:String
}

/**
	A transform stream that emits data after a newline delimiter is received.
	To use the Readline parser, provide a delimiter (defaults to `\n`).
	Data is emitted as string controllable by the encoding option (defaults to `utf8`).
**/
@:jsRequire("serialport", "ReadlineParser")
extern class ReadlineParser extends js.node.stream.Transform<ReadlineParser> {
	var includeDelimiter:Bool;
	var delimiter:Buffer;
	function new(?options:ReadlineOptions):Void;
}
