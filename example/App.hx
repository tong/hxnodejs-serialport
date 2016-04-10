
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