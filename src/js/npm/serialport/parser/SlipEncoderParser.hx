package js.npm.serialport.parser;

@:jsRequire("@serialport/parser-slip-encoder")
extern class SlipEncoderParser extends js.node.stream.Transform<SlipEncoderParser> {
	function new( options: { bluetoothQuirk: Bool } ) : Void;
}
