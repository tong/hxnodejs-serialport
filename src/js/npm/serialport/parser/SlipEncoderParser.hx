package js.npm.serialport.parser;

/**
	A transform stream that emits SLIP-encoded data for each incoming packet.
	Unlike most parsers this one is useful for processing input to the serialport instead of output.
	Runs in O(n) time, adding a 0xC0 character at the end of each received packet and escaping characters, according to RFC 1055. Runs in O(n) time.
**/
@:jsRequire("@serialport/parser-slip-encoder")
extern class SlipEncoderParser extends js.node.stream.Transform<SlipEncoderParser> {
	function new( options : { bluetoothQuirk : Bool } ) : Void;
}
