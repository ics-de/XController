# UPDATE LOG

### To Do List
* to do: add an AudioInput dropdown list just like the MidiInput one
* to do: move track's UI inside a ControlP5 group

## v 0.4.2 | 09/02/2025
* converted the Console UI to a ControlP5 TextArea for easier use and info management
* started moving track UI to ControlP5 Group

## v 0.4.1 | 05/02/2025
* restructured version naming
* added media
* added "default.csv" patch

## v 0.4 | 05/02/2025
* started implementation of audio analysis to connect audio inputs to DMX channels, investigating FFT too
* cleaned up how trackReceive() works
* Improved MIDI input feedback in UI
* started implementation of TrackType (that being either MIDI CC, MIDI Note, Audio or by Math function)
-added "default.csv" patch


## v 0.3.1 | 31/01/2025
* track slider's value is now properly sent to the track's output channel
* added value smoothing. there's still fixes for it to properly work with constant MIDI updates
* added track soloing
* added UI indicator to show the user the software is receiving MIDI data
* to do: add automatic functions


## v 0.3 | 28/01/2025
* fixed UI overdraw bug with UIRefresh()
* added track muting
* address is now saved in saved patches
* moved console's draw functions to UserInterface


## v 0.2.3 | 26/01/2025
* flipped this log's order for easier reading
* added save/load functionality (restart is recommended before loading)
* added "?" button that links to the GitHub page


## v 0.2.2 | 26/01/2025
* implemented MIDI input selection through the User Interface
* updated color Palette
* added dispose() function to fix onExit errors
* fixed tracks receiving input when only one track exists
* it is now possible to send the same input to multiple channels through TrackFindAll(). ex: three channels receiving synchronous input from the same MIDI CC number
* deprecated TrackFind()
* added comments to various functions
* added this "UPDATE LOG.md" file
* added "examples" folder with a prepared example to send MIDI CC from Ableton through loopMIDI on Windows 10


## v 0.2.1 | 23/01/2025
-implemented MIDI input via CC protocol
-fixed issue with TheMidiBus disabling input on error caused by ConsolePrint()
-added MIDI input channel selection and DMX output channel selection for each track
-added MIDI to DMX value scaling (from 0-127 to 0-255)


## v 0.2 | 18/01/2025
* started MIDI implementation


## v 0.1.1 | 16/01/2025
* separated functionalities into their own .pde files
* created Track class with trackReceive() and trackSend() functions
* set up User Interface, track creation
* created Palette for easier color management


## v 0.1 | 14/01/2025
* started project
* integrated DMX connection, DMX interface selection and DMX output
* added Console functionality


## Initial Commit | 14/01/2025
* created repository