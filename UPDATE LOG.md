# Initial Commit 	14/01/2025 1:58am
-created repository


# v.0.1			14/01/2025 2:12am
-started project
-integrated DMX connection, DMX interface selection and DMX output
-added Console functionality


# v.0.2 		16/01/2025
-separated functionalities into their own .pde files
-created Track class with trackReceive() and trackSend() functions
-set up User Interface, track creation
-created Palette for easier color management


# v.0.3 		18/01/2025
-started MIDI implementation


# v.0.4 		23/01/2025
-implemented MIDI input via CC protocol
-fixed issue with TheMidiBus disabling input on error caused by ConsolePrint()
-added MIDI input channel selection and DMX output channel selection for each track
-added MIDI to DMX value scaling (from 0-127 to 0-255)

# v.0.5 		26/01/2025
-implemented MIDI input selection through the User Interface
-updated color Palette
-added dispose() function to fix onExit errors
-fixed tracks receiving input when only one track exists
-it is now possible to send the same input to multiple channels through TrackFindAll(). ex: three channels receiving synchronous input from the same MIDI CC number
-deprecated TrackFind()
-added comments to various functions
-added this "UPDATE LOG.md" file
-added "examples" folder with a prepared example to send MIDI CC from Ableton through loopMIDI on Windows 10