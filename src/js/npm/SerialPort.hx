package js.npm;

import js.node.Buffer;
import js.node.events.EventEmitter;

typedef SerialportInfo = {
	comName: String,
	manufacturer: String,
	serialNumber: String,
	pnpId: String,
	locationId: String,
	vendorId: String,
	productId: String
}

typedef SerialportOptions = {
	?baudrate : Int,
	?dataBits: Int,
	?stopBits: Int,
	?parity: Int,
	?rtscts: Int,
	?xon: Bool,
	?xoff: Bool,
	?xany: Bool,
	?flowControl: Bool,
	?bufferSize: Int,
	?vmin: Int, // Unix
	?vtime: Int // Unix
}

@:jsRequire("serialport","SerialPort")
extern class SerialPort extends EventEmitter<Dynamic> {

	function new( port : String, ?options : SerialportOptions, ?openImmediately : Bool ) : Void;
	function open( ?callback : Error->Void ) : Void;
	function isOpen() : Bool;
	function write( buffer : Buffer, ?callback : Error->Buffer->Void ) : Bool;
	function pause() : Void;
	function resume() : Void;
	function flush( ?callback : Error->Void ) : Void;
	function drain( ?callback : Error->Void ) : Void;
	function close( ?callback : Error->Void ) : Void;
	function set( ?options : Dynamic, ?callback : Error->Dynamic->Void ) : Void;

	public static inline function list( callback : Error->Array<SerialportInfo>->Void ) : Void
		js.Lib.require( 'serialport' ).list( callback );
}
