import processing.sound.*;

Amplitude audioAmp;
AudioIn audioIn;

boolean useAudio = false;
boolean testingAudio = false;

int audioPreAmp = 6;

ArrayList<AudioInput> audioInList = new ArrayList<AudioInput>();

class AudioInput {

  int inputIndex = 0;
  String inputName = "-";

  AudioInput (int inIndex, String inName) {
    inputIndex = inIndex;
    inputName = inName;
  }
}


void AudioSetup() {
  String[] audioDevices = Sound.list();
  for (int i = 0; i < audioDevices.length; i++) {
    audioInList.add(new AudioInput(i, audioDevices[i]));
    println(i + " | " + audioDevices[i]);
  }
}

void CreateAudioInput(int audioInput) {

  if (!testingAudio)
  {
    // Create an Input stream which is routed into the Amplitude analyzer
    audioAmp = new Amplitude(this);
    audioIn = new AudioIn(this, audioInput);
    audioIn.start();
    audioAmp.input(audioIn);
    useAudio = true;
    testingAudio = true;
    println("Audio enabled");
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
