int topBarHeight = 60;
int consoleHeight = 40;

int trackWidth = 100;
int trackSliderWidth = 20;
int trackSettingsHeight = 200;


int settingsHeight = 20;

int padding = 10;

DropdownList uiMidiInList;
//DropdownList uiMidiOutList;


void UISetup()
{
  fill(GetPalette(0));
  rect(0, topBarHeight, width, height-topBarHeight-consoleHeight);

  cp5.addButton("dmxConnect")
    .setValue(0)
    .setPosition(210+padding, padding)
    .setSize(150, topBarHeight-padding*3)
    .setColor(paletteButton)
    //.setFont(font)
    ;

  cp5.addTextfield("Address")    //Used for both IP and COM Port
    .setPosition(padding, padding)
    .setSize(200, topBarHeight-padding*3)
    .setText(address)
    //.setFont(font)
    .setFocus(false)
    //.setColor(color(GetPalette(3)))
    .setCaptionLabel("input IP address or COM port...")
    ;

  cp5.addButton("TrackCreateDefault")
    .setValue(128)
    .setPosition(width-topBarHeight+padding, padding)
    .setSize(topBarHeight-2*padding, topBarHeight-2*padding)
    .setColor(paletteButton)
    .setCaptionLabel("+")
    ;

  uiMidiInList = cp5.addDropdownList("MidiInputs")
    .setPosition(width/2 + padding, padding)
    ;
  UISetUpDropdownList(uiMidiInList);


  isSetUp = false;
}

void UIAddTrack(int trackIndex)
{
  Track currentTrack = tracks.get(trackIndex);
  int position = trackWidth*trackIndex;
  fill(127);
  rect(position, topBarHeight, trackWidth, height-topBarHeight-consoleHeight);
  cp5.addSlider("Track" + trackIndex)
    .setPosition(position+trackWidth/2-trackSliderWidth/2, topBarHeight+padding)
    .setSize(trackSliderWidth, height-topBarHeight-consoleHeight-trackSettingsHeight-(padding*2))
    .setRange(currentTrack.trackRangeMin, currentTrack.trackRangeMax)
    .setValue(currentTrack.trackValue)
    .setDecimalPrecision(0)
    .setCaptionLabel(str(trackIndex))
    ;

  int settingsHeightPos = height-topBarHeight-consoleHeight-6*settingsHeight;

  cp5.addNumberbox("In" + trackIndex)
    .setPosition(position+padding, settingsHeightPos+padding)
    .setSize(trackWidth-padding*2, settingsHeight)
    .setValue(currentTrack.trackInput)
    .setRange(currentTrack.trackRangeMin, currentTrack.trackRangeMax)
    .setDecimalPrecision(0)
    .setDirection(Controller.HORIZONTAL)
    .setScrollSensitivity(1)
    .setCaptionLabel("In")
    .getCaptionLabel().align (ControlP5.CENTER, ControlP5.CENTER)
    //.onChange(tracks.get(trackIndex).trackUpdate())
    ;

  cp5.addNumberbox("Out" + trackIndex)
    .setPosition(position+padding, settingsHeightPos+2*settingsHeight+padding)
    .setSize(trackWidth-padding*2, settingsHeight)
    .setValue(currentTrack.trackOutput)
    .setRange(currentTrack.trackRangeMin, currentTrack.trackRangeMax)
    .setDecimalPrecision(0)
    .setDirection(Controller.HORIZONTAL)
    .setScrollSensitivity(1)
    .setCaptionLabel("Out")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
}

void UISetUpDropdownList(DropdownList dropdownList) {
  for (int i=0; i<midiInList.size(); i++) {
    dropdownList.addItem(midiInList.get(i).inputName, midiInList.get(i).inputIndex);
  }
}

void MidiInputs(){
  midiCreateBus();
}
