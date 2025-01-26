
class Track {
  int trackValue = 127;
  int trackRangeMin = 0;
  int trackRangeMax = 255;

  int trackInput = 0;
  int trackOutput = 0;

  int trackIndex = 0;

  Track (int tValue, int tRangeMin, int tRangeMax, int tInput, int tOutput, int tIndex) {
    trackValue = tValue;
    trackRangeMin = tRangeMin;
    trackRangeMax = tRangeMax;
    trackInput = tInput;
    trackOutput = tOutput;
    trackIndex = tIndex;
  }

  void trackReceive(int tValue)
  {
    //trackValue = midiIn.get(trackInput);
    //ConsolePrint("sending " + trackValue + "to channel " + trackOutput);
    trackValue = constrain(tValue, trackRangeMin, trackRangeMax);
  }

  void trackSend()
  {
    dmxOutput.set(trackOutput, trackValue);
    //ConsolePrint("sending " + trackValue + " to channel " + trackOutput);
  }

  void trackUpdate()
  {
    trackInput = int(cp5.get(Numberbox.class, "In"+trackIndex).getValue());
    trackOutput = int(cp5.get(Numberbox.class, "Out"+trackIndex).getValue());
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
  cp5.remove("Remove"+tIndex);
  
  fill(GetPalette(0));
  rect(trackWidth*tIndex, topBarHeight, trackWidth, height-topBarHeight-consoleHeight);
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
