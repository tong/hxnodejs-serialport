package js.npm.serialport;

import js.lib.Error;
import js.lib.Promise;
import js.node.Buffer;
import js.npm.serialport.SerialPort;

typedef CreatePortOptions = {
	?echo:Bool,
	?record:Bool,
	?readyData:Buffer,
	?maxReadSize:Int,
	?manufacturer:String,
	?vendorId:String,
	?productId:String
}

/**
	Mock binding for pretend serialport access.
**/
typedef MockBinding = {
	function list():Promise<Array<PortInfo>>;
	function reset():Void;
	function createPort(path:String, ?options:CreatePortOptions):Void;
}

/**
	A serial port using the mock binding, useful for testing.

	```haxe
	SerialPortMock.binding.createPort('/dev/example', {echo: true, record: true});
	var port = new SerialPortMock({path: '/dev/example', baudRate: 9600});
	```
**/
@:require(hxnodejs)
@:jsRequire("serialport", "SerialPortMock")
extern class SerialPortMock extends SerialPortStream<SerialPortMock> {
	static var binding(default, never):MockBinding;
	static function list():Promise<Array<PortInfo>>;
	function new(options:SerialPortOptions, ?openCallback:Null<Error>->Void):Void;
}
