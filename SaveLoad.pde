void SavePatch()
{
  if (!isSetUp)
  {
    Save(cp5.get(Textfield.class, "SaveLoadPatch").getText());
  }
}

void LoadPatch()
{
  if (!isSetUp)
  {
    Load(cp5.get(Textfield.class, "SaveLoadPatch").getText());
  }
}

void Save(String fileName) {

  Table SaveFile = new Table();

  SaveFile.addColumn("address");
  //SaveFile.addColumn("midiIn");

  SaveFile.addColumn("index");
  SaveFile.addColumn("in");
  SaveFile.addColumn("out");

  for (int i = 0; i < tracks.size(); i++)
  {
    TableRow newRow = SaveFile.addRow();
    Track currentTrack = tracks.get(i);
    if (i == 0)
    {
      address = cp5.get(Textfield.class, "Address").getText();
      newRow.setString("address", address);
      //newRow.setInt("midiIn", i);
    }

    newRow.setInt("index", i);
    newRow.setInt("in", currentTrack.trackInput);
    newRow.setInt("out", currentTrack.trackOutput);
  }

  saveTable(SaveFile, "data/patches/" + fileName + ".csv");
  ConsolePrint("Succesfully saved '" + fileName +".csv' in /patches");
}

void Load(String fileName) {

  Table LoadFile;

  //This doesn't seem to be working
  try {
    // Attempt to load the file
    LoadFile = loadTable("patches/" + fileName + ".csv", "header,csv");
  }
  catch (Exception e) {
    // Handle the case where the file is not found
    ConsolePrint("Error: File '" + fileName + ".csv' not found!");
    return; // Exit the method
  }

  if (LoadFile != null) {
    for (int i = tracks.size(); i < LoadFile.getRowCount(); i++) {
      TrackCreateDefault();
    }

    cp5.get(Textfield.class, "Address").setText(LoadFile.getRow(0).getString("address"));
    address = cp5.get(Textfield.class, "Address").getText();

    for (TableRow row : LoadFile.rows()) {
      int trackIndex = row.getInt("index");


      tracks.get(trackIndex).trackInput = row.getInt("in");
      tracks.get(trackIndex).trackOutput = row.getInt("out");

      cp5.get(Numberbox.class, "In"+trackIndex).setValue(row.getInt("in"));
      cp5.get(Numberbox.class, "Out"+trackIndex).setValue(row.getInt("out"));

    }
    ConsolePrint("Succesfully loaded '" + fileName +".csv'");
  } else {
    ConsolePrint("Error: File '" + fileName + ".csv' not found!");
  }
}
