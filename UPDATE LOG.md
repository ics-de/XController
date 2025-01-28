## v 0.7		28/01/2025
-fixed UI overdraw bug with UIRefresh()
-added track muting
-address is now saved in saved patches
-moved console's draw functions to UserInterface

## v 0.6 		26/01/2025
-flipped this log's order for easier reading
-added save/load functionality (restart is recommended before loading)
-added "?" button that links to the GitHub page


## v 0.5 		26/01/2025
-implemented MIDI input selection through the User Interface
-updated color Palette
-added dispose() function to fix onExit errors
-fixed tracks receiving input when only one track exists
-it is now possible to send the same input to multiple channels through TrackFindAll(). ex: three channels receiving synchronous input from the same MIDI CC number
-deprecated TrackFind()
-added comments to various functions
-added this "UPDATE LOG.md" file
-added "examples" folder with a prepared example to send MIDI CC from Ableton through loopMIDI on Windows 10


## v 0.4 		23/01/2025
-implemented MIDI input via CC protocol
-fixed issue with TheMidiBus disabling input on error caused by ConsolePrint()
-added MIDI input channel selection and DMX output channel selection for each track
-added MIDI to DMX value scaling (from 0-127 to 0-255)


## v 0.3 		18/01/2025
-started MIDI implementation


## v 0.2 		16/01/2025
-separated functionalities into their own .pde files
-created Track class with trackReceive() and trackSend() functions
-set up User Interface, track creation
-created Palette for easier color management


## v 0.1			14/01/2025
-started project
-integrated DMX connection, DMX interface selection and DMX output
-added Console functionality


## Initial Commit 	14/01/2025
-created repository