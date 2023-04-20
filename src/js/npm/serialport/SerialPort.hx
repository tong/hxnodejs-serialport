package js.npm.serialport;

import haxe.extern.EitherType;
import js.lib.Error;
import js.lib.Promise;
import js.node.Buffer;
import js.node.events.EventEmitter;

enum abstract SerialPortEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {

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
        Emitted when it is performant to write again if a `write()` call has returned `false`.
    */
	var drain : SerialPortEvent<Void->Void> = "drain";
}

/**
    Rate at which information is transferred  (bits per second).
*/
enum abstract BaudRate(Int) to Int {
	var B115200 = 115200;
	var B57600 = 57600;
	var B38400 = 38400;
	var B19200 = 19200;
	var B9600 = 9600;
	var B4800 = 4800;
	var B2400 = 2400;
	var B1800 = 1800;
	var B1200 = 1200;
	var B600 = 600;
	var B300 = 300;
	var B200 = 200;
	var B150 = 150;
	var B134 = 134;
	var B110 = 110;
	var B75 = 75;
	var B50 = 50;
}

/**
    Number of data bits to transmit.
*/
enum abstract DataBits(Int) from Int to Int {
	var CS8 = 8;
	var CS7 = 7;
	var CS6 = 6;
	var CS5 = 5;
}

/**
    Number of bits used to indicate the end of a byte.
*/
enum abstract StopBits(Float) to Float {
    var ONE = 1;
    var ONE_FIVE = 1.5;
	var TWO = 2;
}

/**
    Type of parity checking.
*/
enum abstract Parity(String) to String {
	var none = 'none';
	var even = 'even';
	var mark = 'mark';
	var odd = 'odd';
	var space = 'space';
}

typedef SerialPortInfo = {
	path: String,
	?manufacturer: String,
	?serialNumber: String,
	?pnpId: String,
	?locationId: String,
	?vendorId: String,
	?productId: String
}

typedef SerialPortOptions = {

    path: String,

    /**
        Automatically opens the port on `nextTick`.
    **/
    ?autoOpen : Bool,

    /**
        The baud rate of the port to be opened.
    **/
    ?baudRate : BaudRate,

    /**
    **/
    ?dataBits : DataBits,

    /**
        The size of the read and write buffers (defaults to 64k).
    **/
    ?highWaterMark : Int,

    /**
        Prevent other processes from opening the port.
    **/
    ?lock : Bool,

    /**
    **/
    ?stopBits : StopBits,

    /**
    **/
    ?parity : Parity,

    /**
        Flow control setting.
    **/
    ?rtscts : Bool,

    /**
        Flow control setting.
    **/
    ?xon : Bool,

    /**
        Flow control setting.
    **/
    ?xoff : Bool,

    /**
        Flow control setting.
    **/
    ?xany : Bool,

    /**
        Binding specific options.
    **/
    ?bindingOptions : Dynamic,
}

@:require(hxnodejs)
@:jsRequire("serialport","SerialPort")
extern class SerialPort extends js.node.stream.Duplex<SerialPort> {

    /**
        The hardware access binding.
    **/
    static var Binding(default,never) : Dynamic;

    /**
        The port's baudRate.
        Use `update()` to change it.
    **/
    var baudRate(default,never) : BaudRate;

    /**
        The Binding object backing the port.
    **/
    var binding(default,never) : Dynamic;

    /**
        `true` if the port is open, `false` otherwise
    **/
    var isOpen(default,never) : Bool;

    /**
        The path of the serial port.
    **/
	var path(default,never) : String;

	function new(options : SerialPortOptions, ?openCallback : ?Error->Void) : Void;

    /**
        Opens a connection to the given serial port.
        Emits an `open` event when the port is open.
    */
	function open( ?openCallback : Error->Void ) : Void;

    /**
        Writes data to the given serial port.
    */
	@:overload(function( data : EitherType<Buffer,Array<Float>>, ?callback : Error->Void ) : Bool {})
    override function write( data : String, encoding : String, ?callback : Void->Void ) : Bool;

    /**
    */
    override function read( ?size : Int ) : EitherType<String,Buffer>;

    /**
        Causes a stream in flowing mode to stop emitting `data` events, switching out of flowing mode.
    */
    override function pause() : Void;

    /**
        Causes an explicitly paused, Readable stream to resume emitting `data` events, switching the stream into flowing mode.
    */
    override function resume() : Void;

    /**
        Discards data received but not read, and written but not transmitted by the operating system.
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
    function set(
        ?options : {
            ?brk : Bool,
            ?cts : Bool,
            ?dsr : Bool,
            ?dtr : Bool,
            ?rts : Bool
        },
        ?callback : Error->Void ) : Void;

    /**
        Returns the control flags (CTS, DSR, DCD) on the open port.
    */
    function get(
        ?callback : {
            error:Error,
            status : {
                ?cts : Bool,
                ?dsr : Bool,
                ?dcd : Bool
            }
        }->Void ) : Void;

    /**
        Changes the baudrate for an open port.
    */
	function update( ?options : {?baudRate:BaudRate}, ?callback : Error->Void ) : Void;

    /**
        Retrieves a list of available serial ports with metadata.
        Only the comName is guaranteed.
        If unavailable the other fields will be undefined.
        The `comName` is either the path or an identifier (eg `COM1`) used to open the SerialPort.
    */
	static function list() : Promise<Array<SerialPortInfo>>;

}
