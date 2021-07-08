package js.npm.serialport.parser;

/**
	A transform stream that emits data each time a complete, correctly formatted Space Packet is received.
    Configure the parser with the lengths of the Time Code Field and Ancillary Data Field.
    (These don't need to be present on every packet received; their presence should be indicated in the individual packet header; however their length should be standardized between the sender and receiver.)
**/
@:jsRequire("@serialport/parser-spacepacket")
extern class SpacePacketParser extends js.node.stream.Transform<SpacePacketParser> {
	function new( options: { ?timeCodeFieldLength : Int, ?ancillaryDataFieldLength : Int } ) : Void;
}
