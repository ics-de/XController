color[] palette = new color[4];


void SetPalette()  //0 = background, 1 = primary, 2 = secondary, 3 = text
{
 palette[0] = #211A1D;
 palette[1] = #8075FF;
 palette[2] = #000000;
 palette[3] = #ffffff;
}

color GetPalette(int index)  //0 = background, 1 = primary, 2 = secondary, 3 = text
{
 return palette[index];
}
