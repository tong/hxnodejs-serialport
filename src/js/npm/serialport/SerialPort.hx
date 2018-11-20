package js.npm.serialport;

import haxe.extern.EitherType;
import js.Error;
import js.node.Buffer;
import js.node.events.EventEmitter;

@:enum abstract SerialPortEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {

    /**
        Callback is called with no arguments when the port is opened and ready for writing.
    */
    var open : SerialPortEvent<Void->Void> = "open";

    /**
        Callback is called with data depending on your chosen parser.
    */
    var data : SerialPortEvent<Buffer->Void> = "data";

    /**
        Callback is called with no arguments when the port is closed.
    */
    var close : SerialPortEvent<Void->Void> = "close";

    /**
        Callback is called with an error object whenever there is an error.
    */
	var error : SerialPortEvent<Error->Void> = "error";

    /**
        Callback is called with an error object.
        This will always happen before a close event if a disconnection is detected.
    */
	var disconnect : SerialPortEvent<Void->Void> = "disconnect";
}

/**
    Rate at which information is transferred  (bits per second).
*/
@:enum abstract BaudRate(Int) to Int {
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

/**
    Number of data bits to transmit.
*/
@:enum abstract DataBits(Int) from Int to Int {
	var _8 = 8;
	var _7 = 7;
	var _6 = 6;
	var _5 = 5;
}

/**
    Number of bits used to indicate the end of a byte.
*/
@:enum abstract StopBits(Int) from Int to Int {
	var _1 = 1;
	var _2 = 2;
}

/**
    Type of parity checking.
*/
@:enum abstract Parity(String) to String {
	var none = 'none';
	var even = 'even';
	var mark = 'mark';
	var odd = 'odd';
	var space = 'space';
}

typedef SerialPortInfo = {
	comName: String,
	?manufacturer: String,
	?serialNumber: String,
	?pnpId: String,
	?locationId: String,
	?vendorId: String,
	?productId: String
}

typedef SerialPortOptions = {
    ?autoOpen: Bool,
    ?baudRate : BaudRate,
    ?dataBits: DataBits,
	?hupcl : Bool,
	?lock: Bool,
	?parity: Bool,
	?rtscts: Bool,
	?stopBits: StopBits,
	?xany: Bool,
	?xoff: Bool,
	?xon: Bool,
    ?highWaterMark: Int,
    //?bindingOptions : Dynamic,
    //?bufferSize: Int,
	//?parser: EventEmitter<SerialPort>->Buffer->Void,
	//?platformOptions: Dynamic
}

@:require(hxnodejs)
@:jsRequire("serialport")
extern class SerialPort extends js.node.stream.Duplex<SerialPort> {

    var binding(default,never) : Dynamic;
	var path(default,never) : String;
	var settings(default,never) : SerialPortOptions;
    var isOpen(default,never) : Bool;
	var baudRate(default,never) : BaudRate;

	function new( path : String, ?options : SerialPortOptions, ?openCallback : Error->Void ) : Void;

    /**
        Opens a connection to the given serial port.
    */
	function open( ?openCallback : Error->Void ) : Void;

    /**
        Writes data to the given serial port.
    */
    @:overload(function( ?callback : Error->Void ) : Void {})
	@:overload(function( data : Buffer, ?callback : Error->Void ) : Void {})
    override function write( data : String, encoding : String, ?callback : Error->Void ) : Bool;

    /**
    */
    override function read( ?size : Int ) : EitherType<String,Buffer>;

    /**
        Pauses an open connection.
    */
    override function pause() : Void;

    /**
        Resumes a paused connection.
    */
    override function resume() : Void;

    /**
        Flushes data received but not read.
    */
    function flush( ?callback : Error->Void ) : Void;

    /**
        Waits until all output data has been transmitted to the serial port.
    */
    function drain( ?callback : Error->Void ) : Void;

    /**
        Closes an open connection.
    */
    function close( ?callback : Error->Void ) : Void;

    /**
        Sets flags on an open port.
    */
    function set( ?options : {?brk:Bool,?cts:Bool,?dsr:Bool,?dtr:Bool,?rts:Bool}, ?callback : Error->Void ) : Void;

    /**
        Returns the control flags (CTS, DSR, DCD) on the open port.
    */
    function get( ?callback : {error:Error,status:{?cts:Bool,?dsr:Bool,?dcd:Bool}}->Void ) : Void;

    /**
        Changes the baudrate for an open port.
    */
	function update( ?options : {?baudRate:BaudRate}, ?callback : Error->Void ) : Void;

    /**
        Retrieves a list of available serial ports with metadata.
    */
	static function list( ?callback : Error->Array<SerialPortInfo>->Void ) : Promise<Array<SerialPortInfo>>;

}
