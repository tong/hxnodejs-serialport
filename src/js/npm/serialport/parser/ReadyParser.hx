package js.npm.serialport.parser;

import haxe.extern.EitherType;
import js.node.Buffer;
import js.node.events.EventEmitter;

enum abstract ReadyParserEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted once the ready sequence has been received.
	**/
	var ready:ReadyParserEvent<Void->Void> = "ready";
}

typedef ReadyParserOptions = {
	> js.node.stream.Transform.TransformNewOptions,

	/**
		Delimiter to use to detect the input is ready.
	**/
	delimiter:EitherType<String, EitherType<Buffer, Array<Int>>>
}

/**
	A transform stream that waits for a sequence of "ready" bytes before emitting a ready event and emitting data events.
	To use the Ready parser provide a byte start sequence.
	After the bytes have been received a ready event is fired and data events are passed through.
**/
@:jsRequire("serialport", "ReadyParser")
extern class ReadyParser extends js.node.stream.Transform<ReadyParser> {
	var delimiter:Buffer;
	var ready:Bool;
	function new(options:ReadyParserOptions):Void;
}
