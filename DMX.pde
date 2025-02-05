import dmxP512.*;
import processing.serial.*;


//DMXP512 variables
DmxP512 dmxOutput;
int universeSize=128;
boolean LANBOX=false;
String LANBOX_IP="192.168.1.77";  //update IP
boolean DMXPRO=true;
String DMXPRO_PORT="COM4";        //case matters ! on windows port must be upper cased.
int DMXPRO_BAUDRATE=115000;

boolean sendDMX = false;          //CHANGE TO TRUE ON EXPORT !!!

void dmxConnect()
{
  if (!isSetUp)
  {
    sendDMX = true;
    if (sendDMX)
    {
      address = cp5.get(Textfield.class, "Address").getText();
      ConsolePrint("Attempting DMX connection to address " + address + "...");
      if (DMXPRO)
      {
        dmxOutput.setupDmxPro(address, DMXPRO_BAUDRATE); //DMXPRO_PORT
        ConsolePrint("DMX USB Pro detected on port: " + address);
      } else if (LANBOX) {
        dmxOutput.setupLanbox(address); //LANBOX_IP
        ConsolePrint("LANBOX detected on IP: " + address);
      } else
      {
        delay(1000);
        ConsolePrint("DMX connection failed");
      }
    } else {
      ConsolePrint("DMX connection not enabled");
    }
  }
}
