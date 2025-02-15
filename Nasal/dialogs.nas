print ("Britannia dialogs.nas");

##### Britannia Location In Air Dialog

# Overwrite the original menu
var location_settings = gui.Dialog.new("/sim/gui/dialogs/Britannia-position/dialog","Aircraft/Britannia/Dialogs/Britannia-location-in-air.xml");
gui.menuBind("position-in-air", "dialogs.location_settings.open()");


