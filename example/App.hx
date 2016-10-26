
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
