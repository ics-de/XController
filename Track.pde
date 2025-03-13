ArrayList<Track> tracks = new ArrayList<Track>();

class Track {

  int trackIndex = 0;
  String trackName = "Track";
  int trackColor = 0;

  int trackValue = 127;
  int trackRangeMin = 0;
  int trackRangeMax = 255;

  //Track Settings
  int trackChannel = 0;
  int trackInput = 0;
  int trackOutput = 0;
  boolean isMuted = false;
  boolean isSmoothed = false;
  boolean useAudio = false;

  Track (int tValue, int tRangeMin, int tRangeMax, int tChannel, int tInput, int tOutput, int tIndex, String tName, int tColor) {
    trackValue = tValue;
    trackRangeMin = tRangeMin;
    trackRangeMax = tRangeMax;

    trackIndex = tIndex;
    trackName = tName;
    trackColor = tColor;

    trackChannel = tChannel;
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
        delay(10);
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
        cp5.get(Slider.class, "Slider" + trackIndex).setValue(trackValue);
      }
    }
  }

  void trackUpdate()
  {
    trackChannel = int(cp5.get(Numberbox.class, "Ch"+trackIndex).getValue());
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

void TrackCreate(int tValue, int tRangeMin, int tRangeMax, int tChannel, int tInput, int tOutput, int tIndex, String tName, int tColor)
{
  int trackIndex = tracks.size();

  tracks.add(new Track(tValue, tRangeMin, tRangeMax, tChannel, tInput, tOutput, tIndex, tName, tColor));

  UIAddTrack(trackIndex);
}

//default method for creating new tracks, mapped to the [+] button
public void TrackCreateDefault()
{
  if (tracks.size() < dmxChannels)
  {
    UpdateTracks();
    int tIndex = tracks.size();
    if (tIndex == 0)
    {
      TrackCreate(0, 0, 255, 0, tIndex, tIndex, tIndex, "Track 0", 1);
    } else
    {
      TrackCreate(0, 0, 255, tracks.get(tIndex-1).trackChannel, tracks.get(tIndex-1).trackInput + 1, tracks.get(tIndex-1).trackOutput + 1, tIndex, "Track " + tIndex, tracks.get(tIndex-1).trackColor);
    }
  } else {
    println("Max tracks reached: " + dmxChannels);
  }
}


public void TrackRemove(int tIndex)
{
  ControllerGroup g = cp5.getGroup("Track" + tIndex);

  g.getController("Inspect"+tIndex).remove();
  g.getController("Slider"+tIndex).remove();
  g.getController("Ch"+tIndex).remove();
  g.getController("In"+tIndex).remove();
  g.getController("Out"+tIndex).remove();
  g.getController("Mute"+tIndex).remove();
  g.getController("Solo"+tIndex).remove();
  g.getController("Smooth"+tIndex).remove();
  g.getController("Audio"+tIndex).remove();
  //g.getController("Remove"+tIndex).remove();

  cp5.remove("Track"+tIndex);

  //tracks.remove(tIndex);
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
  CreateAudioInput(tracks.get(tIndex).trackInput);
}

public void TrackColor(int tIndex, int tColor)
{
  tracks.get(tIndex).trackColor = tColor;
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

IntList TrackFindAllByCC(int tChannel, int tInput)
{
  IntList indexes = new IntList();
  for (int i = 0; i < tracks.size(); i++)
  {
    Track tCurrent = tracks.get(i);
    tCurrent.trackUpdate();
    if (tCurrent.trackChannel == tChannel)
    {
      if (tCurrent.trackInput == tInput)
      {
        indexes.append(i);
      }
    }
  }
  return indexes;
}

//find all tracks with the same trackChannel and return them as an IntList
IntList TrackFindAllByChannel(int tChannel)
{

  IntList indexes = new IntList();
  for (int i = 0; i < tracks.size(); i++)
  {
    tracks.get(i).trackUpdate();
    //tracks.get(i).trackIndex = i;
    if (tracks.get(i).trackChannel == tChannel)
    {
      indexes.append(i);
    }
  }
  return indexes;
}

//find all tracks with the same trackInput and return them as an IntList
IntList TrackFindAllByInput(int tInput, IntList tracksInChannel)
{

  IntList indexes = new IntList();
  for (int i = 0; i < tracksInChannel.size(); i++)
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
