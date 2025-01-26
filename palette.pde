color[] palette = new color[6];

CColor paletteButton;

void SetPalette()
{
  palette[0] = #000000;  //0 = background
  palette[1] = #D66853;  //1 = primary
  palette[2] = #11151C;  //2 = secondary
  palette[3] = #6C6C6C;  //3 = tertiary
  palette[4] = #ffffff;  //4 = text
  palette[5] = #7d4e57;  //5 = primary_pressed

  paletteButton = new CColor();
  paletteButton.setBackground(palette[1]);
  paletteButton.setForeground(palette[5]);
  paletteButton.setActive(palette[1]);
}

color GetPalette(int index)  //0 = background, 1 = primary, 2 = secondary, 3 = text
{
  return palette[index];
}
