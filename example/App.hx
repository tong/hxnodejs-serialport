
import js.node.Buffer;
import js.npm.serialport.SerialPort;

function main() {

	SerialPort.list().then( (ports:Array<SerialPortInfo>) -> {
	
		Sys.println( 'Found ${ports.length} connected serial ports' );
		for( i in 0...ports.length ) Sys.println( '$i = ${ports[i]}' );
	
		var port = new SerialPort( ports[0].path, {
			baudRate: B115200
		});
		port.on( SerialPortEvent.open, () -> {
			Sys.println( 'Connected to [${ports[0].path}]' );
			port.write( new Buffer( 'ls\n' ), e -> {
				if( e != null ) trace(e);
			});
		});
		port.on( SerialPortEvent.data, buf -> {
			trace( buf.toString() );
		});
	
	}).catchError( e -> {
		trace(e);
	});
}
