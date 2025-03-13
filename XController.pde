import controlP5.*;

ControlP5 cp5;

String address = "COM4";          //either port COM4 or IP

boolean isSetUp = true;

int dmxChannels = 512;



//XController
String xcVersion = "0.6";
String xcWelcome = "Welcome to XController (v " + xcVersion + ") by Oriol Colomer Delgado - @ics_de | 2025";

void setup()
{
  //DMXP512 setup
  dmxOutput=new DmxP512(this, universeSize, false);

  //ControlP5 setup
  cp5 = new ControlP5(this);


  //User Interface Setup
  size(1900, 1000);

  SetPalette();

  background(GetPalette(2));
  //PFont font = createFont("arial",12);

  MidiBus.list();
  Sound.list();

  MidiSetup();
  AudioSetup();
  UISetup();

  ConsolePrint(xcWelcome);
  
  //midiCreateBus(2, 5);
  //Load("default");
}

void draw()
{
  UIRefresh();
  
  if(useAudio)
  {
   AudioUpdate(); 
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    if(cp5.get(Textfield.class, "InspectorName").isFocus()){
       InspectorNameTrack(currentTrackInspected); 
    }
  }
}

void dispose() {
  ConsolePrint("Disposing resources...");
  // Clean up ControlP5 or other libraries
  if (cp5 != null) {
    cp5.hide(); // Example cleanup
  }
}
