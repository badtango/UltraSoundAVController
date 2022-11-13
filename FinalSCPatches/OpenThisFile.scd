g = ArduinoSMS("/dev/tty.usbserial-A900af0K", 115200);

// DON'T FORGET TO CHANGE YOUR PATHWAYS!
"/Users/williamrailton/Desktop/UltraSoundAVController/FinalSCPatches/AudioVisualFunctions.scd”.loadPaths;
"/Users/williamrailton/Desktop/UltraSoundAVController/FinalSCPatches/KeyCommands.scd”.loadPaths;

// Key Controls:
// 1 = audiovisual1
// 2 = audiovisual2
// 3 = audiovisual3
// 4 = audiovisual4
// 5 = audiovisual5

// Reference for sensors:
// 0 // 4-48 (bottom) 
// 1 // 4-48 (left, pole support)
// 2 // 4-48 (front, power input) 
// 3 // 4-48 (right, power LED)  
// 4 // 4-48 (back, pole support) 
// 5 // 4-48 (top)

Document.current.keyDownAction_(nil);

// DON'T FORGET TO CLOSE YOUR SERIAL PORT OR YOU MIGHT CRASH SC!
g.close;


