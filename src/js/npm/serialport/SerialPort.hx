package js.npm.serialport;

import haxe.extern.EitherType;
import js.lib.Error;
import js.lib.Promise;
import js.node.Buffer;
import js.node.events.EventEmitter;

enum abstract SerialPortEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Callback is called with no arguments when the port is opened and ready for writing.
	**/
	var open:SerialPortEvent<Void->Void> = "open";

	/**
		Callback is called with data depending on your chosen parser.
	**/
	var data:SerialPortEvent<Buffer->Void> = "data";

	/**
		Callback is called when the port is closed.
		In the case of a disconnect it is called with a `DisconnectedError` argument (`err.disconnected == true`),
		listen with `port.on('close', (err:Null<DisconnectedError>) -> ...)` to receive it.
	**/
	var close:SerialPortEvent<Void->Void> = "close";

	/**
		Callback is called with an error object whenever there is an error.
	**/
	var error:SerialPortEvent<Error->Void> = "error";

	/**
		Emitted when it is performant to write again if a `write()` call has returned `false`.
	**/
	var drain:SerialPortEvent<Void->Void> = "drain";

	/**
		Emitted when the port is closed and `endOnClose` is set.
	**/
	var end:SerialPortEvent<Void->Void> = "end";
}

/**
	Rate at which information is transferred (bits per second).
	Custom rates are supported best effort per platform.
**/
enum abstract BaudRate(Int) from Int to Int {
	var B921600 = 921600;
	var B460800 = 460800;
	var B230400 = 230400;
	var B115200 = 115200;
	var B57600 = 57600;
	var B38400 = 38400;
	var B19200 = 19200;
	var B14400 = 14400;
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
**/
enum abstract DataBits(Int) from Int to Int {
	var CS8 = 8;
	var CS7 = 7;
	var CS6 = 6;
	var CS5 = 5;
}

/**
	Number of bits used to indicate the end of a byte.
**/
enum abstract StopBits(Float) to Float {
	var ONE = 1;
	var ONE_FIVE = 1.5;
	var TWO = 2;
}

/**
	Type of parity checking.
	`mark` and `space` are only supported on Windows.
**/
enum abstract Parity(String) to String {
	var none = 'none';
	var even = 'even';
	var mark = 'mark';
	var odd = 'odd';
	var space = 'space';
}

/**
	RTS mode (Windows only).
**/
enum abstract RtsMode(String) to String {
	var handshake = 'handshake';
	var enable = 'enable';
	var toggle = 'toggle';
}

/**
	Serial port info with metadata.
	Only the `path` is guaranteed. If unavailable the other fields will be undefined.
	The `path` is either the path or an identifier (eg `COM1`) used to open the SerialPort.
**/
typedef PortInfo = {
	path:String,
	?manufacturer:String,
	?serialNumber:String,
	?pnpId:String,
	?locationId:String,
	?vendorId:String,
	?productId:String
}

typedef PortStatus = {
	cts:Bool,
	dsr:Bool,
	dcd:Bool,

	/**
		Linux only.
	**/
	?lowLatency:Bool
}

typedef SetOptions = {
	?brk:Bool,
	?cts:Bool,
	?dsr:Bool,
	?dtr:Bool,
	?rts:Bool,

	/**
		Low latency mode (Linux only).
	**/
	?lowLatency:Bool
}

typedef UpdateOptions = {
	baudRate:BaudRate
}

typedef SerialPortOptions = {
	/**
		The system path of the serial port you want to open.
		For example, `/dev/tty.XXX` on Mac/Linux, or `COM1` on Windows.
	**/
	path:String,

	/**
		The baud rate of the port to be opened.
	**/
	baudRate:BaudRate,

	/**
		Automatically opens the port on `nextTick` (defaults to `true`).
	**/
	?autoOpen:Bool,

	/**
		Emit `end` on port close (defaults to `false`).
	**/
	?endOnClose:Bool,

	/**
		The size of the read and write buffers (defaults to 64k).
	**/
	?highWaterMark:Int,

	/**
		Defaults to `8`.
	**/
	?dataBits:DataBits,

	/**
		Prevent other processes from opening the port.
		Windows does not currently support `false` (defaults to `true`).
	**/
	?lock:Bool,

	/**
		Defaults to `1`.
	**/
	?stopBits:StopBits,

	/**
		Defaults to `none`.
	**/
	?parity:Parity,

	/**
		Flow control setting (defaults to `false`).
	**/
	?rtscts:Bool,

	/**
		Flow control setting (defaults to `false`).
	**/
	?xon:Bool,

	/**
		Flow control setting (defaults to `false`).
	**/
	?xoff:Bool,

	/**
		Flow control setting (defaults to `false`).
	**/
	?xany:Bool,

	/**
		Drop DTR on close (defaults to `true`).
	**/
	?hupcl:Bool,

	/**
		See `man termios` (Linux/macOS only, defaults to `1`).
	**/
	?vmin:Int,

	/**
		See `man termios` (Linux/macOS only, defaults to `0`).
	**/
	?vtime:Int,

	/**
		RTS mode (Windows only, defaults to `handshake`).
	**/
	?rtsMode:RtsMode,
}

/**
	Error passed to the `close` event when the port got disconnected.
**/
@:jsRequire("@serialport/stream", "DisconnectedError")
extern class DisconnectedError extends Error {
	var disconnected(default, never):Bool;
}

/**
	The stream interface shared by `SerialPort` and `SerialPortMock`.
**/
@:jsRequire("@serialport/stream", "SerialPortStream")
extern class SerialPortStream<TSelf:SerialPortStream<TSelf>> extends js.node.stream.Duplex<TSelf> {
	/**
		The port's baudRate.
		Use `update()` to change it.
	**/
	var baudRate(default, never):BaudRate;

	/**
		`true` if the port is open, `false` otherwise.
	**/
	var isOpen(default, never):Bool;

	/**
		The path of the serial port.
	**/
	var path(default, never):String;

	/**
		The binding port object backing the stream when open.
	**/
	var port(default, never):Null<Dynamic>;

	/**
		`true` while the port is being opened.
	**/
	var opening(default, never):Bool;

	/**
		`true` while the port is being closed.
	**/
	var closing(default, never):Bool;

	/**
		The resolved open options.
	**/
	var settings(default, never):Dynamic;

	/**
		Opens a connection to the given serial port.
		Emits an `open` event when the port is open.
	**/
	function open(?openCallback:Null<Error>->Void):Void;

	/**
		Writes data to the given serial port.
		Buffers written data if the port is not open.
		In addition to strings and buffers, `write()` accepts arrays of bytes.
	**/
	@:overload(function(chunk:EitherType<String, EitherType<Buffer, Array<Int>>>, ?callback:Null<Error>->Void):Bool {})
	override function write(chunk:Dynamic, ?encoding:String, ?callback:EitherType<Void->Void, Null<Error>->Void>):Bool;

	/**
		Discards data received but not read, and written but not transmitted by the operating system.
	**/
	function flush(?callback:Null<Error>->Void):Void;

	/**
		Waits until all output data has been transmitted to the serial port.
	**/
	function drain(?callback:Null<Error>->Void):Void;

	/**
		Closes an open connection.
		If there are in progress writes when the port is closed the writes will error.
	**/
	function close(?callback:Null<Error>->Void):Void;

	/**
		Set control flags on an open port.
		All options are operating system default when the port is opened.
		Every flag is set on each call to the provided or default values.
	**/
	function set(options:SetOptions, ?callback:Null<Error>->Void):Void;

	/**
		Returns the control flags (CTS, DSR, DCD) on the open port.
	**/
	function get(callback:(error:Null<Error>, status:Null<PortStatus>) -> Void):Void;

	/**
		Changes the baud rate for an open port.
	**/
	function update(options:UpdateOptions, ?callback:Null<Error>->Void):Void;
}

@:deprecated("Use PortInfo")
typedef SerialPortInfo = PortInfo;

/**
	A serial port using the auto detected platform binding (`@serialport/bindings-cpp`).
**/
@:require(hxnodejs)
@:jsRequire("serialport", "SerialPort")
extern class SerialPort extends SerialPortStream<SerialPort> {
	/**
		The auto detected hardware access binding.
	**/
	static var binding(default, never):Dynamic;

	/**
		Retrieves a list of available serial ports with metadata.
	**/
	static function list():Promise<Array<PortInfo>>;

	/**
		Create a new serial port object for the `path`.
		The port will open automatically by default, which is the equivalent of calling `port.open(openCallback)` in the next tick.
		You can disable this by setting the option `autoOpen` to `false`.
	**/
	function new(options:SerialPortOptions, ?openCallback:Null<Error>->Void):Void;
}
