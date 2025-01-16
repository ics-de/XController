import controlP5.*;


//ControlP5 variables
ControlP5 cp5;
DropdownList MIDIinputs, MIDIoutputs;

String address = "COM4";          //either port COM4 or IP

boolean isSetUp = true;

int dmxChannels = 512;
ArrayList<Track> tracks = new ArrayList<Track>();
ArrayList<MidiBus> midiIn = new ArrayList<MidiBus>();
IntList midiInValues = new IntList();

void setup()
{
  //DMXP512 setup
  dmxOutput=new DmxP512(this, universeSize, false);

  //ControlP5 setup
  cp5 = new ControlP5(this);


  //User Interface Setup
  size(1900, 1000);

  SetPalette();

  background(GetPalette(0));
  //PFont font = createFont("arial",12);


  UISetup();

  ConsolePrint("Welcome to XController by Oriol Colomer Delgado - @oriolonbass | 2025");
  MidiBus.list();
}

void draw()
{
  /*
  for (int i = 0; i<tracks.size(); i++)
   {
   tracks.get(i).trackReceive();
   }
   */
  if (mousePressed)//if input detected -> send output
  {
    for (int i = 0; i<tracks.size(); i++)
    {
      tracks.get(i).trackSend();
    }
  }
}
