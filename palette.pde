color[] palette = new color[7];

color[] paletteColors = new color[11];

CColor paletteButton;

CColor paletteGroup;
CColor paletteGroupMuted;

void SetPalette()
{
  palette[0] = #000000;  //0 = background
  palette[1] = #D66853;  //1 = primary
  palette[2] = #11151C;  //2 = secondary
  palette[3] = #6C6C6C;  //3 = tertiary
  palette[4] = #ffffff;  //4 = text
  palette[5] = #7d4e57;  //5 = primary_pressed (muted)
  palette[6] = #002d5a;  //6 = cP5 buttons


  paletteColors[0] = #000000;
  paletteColors[1] = #6C6C6C;
  paletteColors[2] = #ffffff;  
  paletteColors[3] = #002d5a;  //cP5 buttons
  paletteColors[4] = #FF0000;  //red
  paletteColors[5] = #FF7700;  //orange
  paletteColors[6] = #FFD000;  //yellow
  paletteColors[7] = #59FF00;  //green
  paletteColors[8] = #00BFFF;  //blue light
  paletteColors[9] = #8800FF;  //violet
  paletteColors[10] = #FF59FF;  //pink
  

  paletteButton = new CColor();
  paletteButton.setBackground(palette[1]);
  paletteButton.setForeground(palette[5]);
  paletteButton.setActive(palette[1]);

  paletteGroup = new CColor();
  paletteGroup.setBackground(palette[6]);
  paletteButton.setForeground(palette[3]);
  paletteButton.setActive(palette[3]);
  
  paletteGroupMuted = new CColor();
  paletteGroupMuted.setBackground(palette[5]);
  paletteButton.setForeground(palette[5]);
  paletteButton.setActive(palette[5]);
}

color GetPalette(int index)
{
  return palette[index];
}

color GetPaletteColors(int index)
{
  return paletteColors[index];
}
