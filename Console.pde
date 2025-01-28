String lastConsoleMessage = "";
String currentConsoleMessage = "";

void ConsolePrint(String message)
{
  lastConsoleMessage = currentConsoleMessage;
  currentConsoleMessage = message;
  println(message);
  
}

void ConsoleClear()
{
  fill(GetPalette(2));
  rect(0, height - consoleHeight, width, consoleHeight);
}
