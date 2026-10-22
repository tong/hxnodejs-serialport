package js.npm.serialport.parser;

import haxe.extern.EitherType;

typedef SpacePacketHeader = {
	versionNumber:EitherType<String, Int>,
	identification:{
		apid:Int,
		secondaryHeader:Int,
		type:Int
	},
	sequenceControl:{
		packetName:Int,
		sequenceFlags:Int
	},
	dataLength:Int
}

/**
	Object emitted by `SpacePacketParser` on `data`.
**/
typedef SpacePacket = {
	header:SpacePacketHeader,
	?secondaryHeader:{
		?timeCode:String,
		?ancillaryData:String
	},
	data:String
}

typedef SpacePacketOptions = {
	> js.node.stream.Transform.TransformNewOptions,

	/**
		The length of the Time Code Field in octets, if present.
	**/
	?timeCodeFieldLength:Int,

	/**
		The length of the Ancillary Data Field in octets, if present.
	**/
	?ancillaryDataFieldLength:Int
}

/**
	A transform stream that accepts a stream of octet data and converts it into an object representation of a CCSDS Space Packet.

	@see https://public.ccsds.org/Pubs/133x0b2e1.pdf
**/
@:jsRequire("serialport", "SpacePacketParser")
extern class SpacePacketParser extends js.node.stream.Transform<SpacePacketParser> {
	function new(?options:SpacePacketOptions):Void;
}
