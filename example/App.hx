
import js.node.Buffer;
import js.npm.serialport.SerialPort;

class App {

	static function main() {

		Sys.println( 'Checking for connected serial devices …' );

		SerialPort.list().then( function(ports:Array<SerialPortInfo>) {

			Sys.println( 'Found ${ports.length} connected serial ports' );
			for( i in 0...ports.length ) Sys.println( '$i: ${ports[i]}' );

			var port = ports[0];
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

		}).catchError( function(e) {
			trace(e);
		});
	}

}
