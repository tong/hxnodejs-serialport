import js.node.Buffer;
import js.npm.serialport.SerialPort;
import js.npm.serialport.parser.ReadlineParser;

function main() {
	SerialPort.list().then(ports -> {
		Sys.println('Found ${ports.length} connected serial ports');
		for (i in 0...ports.length)
			Sys.println('$i = ${ports[i].path}');
		if (ports.length == 0)
			return;
		var port = new SerialPort({
			path: ports[0].path,
			baudRate: B115200
		});
		var parser = port.pipe(new ReadlineParser({delimiter: '\n'}));
		parser.on('data', (line:String) -> trace(line));
		port.on(SerialPortEvent.open, () -> {
			Sys.println('Connected to [${port.path}]');
			port.write(Buffer.from('ls\n'), e -> {
				if (e != null)
					trace(e);
			});
		});
		port.on(SerialPortEvent.error, e -> trace(e));
	}).catchError(e -> {
		trace(e);
	});
}
