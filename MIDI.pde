import themidibus.*; //Import the library

MidiBus midiBus; // The MidiBus

ArrayList<MidiInOut> midiInList = new ArrayList<MidiInOut>();
ArrayList<MidiInOut> midiOutList = new ArrayList<MidiInOut>();

boolean scaleMidiToDmx = true;

class MidiInOut {

  int inputIndex = 0;
  String inputName = "-";

  MidiInOut (int inIndex, String inName) {
    inputIndex = inIndex;
    inputName = inName;
  }
}

void MidiSetup()
{
  for (int i = 0; i < MidiBus.availableInputs().length; i++) midiInList.add(new MidiInOut(i, MidiBus.availableInputs()[i]));
  for (int i = 0; i < MidiBus.availableInputs().length; i++) midiOutList.add(new MidiInOut(i, MidiBus.availableOutputs()[i]));
}

void midiCreateBus(/*int midiIn, int midiOut*/)
{
  //midiBus = new MidiBus(this, midiIn, midiOut);
  int selectedInput = int(uiMidiInList.getValue());
  int selectedOutput = 0;
  
  midiBus = new MidiBus(this,selectedInput, selectedOutput);
}

void DebugMidi(){
 println(str(uiMidiInList.getValue())); 
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange

  MidiControllerChange(channel, number, value);
}

void MidiControllerChange(int channel, int number, int value)
{
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  //ConsolePrint("CC: " + channel + " | " + number + " | " + value);

  if (scaleMidiToDmx)
  {
    value = round(map(value, 0, 127, 0, 255));
  }

  int trackIndex = TrackFind(number);
  if (trackIndex > -1)
  {
    tracks.get(trackIndex).trackReceive(value);
    tracks.get(trackIndex).trackSend();
    cp5.get(Slider.class, "Track" + trackIndex).setValue(value);
  } else {
    println("Track not found");
    //ConsolePrint("Track " + " not found.");
  }
}
