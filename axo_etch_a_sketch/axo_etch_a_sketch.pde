import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

boolean midiThru = true;  // no need for sending midi in this sketch

float midiX0;
float midiY0;


void setup() {
  size(800,600);
  background(0);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

        // MODIFY THIS FOR YOUR MIDI SETUP
  //                 Parent  In                 Out
  //                   |     |                   |
  myBus = new MidiBus(this, "Core [hw:1,0,0]", "Core [hw:1,0,0]"); // Create a new MidiBus with Axoloti Core as input and output device.
}

void draw() {
  stroke(255);
  ellipse(midiX0, midiY0, 5, 5);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println("Ctrl Ch : ch=" +channel+" number="+number+" value="+value);
  if (midiThru) {
    myBus.sendControllerChange(channel, number, value); // Send a controllerChange
  }
  // xy-position
  if (number==1) midiX0=value*width/127;
  if (number==2) midiY0=value*height/127;
}
