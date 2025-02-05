import processing.sound.*;

Amplitude audioAmp;
AudioIn audioIn;

boolean useAudio = false;
boolean testingAudio = false;

int audioPreAmp = 6;

void AudioSetUp(int audioInput) {

  if(!testingAudio)
  {
  // Create an Input stream which is routed into the Amplitude analyzer
  audioAmp = new Amplitude(this);
  audioIn = new AudioIn(this, /*audioInput*/1);
  audioIn.start();
  audioAmp.input(audioIn);
  useAudio = true;
  testingAudio = true;
  }
}

void AudioUpdate() {
  for (int i = 0; i < tracks.size(); i++)
  {
    Track currentTrack = tracks.get(i);
    if (currentTrack.useAudio)
    {
      int audioAmplitude = ceil(audioAmp.analyze()*audioPreAmp*255)-1;
      currentTrack.trackReceive(audioAmplitude);
      currentTrack.trackSend(true);
      //println(audioAmplitude);
    }
  }
}
