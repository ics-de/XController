int topBarHeight = 60;
int consoleHeight = 40;

int trackWidth = 100;
int trackSliderWidth = 20;
int trackSettingsHeight = 200;

int padding = 10;

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
    .setSize(25,25)
    .setCaptionLabel("+")
    ;

  MIDIinputs = cp5.addDropdownList("MIDIinputsList")
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
}

void slider(float theColor) {
  println("a slider event. setting background to "+theColor);
}
