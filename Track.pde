class Track {
  int trackValue = 127;
  int trackRangeMin = 0;
  int trackRangeMax = 255;

  int trackIndex = 0;

  //Track Settings
  int trackInput = 0;
  int trackOutput = 0;
  boolean isMuted = false;
  boolean isSmoothed = false;
  boolean useAudio = false;

  Track (int tValue, int tRangeMin, int tRangeMax, int tInput, int tOutput, int tIndex) {
    trackValue = tValue;
    trackRangeMin = tRangeMin;
    trackRangeMax = tRangeMax;

    trackIndex = tIndex;

    trackInput = tInput;
    trackOutput = tOutput;
    isMuted = false;
    isSmoothed = false;
    useAudio = false;
  }

  void trackReceive(int tValue)
  {
    if (!isMuted)
    {
      int newValue = 0;

      //if (!useAudio)
      //{

      if (isSmoothed)
      {
        newValue = ceil(lerp(tValue, trackValue, 0.1f));
      } else {
        newValue = tValue;
      }
      //}

      trackValue = constrain(newValue, trackRangeMin, trackRangeMax);
    }
  }

  void trackSend(boolean UpdateSlider)
  {
    if (!isMuted)
    {
      dmxOutput.set(trackOutput, trackValue);
      //ConsolePrint("sending " + trackValue + " to channel " + trackOutput);

      if (UpdateSlider)
      {
        cp5.get(Slider.class, "Track" + trackIndex).setValue(trackValue);
      }
    }
  }

  void trackUpdate()
  {
    trackInput = int(cp5.get(Numberbox.class, "In"+trackIndex).getValue());
    trackOutput = int(cp5.get(Numberbox.class, "Out"+trackIndex).getValue());
  }
}


public enum TrackType {
  MIDI_CC (),
    MIDI_NOTE (),
    AUDIO (),
    MATH ();

  TrackType() {
  }
}

void TrackCreate(int tValue, int tRangeMin, int tRangeMax, int tInput, int tOutput, int tIndex)
{
  int trackIndex = tracks.size();

  tracks.add(new Track(tValue, tRangeMin, tRangeMax, tInput, tOutput, tIndex));

  UIAddTrack(trackIndex);
}

//default method for creating new tracks, mapped to the [+] button
public void TrackCreateDefault()
{
  UpdateTracks();
  int tIndex = tracks.size();
  if (tIndex == 0)
  {
    TrackCreate(0, 0, 255, tIndex, tIndex, tIndex);
  } else
  {
    TrackCreate(0, 0, 255, tracks.get(tIndex-1).trackInput + 1, tracks.get(tIndex-1).trackOutput + 1, tIndex);
  }
}


public void TrackRemove(int tIndex)
{
  tracks.remove(tIndex);
  cp5.remove("Track"+tIndex);
  cp5.remove("In"+tIndex);
  cp5.remove("Out"+tIndex);
  cp5.remove("Mute"+tIndex);
  cp5.remove("Solo"+tIndex);
  cp5.remove("Smooth"+tIndex);
  cp5.remove("Remove"+tIndex);

  fill(GetPalette(0));
  rect(trackWidth*tIndex, topBarHeight, trackWidth, height-topBarHeight-consoleHeight);
}

public void TrackMute(int tIndex)
{
  tracks.get(tIndex).isMuted = !tracks.get(tIndex).isMuted;
  if (tracks.get(tIndex).isMuted)
  {
    cp5.get(Toggle.class, "Solo"+tIndex).setState(false);
  } else {
    //TrackSolo(tIndex);
  }
}

public void TrackSolo(int tIndex)
{
  if (cp5.get(Toggle.class, "Solo"+tIndex).getState() == true)
  {
    for (int i = 0; i < tracks.size(); i++)
    {
      if (i != tIndex)
      {
        tracks.get(i).isMuted = true;
        cp5.get(Toggle.class, "Mute"+i).setValue(true);
        cp5.get(Toggle.class, "Solo"+i).setValue(false);
      }
    }
    tracks.get(tIndex).isMuted = false;
    cp5.get(Toggle.class, "Mute"+tIndex).setValue(false);
  } else {
    for (int i = 0; i < tracks.size(); i++)
    {
      tracks.get(i).isMuted = false;
      cp5.get(Toggle.class, "Mute"+i).setValue(false);
      cp5.get(Toggle.class, "Solo"+i).setValue(false);
    }
  }
}

public void TrackSmooth(int tIndex)
{
  tracks.get(tIndex).isSmoothed = !tracks.get(tIndex).isSmoothed;
}

public void TrackAudio(int tIndex)
{
  tracks.get(tIndex).useAudio = !tracks.get(tIndex).useAudio;
  AudioSetUp(tracks.get(tIndex).trackInput);
}

/*[LEGACY] find the track with the matching trackInput and return its index in tracks
 int TrackFind(int tInput)
 {
 
 int index = -1;  //Setting it to -1 creates errors with MidiBus
 for (int i = 0; i < tracks.size(); i++)
 {
 tracks.get(i).trackUpdate();
 tracks.get(i).trackIndex = i;
 //println(tracks.get(i).trackInput + " == " + tInput);
 if (tracks.get(i).trackInput == tInput)
 {
 index = i;
 }
 }
 
 if (index == -1)
 {
 //ConsolePrint("Track " + tInput + " not found.");
 }
 
 return index;
 }
 */


//find all tracks with the same trackInput and return them as an IntList
IntList TrackFindAll(int tInput)
{

  IntList indexes = new IntList();
  for (int i = 0; i < tracks.size(); i++)
  {
    tracks.get(i).trackUpdate();
    tracks.get(i).trackIndex = i;
    if (tracks.get(i).trackInput == tInput)
    {
      indexes.append(i);
    }
  }
  return indexes;
}

void UpdateTracks()
{
  for (int i = 0; i<tracks.size(); i++)
  {
    tracks.get(i).trackUpdate();
  }
}
