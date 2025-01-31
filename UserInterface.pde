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

  fill(0);
  rect(width/2, padding, 5, 5);

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

void UIRefresh()
{
  background(GetPalette(2));

  fill(GetPalette(0));
  rect(0, topBarHeight, width, height-topBarHeight-consoleHeight);

  if (isReceivingMidi) {
    fill(0, 255, 0);
  } else {
    fill(0);
  }
  rect(width/2, padding, 5, 5);

  for (int i = 0; i < tracks.size(); i++)
  {
    stroke(GetPalette(0));
    if (!tracks.get(i).isMuted) {
      fill(GetPalette(3));
    } else {
      fill(GetPalette(5));
    }

    rect(trackWidth*i, topBarHeight, trackWidth, height-topBarHeight-consoleHeight);
  }
  UIConsole();
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
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_BROADCAST) {
        tracks.get(trackIndex).trackReceive((int)(event.getController().getValue()));
        tracks.get(trackIndex).trackSend();
      }
    }
  }
  )
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

  //SETTINGS
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
    .setPosition(position+padding, settingsHeightPos+settingsHeight+2*padding)
    .setSize(settingWidthSize, settingsHeight)
    .setValue(currentTrack.trackOutput)
    .setRange(currentTrack.trackRangeMin, currentTrack.trackRangeMax)
    .setDecimalPrecision(0)
    .setDirection(Controller.HORIZONTAL)
    .setScrollSensitivity(1)
    .setCaptionLabel(settingsLabelOut)
    .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
    ;

  cp5.addToggle("Mute" + trackIndex)
    .setValue(false)
    .setPosition(position+padding, settingsHeightPos+2*settingsHeight+3*padding)
    .setSize(settingWidthSize/2, settingsHeight)
    //.setColor(paletteButton)
    .setCaptionLabel("M")
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        TrackMute(trackIndex);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addToggle("Solo" + trackIndex)
    .setValue(false)
    .setPosition(position+padding+settingWidthSize/2, settingsHeightPos+2*settingsHeight+3*padding)
    .setSize(settingWidthSize/2, settingsHeight)
    //.setColor(paletteButton)
    .setCaptionLabel("S")
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        TrackSolo(trackIndex);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addToggle("Smooth" + trackIndex)
    .setValue(false)
    .setPosition(position+padding, settingsHeightPos+3*settingsHeight+4*padding)
    .setSize(settingWidthSize, settingsHeight)
    //.setColor(paletteButton)
    .setCaptionLabel("Smooth")
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        TrackSmooth(trackIndex);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  /*
  cp5.addButton("Remove" + trackIndex)
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

void UIConsole()
{
  fill(GetPalette(0));
  rect(0, height - consoleHeight, width, consoleHeight);
  fill(GetPalette(4));
  text(currentConsoleMessage, 5, height - 5);
  fill(GetPalette(4), 127);
  text(lastConsoleMessage, 5, height - 20);
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
