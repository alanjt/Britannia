var start1 = props.globals.getNode("/controls/engines/start1", 1);
var abort1 = props.globals.getNode("/controls/engines/abort1", 1);
var start2 = props.globals.getNode("/controls/engines/start2", 1);
var abort2 = props.globals.getNode("/controls/engines/abort2", 1);
var start3 = props.globals.getNode("/controls/engines/start3", 1);
var abort3 = props.globals.getNode("/controls/engines/abort3", 1);
var start4 = props.globals.getNode("/controls/engines/start4", 1);
var abort4 = props.globals.getNode("/controls/engines/abort4", 1);
var spool_time = getprop("/sim/engines/spool-time");

####################################################################################
# engine 2
var switchback2 = func() {
    setprop("/controls/engines/run2",1);
    setprop("/controls/engines/start2",0);
    setprop("/controls/engines/abort2",0);
}

var set_engine2_state = func() {
    start2 = getprop("/controls/engines/start2");
    abort2 = getprop("/controls/engines/abort2");
    cutoff2 = getprop("/controls/engines/engine[1]/cutoff");
    fuel_cutoff2 = getprop("/controls/fuel-cutoff2");

    if (start2 and cutoff2 and !fuel_cutoff2)
    {
        # turboprops
        setprop("/controls/engines/engine[1]/starter", 1);
        interpolate("/fdm/jsbsim/propulsion/engine[1]/n1", 20, spool_time);
        settimer(func {
            setprop("/controls/engines/engine[1]/cutoff", 0);
         }, spool_time);

        settimer(switchback2, 1);
    }
    if (abort1)
    {
        setprop("/controls/engines/engine[1]/cutoff", 1);
        settimer(switchback2, 1);
    }
}

var set_pitch_fadec2 = maketimer(0.333333333, func {
    ## management of the feathering of the propellers
    ## for the moment, if the engine is stopped, we feather the propeller,
    ## otherwise, we put full throttle
    if (getprop("/engines/engine[1]/fuel-flow_pph") == 0) {
        interpolate("/controls/engines/engine[1]/propeller-pitch-fadec", 0, 1);
    } elsif (getprop("/controls/engines/engine[1]/propeller-feather") == 1) {
        ##for testing
        interpolate("/controls/engines/engine[1]/propeller-pitch-fadec", 0, 1);
    } else {
        var propeller_pitch = 1; #full power
        ##icing
#        propeller_pitch = propeller_pitch - getprop("/sim/icing/propellers");
        interpolate("/controls/engines/engine[1]/propeller-pitch-fadec", propeller_pitch, 1);
    }
});
set_pitch_fadec2.start();

setlistener(start2, set_engine2_state);
setlistener(abort2, set_engine2_state);

####################################################################################
# engine 1
var switchback1 = func() {
    setprop("/controls/engines/run1",1);
    setprop("/controls/engines/start1",0);
    setprop("/controls/engines/abort1",0);
    settimer(func {
        setprop("/controls/engines/run2",!getprop("/controls/engines/run2"));
        setprop("/controls/engines/start2",!getprop("/controls/engines/start2"));
        setprop("/controls/engines/abort2",!getprop("/controls/engines/abort2"));
    }, spool_time);
}

var set_engine1_state = func() {
    start1 = getprop("/controls/engines/start1");
    abort1 = getprop("/controls/engines/abort1");
    cutoff1 = getprop("/controls/engines/engine[0]/cutoff");
    fuel_cutoff1 = getprop("/controls/fuel-cutoff1");

    if (start1 and cutoff1 and !fuel_cutoff1)
    {
        # turboprops
        setprop("/controls/engines/engine[0]/starter", 1);
        interpolate("/fdm/jsbsim/propulsion/engine[0]/n1", 20, spool_time);
        settimer(func {
            setprop("/controls/engines/engine[0]/cutoff", 0);
        }, spool_time);

        settimer(switchback1, 1);
    }
    if (abort1)
    {
        setprop("/controls/engines/engine[0]/cutoff", 1);
        settimer(switchback1, 1);
    }
}

var set_pitch_fadec1 = maketimer(0.333333333, func {
    ## management of the feathering of the propellers
    ## for the moment, if the engine is stopped, we feather the propeller,
    ## otherwise, we put full throttle
    if (getprop("/engines/engine[0]/fuel-flow_pph") == 0) {
        interpolate("/controls/engines/engine[0]/propeller-pitch-fadec", 0, 1);
    } elsif (getprop("/controls/engines/engine[0]/propeller-feather") == 1) {
        ##for testing
        interpolate("/controls/engines/engine[0]/propeller-pitch-fadec", 0, 1);
    } else {
        var propeller_pitch = 1; #full power
        ##icing
#        propeller_pitch = propeller_pitch - getprop("/sim/icing/propellers");
        interpolate("/controls/engines/engine[0]/propeller-pitch-fadec", propeller_pitch, 1);
    }
});
set_pitch_fadec1.start();

setlistener(start1, set_engine1_state);
setlistener(abort1, set_engine1_state);

####################################################################################
# engine 3
var switchback3 = func() {
    setprop("/controls/engines/run3",1);
    setprop("/controls/engines/start3",0);
    setprop("/controls/engines/abort3",0);
    settimer(func {
        setprop("/controls/engines/run3",!getprop("/controls/engines/run3"));
        setprop("/controls/engines/start3",!getprop("/controls/engines/start3"));
        setprop("/controls/engines/abort3",!getprop("/controls/engines/abort3"));
    }, spool_time);
}

var set_engine3_state = func() {
    start3 = getprop("/controls/engines/start3");
    abort3 = getprop("/controls/engines/abort3");
    cutoff3 = getprop("/controls/engines/engine[2]/cutoff");
    fuel_cutoff3 = getprop("/controls/fuel-cutoff3");

    if (start3 and cutoff3 and !fuel_cutoff3)
    {
        # turboprops
        setprop("/controls/engines/engine[2]/starter", 1);
        interpolate("/fdm/jsbsim/propulsion/engine[2]/n1", 20, spool_time);
        settimer(func {
            setprop("/controls/engines/engine[2]/cutoff", 0);
        }, spool_time);

        settimer(switchback3, 1);
    }
    if (abort3)
    {
        setprop("/controls/engines/engine[2]/cutoff", 1);
        settimer(switchback3, 1);
    }
}

var set_pitch_fadec3 = maketimer(0.333333333, func {
    ## management of the feathering of the propellers
    ## for the moment, if the engine is stopped, we feather the propeller,
    ## otherwise, we put full throttle
    if (getprop("/engines/engine[2]/fuel-flow_pph") == 0) {
        interpolate("/controls/engines/engine[2]/propeller-pitch-fadec", 0, 1);
    } elsif (getprop("/controls/engines/engine[2]/propeller-feather") == 1) {
        ##for testing
        interpolate("/controls/engines/engine[2]/propeller-pitch-fadec", 0, 1);
    } else {
        var propeller_pitch = 1; #full power
        ##icing
#        propeller_pitch = propeller_pitch - getprop("/sim/icing/propellers");
        interpolate("/controls/engines/engine[2]/propeller-pitch-fadec", propeller_pitch, 1);
    }
});
set_pitch_fadec3.start();

setlistener(start3, set_engine1_state);
setlistener(abort3, set_engine1_state);