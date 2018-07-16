
import js.node.Buffer;
import js.npm.SerialPort;

class App {

	static function main() {

		Sys.println( 'Checking for connected serial devices …' );

		SerialPort.list( function(e,devices) {

			if( e != null ) trace(e) else {

				Sys.println( 'Found ${devices.length} connected serial devices' );
				for( i in 0...devices.length ) Sys.println( '$i: ${devices[i]}' );

				var port = devices[0];
				var serial = new SerialPort( port.comName, {
					baudRate: _115200
				});
				serial.on( SerialPortEvent.open, function(){
					Sys.println( 'Connected to [${port.comName}]' );
					serial.write( new Buffer( 'ls\n' ), function(e) {
						if( e != null ) trace(e);
				    });
				});
				serial.on( SerialPortEvent.data, function(buf){
					trace( buf.toString() );
				});
			}
		});
	}

}
