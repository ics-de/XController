int topBarHeight = 60;
int consoleHeight = 40;

int trackWidth = 100;
int trackSliderWidth = 20;
int trackSettingsHeight = 200;

int settingsHeight = 20;

int padding = 10;

DropdownList midiInList;
DropdownList midiOutList;


void UISetup()
{
  fill(GetPalette(2));
  rect(0, topBarHeight, width/2, height-topBarHeight-consoleHeight);

  cp5.addButton("dmxConnect")
    .setValue(0)
    .setPosition(210+padding, padding)
    .setSize(150, topBarHeight-padding*3)
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
    .setPosition(width/2, padding)
    .setSize(25, 25)
    .setCaptionLabel("+")
    ;

  midiInList = cp5.addDropdownList("midiIn")
    .setPosition(width/2 + padding, topBarHeight + padding)
    ;


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
    .setCaptionLabel(str(trackIndex))
    ;

int settingsHeightPos = height-topBarHeight-consoleHeight-6*settingsHeight;

  cp5.addTextfield("In" + trackIndex)
    .setPosition(position+padding, settingsHeightPos+padding)
    .setSize(trackWidth-padding*2, settingsHeight)
    .setText(str(currentTrack.trackInput))
    .setFocus(false)
    .setCaptionLabel("In")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addTextfield("Out" + trackIndex)
    .setPosition(position+padding, settingsHeightPos+2*settingsHeight+padding)
    .setSize(trackWidth-padding*2, settingsHeight)
    .setText(str(currentTrack.trackOutput))
    .setFocus(false)
    .setCaptionLabel("Out")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
}
