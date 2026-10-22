# Haxe Serialport NPM

Haxe/Nodejs type definitions for the [serialport npm module](https://github.com/node-serialport/node-serialport).

Node-Serialport provides a stream interface for the low-level serial port code necessary to control Arduino chipsets, X10 interfaces, Zigbee radios, highway signs, lcd screens, cash drawers, motor controllers, sensor packages, fork lifts, modems, drones, CNC machines, plotters, vending machines, ccTalk coin accecptors, SMS Gateways, RFID scanners and much more. If you have a hardware device with a UART we can speak to it. The physical world is your oyster with this goodie.

[![test](https://github.com/tong/hxnodejs-serialport/actions/workflows/test.yml/badge.svg)](https://github.com/tong/hxnodejs-serialport/actions/workflows/test.yml) [![Haxelib Version](https://img.shields.io/github/tag/tong/hxnodejs-serialport.svg?colorA=EA8220&colorB=FBC707&label=haxelib)](http://lib.haxe.org/p/hxnodejs-serialport/)

### Install

```sh
haxelib install hxnodejs-serialport
npm install serialport
```

Version `2.x` targets serialport `v13` (Node.js >= 20). All classes, including parsers, are required from the `serialport` package.

### Usage

```haxe
import js.npm.serialport.SerialPort;
import js.npm.serialport.parser.ReadlineParser;

var port = new SerialPort({path: '/dev/ttyACM0', baudRate: B9600});
var parser = port.pipe(new ReadlineParser({delimiter: '\n'}));
parser.on('data', (line:String) -> trace(line));
```

 - [Serialport documentation](https://serialport.io/docs/)
 - [Example application](https://github.com/tong/hxnodejs-serialport/blob/master/example/App.hx)
