
# Haxe Serialport NPM
[![Travis Build Status](https://travis-ci.org/tong/hxnodejs-serialport.svg?branch=master)](https://travis-ci.org/tong/hxnodejs-serialport) [![Haxelib Version](https://img.shields.io/github/tag/tong/hxnodejs-serialport.svg?colorA=EA8220&colorB=FBC707&label=haxelib)](http://lib.haxe.org/p/hxnodejs-serialport/)

Haxe/Nodejs type definitions for the [serialport npm module](https://github.com/EmergingTechnologyAdvisors/node-serialport).


### Example Usage

```haxe

import js.node.Buffer;
import js.npm.SerialPort;

class App {

	static function main() {

		SerialPort.list(function(e,devices) {

			if( e != null ) trace(e) else {

				for( device in devices ) trace( device );

				var port = devices[0];
				var serial = new SerialPort( port.comName, {
					baudrate: _115200
				});
				serial.on( open, function(){
					trace( 'Connected to: '+port.comName );
					serial.write( new Buffer('ls\n'), function(e) {
						if( e != null ) trace(e);
				    });
				});
				serial.on( data, function(data){
					trace( data.toString() );
				});
			}
		});
	}
}
```
