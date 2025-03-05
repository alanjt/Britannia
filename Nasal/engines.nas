var start1 = props.globals.getNode("/controls/engines/start1", 1);
var abort1 = props.globals.getNode("/controls/engines/abort1", 1);
var start2 = props.globals.getNode("/controls/engines/start2", 1);
var abort2 = props.globals.getNode("/controls/engines/abort2", 1);
var start3 = props.globals.getNode("/controls/engines/start3", 1);
var abort3 = props.globals.getNode("/controls/engines/abort3", 1);
var start4 = props.globals.getNode("/controls/engines/start4", 1);
var abort4 = props.globals.getNode("/controls/engines/abort4", 1);

var runall = props.globals.getNode("/controls/engines/runall", 1);
var startall = props.globals.getNode("/controls/engines/startall", 1);
var abortall = props.globals.getNode("/controls/engines/abortall", 1);
var spool_time = getprop("/sim/engines/spool-time");

####################################################################################
# engine 1

var set_engine1_state = func() {
print("starting engine1");
    cutoff1 = getprop("/controls/engines/engine[0]/cutoff");
    fuel_cutoff1 = getprop("/controls/fuel-cutoff1");

    if (start1 and cutoff1 and !fuel_cutoff1)
		{
		print ("start1");
		setprop("/controls/engines/engine[0]/constant-speed-mode", 0);
        setprop("/controls/engines/engine[0]/starter", 1);
        interpolate("/fdm/jsbsim/propulsion/engine[0]/n1", 20,spool_time);
        settimer(func{
			setprop("/controls/engines/engine[0]/cutoff", 0);
			setprop("/controls/engines/engine[0]/constant-speed-mode", 0);
		},spool_time);
		}
	}

####################################################################################
# engine 2

var set_engine2_state = func() {
	print("starting engine2");
    cutoff2 = getprop("/controls/engines/engine[1]/cutoff");
    fuel_cutoff2 = getprop("/controls/fuel-cutoff2");

    if (start2 and cutoff2 and !fuel_cutoff2)
		{
		print ("start2");
		setprop("/controls/engines/engine[1]/constant-speed-mode", 0);
        setprop("/controls/engines/engine[1]/starter", 1);
        interpolate("/fdm/jsbsim/propulsion/engine[1]/n1", 20, spool_time);
        settimer(func{
			setprop("/controls/engines/engine[1]/cutoff", 0);
			setprop("/controls/engines/engine[1]/constant-speed-mode", 0);
		},spool_time);
		}
	}
####################################################################################
# engine 3

var set_engine3_state = func() {
print("starting engine3");
    cutoff3 = getprop("/controls/engines/engine[2]/cutoff");
    fuel_cutoff3 = getprop("/controls/fuel-cutoff3");

    if (start3 and cutoff3 and !fuel_cutoff3)
		{
print ("start3");
        setprop("/controls/engines/engine[2]/starter", 1);
		setprop("/controls/engines/engine[2]/constant-speed-mode", 0);
        interpolate("/fdm/jsbsim/propulsion/engine[2]/n1", 20, spool_time);
        settimer(func{
			setprop("/controls/engines/engine[2]/cutoff", 0);
			setprop("/controls/engines/engine[2]/constant-speed-mode", 0);
		},spool_time);
		}
	}

####################################################################################
# engine 4

var set_engine4_state = func() {
	print("starting engine4");
    cutoff4 = getprop("/controls/engines/engine[3]/cutoff");
    fuel_cutoff4 = getprop("/controls/fuel-cutoff4");

    if (start4 and cutoff4 and !fuel_cutoff4)
		{
		print ("start4");
        setprop("/controls/engines/engine[3]/starter", 1);
		setprop("/controls/engines/engine[3]/constant-speed-mode", 0);
        interpolate("/fdm/jsbsim/propulsion/engine[3]/n1", 20, spool_time);
        settimer(func{
			setprop("/controls/engines/engine[3]/cutoff", 0);
			setprop("/controls/engines/engine[3]/constant-speed-mode", 0);
		},spool_time);
		}
	}

####################################################################################

setlistener(start1, set_engine1_state);
setlistener(start2, set_engine2_state);
setlistener(start3, set_engine3_state);
setlistener(start4, set_engine4_state);

# start all engines
var start_all_engines = func() {
	print("start all engines");

	var start1stengine = 10.0;
	var start2ndengine = start1stengine + spool_time;
	var start3rdengine = start2ndengine + spool_time;
	var start4thengine = start3rdengine + spool_time;

    settimer(func {
        setprop("/controls/engines/run3",!getprop("/controls/engines/run3"));
        setprop("/controls/engines/start3",!getprop("/controls/engines/start3"));
        setprop("/controls/engines/abort3",!getprop("/controls/engines/abort3"));
    }, start1stengine);
	
	    settimer(func {
        setprop("/controls/engines/run4",!getprop("/controls/engines/run4"));
        setprop("/controls/engines/start4",!getprop("/controls/engines/start4"));
        setprop("/controls/engines/abort4",!getprop("/controls/engines/abort4"));
    }, start2ndengine);

	settimer(func {
        setprop("/controls/engines/run2",!getprop("/controls/engines/run2"));
        setprop("/controls/engines/start2",!getprop("/controls/engines/start2"));
        setprop("/controls/engines/abort2",!getprop("/controls/engines/abort2"));
    }, start3rdengine);
	
	settimer(func {
        setprop("/controls/engines/run1",!getprop("/controls/engines/run1"));
        setprop("/controls/engines/start1",!getprop("/controls/engines/start1"));
        setprop("/controls/engines/abort1",!getprop("/controls/engines/abort1"));
    }, start4thengine);
	
    setprop("/controls/engines/startall",1);
	}
	
# start engines in sequence
setlistener(startall,start_all_engines);