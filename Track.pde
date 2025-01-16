
class Track {
  int trackValue = 127;
  int trackRangeMin = 0;
  int trackRangeMax = 255;

  int trackInput = 0;
  int trackOutput = 0;

  Track (int tValue, int tRangeMin, int tRangeMax, int tInput, int tOutput) {
    trackValue = tValue;
    trackRangeMin = tRangeMin;
    trackRangeMax = tRangeMax;
    trackInput = tInput;
    trackOutput = tOutput;
  }

  void trackReceive()
  {
    trackValue = midiInValues.get(trackInput);
    ConsolePrint("sending " + trackValue + "to channel " + trackOutput);
  }

  void trackSend()
  {
    dmxOutput.set(trackOutput, trackValue);
    ConsolePrint("sending " + trackValue + "to channel " + trackOutput);
  }
}

public void TrackCreateDefault()
{
  int trackIndex = tracks.size();
  TrackCreate(0, 0, 255, 0, trackIndex);
}

void TrackCreate(int tValue, int tRangeMin, int tRangeMax, int tInput, int tOutput)
{
  int trackIndex = tracks.size();

  tracks.add(new Track(tValue, tRangeMin, tRangeMax, tInput, tOutput));

  UIAddTrack(trackIndex);
}
