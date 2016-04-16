
# Haxe Serialport NPM [![Build Status](https://travis-ci.org/tong/hxnodejs-serialport.svg?branch=master)](https://travis-ci.org/tong/hxnodejs-serialport)

Haxe/Nodejs type definitions for the serialport npm module.

* https://www.npmjs.com/package/serialport
* https://github.com/voodootikigod/node-serialport


### Install
```shell
haxelib install hxnodejs-serialport
```



### Usage Example
```haxe

import js.node.Buffer;
import js.npm.SerialPort;

class App {

	static function main() {

		SerialPort.list(function(e,devices) {

			if( e != null ) trace(e) else {

				var device = devices[0];
				trace( device );

				var serial = new SerialPort( device.comName, {
					baudrate: 115200
				});
				serial.on( 'open', function(){
					trace( 'open' );
					serial.write( new Buffer('ls\n'), function(e,r) {
						if( e != null ) trace(e) else trace(r);
				    });
				});
				serial.on( 'data', function(data){
					trace( 'data: '+data.toString() );
				});
			}
		});
	}
}
```
