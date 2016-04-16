
import js.node.Buffer;
import js.npm.SerialPort;

class App {

	static function main() {

		SerialPort.list(function(e,devices) {

			if( e != null ) trace(e) else {

				trace( devices );

				var port = devices[0];
				var serial = new SerialPort( port.comName, {
					baudrate: _115200
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