
import js.node.Buffer;
import js.npm.serialport.SerialPort;

class App {

	static function main() {

		SerialPort.list().then( function(ports:Array<SerialPortInfo>) {

			Sys.println( 'Found ${ports.length} connected serial ports' );
			for( i in 0...ports.length ) Sys.println( '$i = ${ports[i]}' );

			var port = new SerialPort( ports[0].path, {
				baudRate: _115200
			});
			port.on( SerialPortEvent.open, function(){
				Sys.println( 'Connected to [${ports[0].path}]' );
				port.write( new Buffer( 'ls\n' ), function(e) {
					if( e != null ) trace(e);
				});
			});
			port.on( SerialPortEvent.data, function(buf){
				trace( buf.toString() );
			});

		}).catchError( function(e) {
			trace(e);
		});
	}

}
