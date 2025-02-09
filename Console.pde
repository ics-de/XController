//String lastConsoleMessage = "";
//String currentConsoleMessage = "";

Println console;

void ConsolePrint(String message)
{
  if (message != null && !message.trim().isEmpty()) {
  //lastConsoleMessage = currentConsoleMessage;
  //currentConsoleMessage = message;
  println(message);
  }
}

void ConsoleClear()
{
  console.clear();
  //fill(GetPalette(2));
  //rect(0, height - consoleHeight, width, consoleHeight);
}
