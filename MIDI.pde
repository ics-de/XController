import themidibus.*; //Import the library

MidiBus midiBus; // The MidiBus

//ArrayList<MidiBus> midiIn = new ArrayList<MidiBus>(); midiInList;
DropdownList midiOutList;

void midiCreateBus(int midiIn, int midiOut)
{
  midiBus = new MidiBus(this, midiIn, midiOut);
}
