package js.npm;

import js.Error;
import js.node.Buffer;
import js.node.events.EventEmitter;

@:enum abstract SerialPortEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
    var open : SerialPortEvent<Void->Void> = "open";
    var data : SerialPortEvent<Buffer->Void> = "data";
	var close : SerialPortEvent<Void->Void> = "close";
	var error : SerialPortEvent<Error->Void> = "error";
	var disconnect : SerialPortEvent<Void->Void> = "disconnect";
}

@:enum abstract BaudRate(Int) from Int to Int {
	var _115200 = 115200;
	var _57600 = 57600;
	var _38400 = 38400;
	var _19200 = 19200;
	var _9600 = 9600;
	var _4800 = 4800;
	var _2400 = 2400;
	var _1800 = 1800;
	var _1200 = 1200;
	var _600 = 600;
	var _300 = 300;
	var _200 = 200;
	var _150 = 150;
	var _134 = 134;
	var _110 = 110;
	var _75 = 75;
	var _50 = 50;
}

@:enum abstract DataBits(Int) from Int to Int {
	var _8 = 8;
	var _7 = 7;
	var _6 = 6;
	var _5 = 5;
}

@:enum abstract StopBits(Int) from Int to Int {
	var _1 = 1;
	var _2 = 2;
}

@:enum abstract Parity(String) from String to String {
	var none = 'none';
	var even = 'even';
	var mark = 'mark';
	var odd = 'odd';
	var space = 'space';
}

@:enum abstract FlowControl(String) from String to String {
	var _true = 'true';
	var xon = 'xon';
	var xoff = 'xoff';
	var xany = 'xany';
	var rtscts = 'rtscts';
}

typedef SerialPortInfo = {
	comName: String,
	manufacturer: String,
	serialNumber: String,
	pnpId: String,
	locationId: String,
	vendorId: String,
	productId: String
}

typedef SerialPortOptions = {
	?baudrate : BaudRate,
	?dataBits: DataBits,
	?stopBits: StopBits,
	?parity: Bool,
	?rtscts: Bool,
	?xon: Bool,
	?xoff: Bool,
	?xany: Bool,
	?flowControl: FlowControl,
	?bufferSize: Int,
	?parser: EventEmitter<SerialPort>->Buffer->Void,
	?vmin: Int, // Unix
	?vtime: Int // Unix
}

@:jsRequire("serialport","SerialPort")
extern class SerialPort extends EventEmitter<SerialPort> {

	function new( port : String, ?options : SerialPortOptions, ?openImmediately : Bool ) : Void;
	function open( ?callback : Error->Void ) : Void;
	function isOpen() : Bool;
	function write( buffer : Buffer, ?callback : Error->Buffer->Void ) : Bool;
	function pause() : Void;
	function resume() : Void;
	function flush( ?callback : Error->Void ) : Void;
	function drain( ?callback : Error->Void ) : Void;
	function close( ?callback : Error->Void ) : Void;
	function set( ?options : Dynamic, ?callback : Error->Dynamic->Void ) : Void;

	public static inline function list( callback : Error->Array<SerialPortInfo>->Void ) : Void
		js.Lib.require( 'serialport' ).list( callback );
}
