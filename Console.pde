String lastConsoleMessage = " ";

void ConsolePrint(String message)
{
  println(message);
  fill(GetPalette(0));
  rect(0, height - consoleHeight, width, consoleHeight);
  fill(GetPalette(3));
  text(message, 5, height - 5);
  fill(GetPalette(3), 127);
  text(lastConsoleMessage, 5, height - 20);

  lastConsoleMessage = message;
}

void ConsoleClear()
{
  fill(GetPalette(2));
  rect(0, height - consoleHeight, width, consoleHeight);
}
