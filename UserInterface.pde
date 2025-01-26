int topBarHeight = 60;
int consoleHeight = 40;

int addressWidth = 200;
int connectWidth = 100;

int saveloadWidth = 40;

int trackWidth = 70;  //recommended range 50-80
int trackSliderWidth = 20;
int trackSettingsHeight = 200;

int settingsHeight = 20;

int buttonSmallSize = 20;

int padding = 10;

DropdownList uiMidiInList;
//DropdownList uiMidiOutList;


void UISetup()
{
  fill(GetPalette(0));
  rect(0, topBarHeight, width, height-topBarHeight-consoleHeight);

  cp5.addButton("dmxConnect")
    .setValue(0)
    .setPosition(addressWidth+2*padding, padding)
    .setSize(connectWidth, topBarHeight-padding*3)
    .setColor(paletteButton)
    //.setFont(font)
    .setCaptionLabel("Connect DMX")
    ;

  cp5.addTextfield("Address")    //Used for both IP and COM Port
    .setPosition(padding, padding)
    .setSize(addressWidth, topBarHeight-padding*3)
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


  cp5.addTextfield("SaveLoadPatch")    //Used for both IP and COM Port
    .setPosition(padding+300+2*padding, padding)
    .setSize(addressWidth, topBarHeight-padding*3)
    .setText("patch01")
    //.setFont(font)
    .setFocus(false)
    //.setColor(color(GetPalette(3)))
    .setCaptionLabel("type file name to save/load")
    ;

  cp5.addButton("SavePatch")
    .setValue(0)
    .setPosition(padding+addressWidth+padding+connectWidth+padding+addressWidth+padding, padding)
    .setSize(saveloadWidth, topBarHeight-padding*3)
    .setColor(paletteButton)
    //.setFont(font)
    .setCaptionLabel("Save")
    ;

  cp5.addButton("LoadPatch")
    .setValue(0)
    .setPosition(padding+addressWidth+padding+connectWidth+padding+addressWidth+padding+saveloadWidth+padding, padding)
    .setSize(saveloadWidth, topBarHeight-padding*3)
    .setColor(paletteButton)
    //.setFont(font)
    .setCaptionLabel("Load")
    ;

  cp5.addButton("Web")
    .setValue(128)
    .setPosition(width-consoleHeight+padding, height-consoleHeight+padding)
    .setSize(buttonSmallSize, buttonSmallSize)
    .setColor(paletteButton)
    .setCaptionLabel("?")
    ;


  isSetUp = false;
}

void UIAddTrack(int trackIndex)
{
  Track currentTrack = tracks.get(trackIndex);
  int position = trackWidth*trackIndex;
  stroke(GetPalette(0));
  fill(GetPalette(3));
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
  int settingWidthSize = trackWidth-padding*2;
  String settingsLabelIn = "In ";
  String settingsLabelOut = "Out ";

  if (trackWidth <= 60)
  {
    settingsLabelIn = "";
    settingsLabelOut = "";
  }

  cp5.addNumberbox("In" + trackIndex)
    .setPosition(position+padding, settingsHeightPos+padding)
    .setSize(settingWidthSize, settingsHeight)
    .setValue(currentTrack.trackInput)
    .setRange(currentTrack.trackRangeMin, currentTrack.trackRangeMax)
    .setDecimalPrecision(0)
    .setDirection(Controller.HORIZONTAL)
    .setScrollSensitivity(1)
    .setCaptionLabel(settingsLabelIn)
    .getCaptionLabel().align (ControlP5.RIGHT, ControlP5.CENTER)
    //.onChange(tracks.get(trackIndex).trackUpdate())
    ;

  cp5.addNumberbox("Out" + trackIndex)
    .setPosition(position+padding, settingsHeightPos+2*settingsHeight+padding)
    .setSize(settingWidthSize, settingsHeight)
    .setValue(currentTrack.trackOutput)
    .setRange(currentTrack.trackRangeMin, currentTrack.trackRangeMax)
    .setDecimalPrecision(0)
    .setDirection(Controller.HORIZONTAL)
    .setScrollSensitivity(1)
    .setCaptionLabel(settingsLabelOut)
    .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
    ;
/*
  cp5.addButton("Remove" + trackIndex)
    .setValue(128)
    .setPosition(position+trackWidth-buttonSmallSize/2-padding, topBarHeight+padding)
    .setSize(buttonSmallSize/2, buttonSmallSize/2)
    .setColor(paletteButton)
    .setCaptionLabel("x")
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        TrackRemove(trackIndex);
      }
    }
  }
  );
  */
}

void UISetUpDropdownList(DropdownList dropdownList) {
  for (int i=0; i<midiInList.size(); i++) {
    dropdownList.addItem(midiInList.get(i).inputName, midiInList.get(i).inputIndex);
  }
}

//create a new MidiBus with the specified input in the MidiInput dropdown list
void MidiInputs() {
  midiCreateBus();
}


void Web() {
  if (!isSetUp)
  {
    link("https://github.com/ics-de/XController");
  }
}
