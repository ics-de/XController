int padding = 10;

int topBarHeight = 60;
int consoleHeight = 40;

int addressWidth = 200;
int connectWidth = 100;

int saveloadWidth = 40;

int trackWidth = 70;  //recommended range 50-80
int trackSliderWidth = 20;
int trackSettingsHeight = 200;

int groupHeight;
int sliderHeight;
int groupHeightPos;


int settingsHeight = 20;
int settingWidthSize = trackWidth-padding*2;

int buttonSmallSize = 20;

int inspectorHeight = 300;

int groupLabelHeight = 10;


DropdownList uiMidiInList;

//Console
Textarea uiConsole;

//Scrollbar
Range scrollbar;
int scrollbarRange = 100;
int scrollbarPos = 0;


//Inspector
Group inspector;
Textarea inspectorText;
int currentTrackInspected = 0;

void UIInspect(int trackIndex) {
  currentTrackInspected = trackIndex;
  Track currentTrack = tracks.get(currentTrackInspected);
  cp5.get(Textfield.class, "InspectorName").setText(tracks.get(currentTrackInspected).trackName);
  /*
  inspectorText.setText(
   "trackIndex: " + currentTrack.trackIndex + "\n" +
   "trackName: " + currentTrack.trackName + "\n" +
   "trackColor: " + currentTrack.trackColor + "\n" +
   "trackValue: " + currentTrack.trackValue + "\n" +
   "trackRangeMin: " + currentTrack.trackRangeMin + "\n" +
   "trackRangeMax: " + currentTrack.trackRangeMax + "\n" +
   "trackInput: " + currentTrack.trackInput + "\n" +
   "trackOutput: " + currentTrack.trackOutput + "\n" +
   "trackValue: " + currentTrack.trackValue + "\n" +
   "isMuted: " + currentTrack.isMuted + "\n" +
   "isSmoothed: " + currentTrack.isSmoothed + "\n" +
   "useAudio: " + currentTrack.useAudio + "\n"
   );*/
}


void UISetup()
{
  groupHeight = height-topBarHeight-consoleHeight-groupLabelHeight-inspectorHeight;
  sliderHeight = height-topBarHeight-consoleHeight-inspectorHeight-trackSettingsHeight-(padding*2);
  groupHeightPos = topBarHeight+groupLabelHeight;

  int inspectorHeightPos = height-consoleHeight-inspectorHeight+groupLabelHeight;
  int inspectorHeightSize = inspectorHeight-groupLabelHeight;

  //Inspector
  inspector = cp5.addGroup("Inspector")
    .setPosition(0, inspectorHeightPos)
    .setSize(width, inspectorHeightSize)
    .setBackgroundColor(GetPalette(3))
    .disableCollapse()
    .setMouseOver(false)
    ;

  /*
  inspectorText = cp5.addTextarea("InspectorText")
   .setPosition(0, inspectorHeightPos)
   .setSize(width, inspectorHeightSize)
   .setLineHeight(14)
   .setColor(GetPalette(4))
   .setText("")
   ;
   */
  UISetUpInspector();

  //Console
  //fill(GetPalette(0));
  //rect(0, topBarHeight, width, height-topBarHeight-consoleHeight);

  uiConsole = cp5.addTextarea("Console")
    .setPosition(0, height - consoleHeight)
    .setSize(width-2*buttonSmallSize-3*padding, consoleHeight)
    //.setLineHeight(14)
    .setColor(GetPalette(4))
    .setColorBackground(GetPalette(0))
    .setColorForeground(GetPalette(2))
    ;
  console = cp5.addConsole(uiConsole);


  scrollbar = cp5.addRange("Scrollbar")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false)
    .setPosition(0, height-consoleHeight-groupLabelHeight-inspectorHeight)
    .setSize(width, 10)
    .setHandleSize(0)
    .setRange(0, scrollbarRange)
    .setRangeValues(0, scrollbarRange)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)
    .setColorForeground(GetPalette(2))
    .setColorBackground(GetPalette(0))
    .setLabelVisible(false)
    .setVisible(false)
    ;

  cp5.addButton("dmxConnect")
    .setValue(0)
    .setPosition(addressWidth+2*padding, padding)
    .setSize(connectWidth, topBarHeight-padding*3)
    .setColor(paletteButton)
    .setCaptionLabel("Connect DMX")
    ;

  cp5.addTextfield("Address")    //Used for both IP and COM Port
    .setPosition(padding, padding)
    .setSize(addressWidth, topBarHeight-padding*3)
    .setText(address)
    .setFocus(false)
    .setCaptionLabel("input IP address or COM port...")
    .setAutoClear(false)
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

  //isReceivingMidi
  UIDrawIsReceivingMidi();


  //saving/loading patches
  cp5.addTextfield("SaveLoadPatch")
    .setPosition(padding+300+2*padding, padding)
    .setSize(addressWidth, topBarHeight-padding*3)
    .setText("patch01")
    .setFocus(false)
    .setCaptionLabel("type file name to save/load")
    ;

  cp5.addButton("SavePatch")
    .setValue(0)
    .setPosition(padding+addressWidth+padding+connectWidth+padding+addressWidth+padding, padding)
    .setSize(saveloadWidth, topBarHeight-padding*3)
    .setColor(paletteButton)
    .setCaptionLabel("Save")
    ;

  cp5.addButton("LoadPatch")
    .setValue(0)
    .setPosition(padding+addressWidth+padding+connectWidth+padding+addressWidth+padding+saveloadWidth+padding, padding)
    .setSize(saveloadWidth, topBarHeight-padding*3)
    .setColor(paletteButton)
    .setCaptionLabel("Load")
    ;


  //bottomBar
  cp5.addButton("Web")
    .setValue(128)
    .setPosition(width-buttonSmallSize-padding, height-buttonSmallSize-padding)
    .setSize(buttonSmallSize, buttonSmallSize)
    .setColor(paletteButton)
    .setCaptionLabel("?")
    ;

  cp5.addButton("ConsoleClear")
    .setValue(128)
    .setPosition(width-2*buttonSmallSize-2*padding, height-buttonSmallSize-padding)
    .setSize(buttonSmallSize, buttonSmallSize)
    .setColor(paletteButton)
    .setCaptionLabel("x")
    ;

  isSetUp = false;
  console.play();
  UIScrollbarCalculate();
  UIInspect(0);
}

void UIRefresh()
{
  //background
  UIDrawBackground();

  //topBar
  UIDrawTopBar();

  //bottomBar
  UIDrawBottomBar();

  //isReceivingMidi
  UIDrawIsReceivingMidi();

  //tracks background
  UIDrawTracks();
}

void UIDrawTopBar() {
  fill(GetPalette(2));
  rect(0, 0, width, topBarHeight);
}

void UIDrawBottomBar() {
  int bottomBarWidth = 4*padding+2*buttonSmallSize;
  noStroke();
  fill(GetPalette(2));
  rect(width-bottomBarWidth, height-consoleHeight, bottomBarWidth, consoleHeight);
}

void UIDrawBackground() {
  fill(GetPalette(0));
  rect(0, topBarHeight, width, height-topBarHeight-consoleHeight);
}

void UIDrawIsReceivingMidi() {
  if (isReceivingMidi) {
    fill(0, 255, 0);
  } else {
    fill(0);
  }
  rect(width/2, padding, 5, 5);
}

void UIDrawTracks() {
  for (int i = 0; i < tracks.size(); i++)
  {
    int bgColor = tracks.get(i).isMuted ? GetPalette(5) : GetPalette(3);
    stroke(GetPalette(0));
    fill(bgColor);
    rect(UIScrollbarGetPos(i), topBarHeight, trackWidth, height-topBarHeight-inspectorHeight-consoleHeight);
    //cp5.get(Button.class, "Inspect"+i).setColorBackground(GetPaletteColors(tracks.get(i).trackColor));
    noStroke();
    fill(GetPaletteColors(tracks.get(i).trackColor));
    rect(UIScrollbarGetPos(i)+1, topBarHeight+groupLabelHeight-1, trackWidth-1, groupLabelHeight/2);
  }
}


void UIAddTrack(int trackIndex)
{
  Track currentTrack = tracks.get(trackIndex);
  int position = trackWidth*trackIndex;
  //int groupHeight = height-topBarHeight-consoleHeight-groupLabelHeight-inspectorHeight;
  //int sliderHeight = height-topBarHeight-consoleHeight-inspectorHeight-trackSettingsHeight-(padding*2);
  //println(groupHeight);

  stroke(GetPalette(0));
  //fill(GetPalette(3));
  //rect(position, topBarHeight, trackWidth, height-topBarHeight-consoleHeight);

  Group trackGroup = cp5.addGroup("Track" + trackIndex)
    .setPosition(position, groupHeightPos)
    .setSize(trackWidth, groupHeight)
    .setBackgroundColor(color(GetPalette(3), 0))
    .disableCollapse()
    .setMouseOver(false)
    .setCaptionLabel("Track "+trackIndex)
    //.getCaptionLabel().align (ControlP5.RIGHT, ControlP5.CENTER)
    ;

  cp5.addButton("Inspect" + trackIndex)
    .setPosition(0, -groupLabelHeight)
    .setSize(trackWidth, groupLabelHeight-1)
    //.setColor(paletteButton)
    .setCaptionLabel("")
    .setGroup(trackGroup)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASE) {
        UIInspect(trackIndex);
      }
    }
  }
  )
  ;

  cp5.addSlider("Slider" + trackIndex)
    //.setPosition(position+trackWidth/2-trackSliderWidth/2, topBarHeight+padding)
    .setPosition(trackWidth/2-trackSliderWidth/2, padding)
    .setSize(trackSliderWidth, sliderHeight)
    .setRange(currentTrack.trackRangeMin, currentTrack.trackRangeMax)
    .setValue(currentTrack.trackValue)
    .setDecimalPrecision(0)
   .setCaptionLabel(""/*str(trackIndex)*/    )
    .setGroup(trackGroup)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_BROADCAST) {
        tracks.get(trackIndex).trackReceive((int)(event.getController().getValue()));
        tracks.get(trackIndex).trackSend(false);
      }
    }
  }
  )
  ;

  int settingsHeightPos = sliderHeight + 2*padding;
  String settingsLabelIn = "In ";
  String settingsLabelOut = "Out ";

  if (trackWidth <= 60)
  {
    settingsLabelIn = "";
    settingsLabelOut = "";
  }

  //SETTINGS
  cp5.addNumberbox("In" + trackIndex)
    .setPosition(padding, settingsHeightPos+padding)
    .setSize(settingWidthSize, settingsHeight)
    .setValue(currentTrack.trackInput)
    .setRange(currentTrack.trackRangeMin, currentTrack.trackRangeMax)
    .setDecimalPrecision(0)
    .setDirection(Controller.HORIZONTAL)
    .setScrollSensitivity(1)
    .setMultiplier(0.125f)
    .setCaptionLabel(settingsLabelIn)
    .setGroup(trackGroup)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASE || event.getAction() == ControlP5.ACTION_RELEASE_OUTSIDE) {
        UIUpdateInOutValues(false);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
    //.onChange(tracks.get(trackIndex).trackUpdate())
    ;

  cp5.addNumberbox("Out" + trackIndex)
    .setPosition(padding, settingsHeightPos+settingsHeight+2*padding)
    .setSize(settingWidthSize, settingsHeight)
    .setValue(currentTrack.trackOutput)
    .setRange(currentTrack.trackRangeMin, currentTrack.trackRangeMax)
    .setDecimalPrecision(0)
    .setDirection(Controller.HORIZONTAL)
    .setScrollSensitivity(1)
    .setMultiplier(0.125f)
    .setCaptionLabel(settingsLabelOut)
    .setGroup(trackGroup)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASE || event.getAction() == ControlP5.ACTION_RELEASE_OUTSIDE) {
        UIUpdateInOutValues(false);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
    ;


  cp5.addToggle("Mute" + trackIndex)
    .setValue(false)
    .setPosition(padding, settingsHeightPos+2*settingsHeight+3*padding)
    .setSize(settingWidthSize/2, settingsHeight)
    //.setColor(paletteButton)
    .setCaptionLabel("M")
    .setGroup(trackGroup)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASE) {
        TrackMute(trackIndex);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addToggle("Solo" + trackIndex)
    .setValue(false)
    .setPosition(padding+settingWidthSize/2, settingsHeightPos+2*settingsHeight+3*padding)
    .setSize(settingWidthSize/2, settingsHeight)
    //.setColor(paletteButton)
    .setCaptionLabel("S")
    .setGroup(trackGroup)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASE) {
        TrackSolo(trackIndex);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addToggle("Smooth" + trackIndex)
    .setValue(false)
    .setPosition(padding, settingsHeightPos+3*settingsHeight+4*padding)
    .setSize(settingWidthSize, settingsHeight)
    //.setColor(paletteButton)
    .setCaptionLabel("Smooth")
    .setGroup(trackGroup)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASE) {
        TrackSmooth(trackIndex);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addToggle("Audio" + trackIndex)
    .setValue(false)
    .setPosition(padding, settingsHeightPos+4*settingsHeight+5*padding)
    .setSize(settingWidthSize, settingsHeight)
    //.setColor(paletteButton)
    .setCaptionLabel("Audio")
    .setGroup(trackGroup)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASE) {
        TrackAudio(trackIndex);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  /*
   //to do: fix
   cp5.addButton("Remove" + trackIndex)
   .setPosition(position+trackWidth-buttonSmallSize/2-padding, topBarHeight+padding)
   .setSize(buttonSmallSize/2, buttonSmallSize/2)
   .setColor(paletteButton)
   .setCaptionLabel("x")
   .addCallback(new CallbackListener() {
   public void controlEvent(CallbackEvent event) {
   if (event.getAction() == ControlP5.ACTION_RELEASE) {
   TrackRemove(trackIndex);
   }
   }
   }
   );
   */
  UIScrollbarCalculate();
  UIInspect(trackIndex);
}

void UISetUpInspector() {
  int insNameSetSize = topBarHeight-padding*3;

  cp5.addTextfield("InspectorName")
    .setGroup(inspector)
    .setPosition(padding, padding)
    .setSize(addressWidth-buttonSmallSize, insNameSetSize)
    .setText("")
    .setFocus(false)
    .setCaptionLabel("Track Name")
    .setAutoClear(false)
    ;

  cp5.addButton("InspectorNameSet")
    .setGroup(inspector)
    .setPosition(addressWidth, padding)
    .setSize(insNameSetSize, insNameSetSize)
    .setColor(paletteButton)
    .setCaptionLabel(">")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  UISetUpInspectorColors();

  cp5.addNumberbox("InspectorIn")
    .setGroup(inspector)
    .setPosition(padding, padding+3*insNameSetSize)
    .setSize(settingWidthSize, settingsHeight)
    .setValue(0)
    .setRange(0, 255)
    .setDecimalPrecision(0)
    .setDirection(Controller.HORIZONTAL)
    .setScrollSensitivity(1)
    .setMultiplier(0.125f)
    .setCaptionLabel("In")
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASE || event.getAction() == ControlP5.ACTION_RELEASE_OUTSIDE) {
        UIUpdateInOutValues(true);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
    ;

  cp5.addNumberbox("InspectorOut")
    .setGroup(inspector)
    .setPosition(2*padding+settingWidthSize, padding+3*insNameSetSize)
    .setSize(settingWidthSize, settingsHeight)
    .setValue(0)
    .setRange(0, 255)
    .setDecimalPrecision(0)
    .setDirection(Controller.HORIZONTAL)
    .setScrollSensitivity(1)
    .setMultiplier(0.125f)
    .setCaptionLabel("Out")
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASE || event.getAction() == ControlP5.ACTION_RELEASE_OUTSIDE) {
        UIUpdateInOutValues(true);
      }
    }
  }
  )

  .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
    ;
}

void UIUpdateInOutValues(boolean fromInspector) {
  if (fromInspector) {
    cp5.get(Numberbox.class, "In"+currentTrackInspected).setValue(cp5.get(Numberbox.class, "InspectorIn").getValue());
    cp5.get(Numberbox.class, "Out"+currentTrackInspected).setValue(cp5.get(Numberbox.class, "InspectorOut").getValue());
  } else {
    cp5.get(Numberbox.class, "InspectorIn").setValue(cp5.get(Numberbox.class, "In"+currentTrackInspected).getValue());
    cp5.get(Numberbox.class, "InspectorOut").setValue(cp5.get(Numberbox.class, "Out"+currentTrackInspected).getValue());
  }
}

void InspectorNameSet() {
  if (!isSetUp)
  {
    String newName = cp5.get(Textfield.class, "InspectorName").getText();
    tracks.get(currentTrackInspected).trackName = newName;
    cp5.getGroup("Track"+currentTrackInspected).setCaptionLabel(tracks.get(currentTrackInspected).trackName);
  }
}


void UISetUpInspectorColors() {
  for (int i = 0; i < paletteColors.length; i++) {
    UICreateColorButton(i);
  }
}

void UICreateColorButton(int colorIndex) {

  cp5.addButton("Color" + colorIndex)
    .setGroup(inspector)
    .setPosition(padding + buttonSmallSize*colorIndex, settingsHeight+4*padding)
    .setSize(buttonSmallSize, buttonSmallSize)
    .setColorBackground(GetPaletteColors(colorIndex))
    .setColorForeground(GetPaletteColors(colorIndex))
    .setCaptionLabel("")
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASE) {
        UIInspectorColorSelect(colorIndex);
      }
    }
  }
  );
}

void UIInspectorColorSelect(int c) {
  TrackColor(currentTrackInspected, c);
}


void UIScrollbarCalculate() {
  scrollbarRange = tracks.size()*trackWidth;
  scrollbar.setRange(0, scrollbarRange);

  if (scrollbarRange > width) {

    scrollbar.setRangeValues(0, (width-(scrollbarRange-width))-trackWidth*(27-tracks.size())-10);  //to do: fix scrollbar going back to 0 when adding a new track
    scrollbar.setVisible(true);
  } else {
    scrollbar.setRangeValues(0, width);
    scrollbar.setVisible(false);
  }
}

void Scrollbar() {
  UIScrollbarMove();
}

void UIScrollbarMove() {

  for (int i = 0; i < tracks.size(); i++) {
    cp5.getGroup("Track" + i).setPosition(UIScrollbarGetPos(i), groupHeightPos);
  }
}

int UIScrollbarGetPos(int i) {
  int pos = (-int(scrollbar.getArrayValue(0))+(i*trackWidth));
  return pos;
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
