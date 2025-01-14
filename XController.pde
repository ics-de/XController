import dmxP512.*;
import processing.serial.*;

import controlP5.*;

//DMXP512 variables
DmxP512 dmxOutput;
int universeSize=128;
boolean LANBOX=false;
String LANBOX_IP="192.168.1.77";  //update IP
boolean DMXPRO=true;
String DMXPRO_PORT="COM4";        //case matters ! on windows port must be upper cased.
int DMXPRO_BAUDRATE=115000;


//ControlP5 variables
ControlP5 cp5;

boolean sendDMX = true;
String address = "COM4";          //either port COM4 or IP

boolean isSetUp = true;


String lastConsoleMessage = "";

void setup()
{
  //DMXP512 setup
  dmxOutput=new DmxP512(this, universeSize, false);

  //ControlP5 setup
  cp5 = new ControlP5(this);


  //User Interface Setup
  size(1000, 1000);
  background(0);

  //PFont font = createFont("arial",12);

  ConsolePrint("Welcome to XController by Oriol Colomer Delgado - @oriolonbass | 2025");

  cp5.addButton("Connect")
    .setValue(0)
    .setPosition(210, 5)
    .setSize(150, 30)
    //.setFont(font)
    ;

  cp5.addTextfield("Address")    //Used for both IP and COM Port
     .setPosition(5, 5)
     .setSize(200,30)
     .setText(address)
     //.setFont(font)
     .setFocus(false)
     .setColor(color(255))
     .setCaptionLabel("input IP address or COM port...")
     ;

  isSetUp = false;
}

void draw()
{
  
}

//UI Functions
public void Connect()
{
  if (!isSetUp)
  {
    address = cp5.get(Textfield.class,"Address").getText();
    ConsolePrint("Attempting DMX connection to address " + address + "...");
    dmxConnect();
  }
}

void dmxConnect()
{
  if (DMXPRO && sendDMX)
  {
    dmxOutput.setupDmxPro(address, DMXPRO_BAUDRATE); //DMXPRO_PORT
    ConsolePrint("DMX USB Pro detected on port: " + address);
  } else if (LANBOX && sendDMX) {
    dmxOutput.setupLanbox(address); //LANBOX_IP
    ConsolePrint("LANBOX detected on IP: " + address);
  } else
  {
    delay(1000);
    ConsolePrint("DMX connection failed");
  }
}

void ConsolePrint(String message)
{
  println(message);
  fill(0);
  rect(0, height - 30, width, 30);
  fill(255);
  text(message, 5, height - 5);
  fill(127);
  text(lastConsoleMessage, 5, height - 20);

  lastConsoleMessage = message;
}
