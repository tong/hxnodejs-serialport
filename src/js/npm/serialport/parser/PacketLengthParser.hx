package js.npm.serialport.parser;

import haxe.extern.EitherType;

typedef PacketLengthOptions = {
	> js.node.stream.Transform.TransformNewOptions,

	/**
		Delimiter(s) to use (defaults to `0xaa`).
	**/
	?delimiter:EitherType<Int, Array<Int>>,

	/**
		Delimiter length in bytes (defaults to `1`).
	**/
	?delimiterBytes:Int,

	/**
		Overhead of packet, including length, delimiter and any checksum / packet footer (defaults to `2`).
	**/
	?packetOverhead:Int,

	/**
		Number of bytes containing length (defaults to `1`).
	**/
	?lengthBytes:Int,

	/**
		Offset of length field (defaults to `1`).
	**/
	?lengthOffset:Int,

	/**
		Max packet length (defaults to `0xff`).
	**/
	?maxLen:Int
}

/**
	A transform stream that decodes packets with a delimiter and length of payload specified within the data stream.
	Decodes packets of the general form: `[delimiter][len][payload0] ... [payload0 + len]`
**/
@:jsRequire("serialport", "PacketLengthParser")
extern class PacketLengthParser extends js.node.stream.Transform<PacketLengthParser> {
	function new(?options:PacketLengthOptions):Void;
}
