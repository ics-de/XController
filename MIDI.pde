import themidibus.*; //Import the library

MidiBus midiBus; // The MidiBus

IntList midiIn;

boolean scaleMidiToDmx = true;

void midiCreateBus(int midiIn, int midiOut)
{
  midiBus = new MidiBus(this, midiIn, midiOut);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);

  MidiControllerChange(channel, number, value);
}

void MidiControllerChange(int channel, int number, int value)
{
  ConsolePrint("CC: " + channel + " | " + number + " | " + value);

  if (scaleMidiToDmx)
  {
    value = round(map(value, 0, 127, 0, 255));
  }

  int trackIndex = TrackFind(number);

  tracks.get(trackIndex).trackReceive(value);
  tracks.get(trackIndex).trackSend();
  cp5.get(Slider.class, "Track" + trackIndex).setValue(value);
}
