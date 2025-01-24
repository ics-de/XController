color[] palette = new color[5];

CColor paletteButton;

void SetPalette()  //0 = background, 1 = primary, 2 = secondary, 3 = text
{
  palette[0] = #000000;
  palette[1] = #D66853;
  palette[2] = #11151C;
  palette[3] = #ffffff;
  palette[4] = #7d4e57;

  paletteButton = new CColor();
  paletteButton.setBackground(palette[1]);
  paletteButton.setForeground(palette[4]);
  paletteButton.setActive(palette[1]);
}

color GetPalette(int index)  //0 = background, 1 = primary, 2 = secondary, 3 = text
{
  return palette[index];
}
