package js.npm.serialport.parser;

typedef SlipEncoderOptions = {
	> SlipDecoder.SlipDecoderOptions,

	/**
		Adds an END character at the beginning of each packet per the Bluetooth Core Specification 4.0, Volume 4, Part D, Chapter 3 "SLIP Layer" and allowed by RFC 1055.
	**/
	?bluetoothQuirk:Bool
}

/**
	A transform stream that emits SLIP-encoded data for each incoming packet.
	Runs in O(n) time, adding a 0xC0 character at the end of each received packet and escaping characters, according to RFC 1055.
**/
@:jsRequire("serialport", "SlipEncoder")
extern class SlipEncoder extends js.node.stream.Transform<SlipEncoder> {
	function new(?options:SlipEncoderOptions):Void;
}
