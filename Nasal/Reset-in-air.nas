#################################################################################
#                              												    #
#		Bristol Britannia for Flightgear						                #
#							                                                    #
#																				#
#		This program is free software: you can redistribute it and/or modify	#
#		it under the terms of the GNU General Public License as published by	#
#		the Free Software Foundation, either version 3 of the License, or		#
#		(at your option) any later version.										#
#																				#
#		This program is distributed in the hope that it will be useful,			#
#		but WITHOUT ANY WARRANTY; without even the implied warranty of			#
#		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the			#
#		GNU General Public License for more details.							#
#																				#
#		You should have received a copy of the GNU General Public License		#
#		along with this program.  If not, see <http://www.gnu.org/licenses/>.	#
#																				#
#		Every software has a developer, also free software. 					#
#		As a gesture of courtesy and respect, I would be delighted 				#		
#		if you contacted me before making any changes to this software. 		#
#									#
#################################################################################

var run1 = props.globals.getNode("engines/engine[0]/running");
var run2 = props.globals.getNode("engines/engine[1]/running");
var run3 = props.globals.getNode("engines/engine[2]/running");
var run4 = props.globals.getNode("engines/engine[3]/running");
var auto_procedure = props.globals.initNode("Britannia/autoprocedure",0,"BOOL");
var step = 0;

##################################################################################
var Reset = func{
	print ("Britannia Reset");
    var airspeed = getprop("/sim/presets/airspeed-kt");
    var altitude = getprop("/sim/presets/altitude-ft");
	setprop("controls/gear/nose-wheel-steering", 1);
	var engines_running = getprop("/sim/presets/engines_running");
	var park_brake = getprop("/sim/presets/park_brake");
	var gear_down = getprop("/sim/presets/gear_down");
	var flaps = getprop("/sim/presets/flaps") or 0;
	
	if (engines_running) { 
		print ("set engines running");

		setprop("controls/electric/engine[0]/generator", "true");
		setprop("controls/electric/engine[1]/generator", "true");	
		setprop("controls/electric/engine[2]/generator", "true");
		setprop("controls/electric/engine[3]/generator", "true");
	   	setprop("engines/engine[0]/running","true");
	   	setprop("engines/engine[1]/running","true");
	   	setprop("engines/engine[2]/running","true");
	   	setprop("engines/engine[3]/running","true");
		 
		setprop("controls/engines/engine[0]/cutoff", "false");
		setprop("controls/engines/engine[1]/cutoff", "false");
		setprop("controls/engines/engine[2]/cutoff", "false");
		setprop("controls/engines/engine[3]/cutoff", "false");
		setprop("controls/engines/engine[0]/started","false");
		setprop("controls/engines/engine[1]/started","false");
		setprop("controls/engines/engine[2]/started","false");
		setprop("controls/engines/engine[3]/started","false");
		setprop("controls/engines/engine[0]/cutoff", "false");
		setprop("controls/engines/engine[1]/cutoff", "false");
		setprop("controls/engines/engine[2]/cutoff", "false");
		setprop("controls/engines/engine[3]/cutoff", "false");
# turbine engine start from https://forum.flightgear.org/viewtopic.php?f=49&t=25470	

		
	   	setprop("engines/engine[0]/starter","true");
	   	setprop("engines/engine[1]/starter","true");
	   	setprop("engines/engine[2]/starter","true");
	   	setprop("engines/engine[3]/starter","true");	
	}
		
	setprop("controls/gear/brake-parking", park_brake);      ## brakes
    setprop("/controls/gear/gear-down", gear_down);		
    setprop("fdm/jsbsim/gear/gear-cmd-norm", gear_down);	
    setprop("/controls/flight/flaps", flaps);		
    setprop("fdm/jsbsim/fcs/flaps", flaps);
    setprop("controls/flight/rudder-trim", 0);
    setprop("fdm/jsbsim/fcs/pitch-trim-pos-deg", 0);
    setprop("controls/flight/aileron-trim", 0);
	   
    setprop("instrumentation/weu/state/takeoff-mode",0);
    if(var vbaro = getprop("environment/metar/pressure-inhg"))
        {
            setprop("instrumentation/altimeter/setting-inhg", vbaro);
            setprop("instrumentation/altimeter[1]/setting-inhg", vbaro);
            setprop("instrumentation/altimeter[2]/setting-inhg", vbaro);
        }
    # set ILS frequency
    var cur_runway = getprop("sim/presets/runway");
	var airport_id = getprop("sim/presets/airport-id") or nil;
	if (airport_id  != nil) {
    var runways = airportinfo(airportinfo(getprop("sim/presets/airport-id")).id).runways;
    var runway_keys = sort(keys(runways), string.icmp);
    var i = 0;
    foreach(var rwy; runway_keys)
        {
            var r = runways[rwy];
            if(cur_runway == rwy)
            {
                if (r.ils != nil)
                {
                    setprop("instrumentation/nav/frequencies/selected-mhz", (r.ils.frequency / 100));
                }
                break;
            }
            i += 1;
            if (i == 10)
                break;
        }
	}
} # end function
##################################################################################
var ResetFDM = func{
	print ("SIGNAL /sim/signals/fdm-initialized");
	##    Initall();
	} ## end func

var ResetReinit = func{
	print ("SIGNAL /sim/signals/reinit");
	Reset();	
##  fgcommand('reinit', props.Node.new({ subsystem: "xml-autopilot" }));
	} ## end func
 
##var Lreset = setlistener("/sim/signals/fdm-initialized",ResetFDM);
##var Linit = setlistener("sim/signals/reinit", ResetReinit);
