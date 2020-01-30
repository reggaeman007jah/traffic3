
// route start and end points
route1Start = getMarkerPos "route1Start";
route1Dest = getMarkerPos "route1Dest";

route2Start = getMarkerPos "route2Start";
route2Dest = getMarkerPos "route2Dest";

// states 
route1ClearSpawn = true;
route2ClearSpawn = true;


// script inits
execVM "route1Spawner.sqf";
execVM "route1Ender.sqf";
execVM "route2Spawner.sqf";
execVM "route2Ender.sqf";

// create vics 
vic1Start = getMarkerPos "vic1Start";
vic2Start = getMarkerPos "vic2Start";
vic3Start = getMarkerPos "vic3Start";
vic4Start = getMarkerPos "vic4Start";
vic5Start = getMarkerPos "vic5Start";
route1Start = getMarkerPos "route1Start";

VIC1 = createVehicle ["B_Truck_01_cargo_F", vic1Start, [], 0, "NONE"];
createVehicleCrew VIC1;
VIC2 = createVehicle ["B_Truck_01_cargo_F", vic2Start, [], 0, "NONE"];
createVehicleCrew VIC2;
VIC3 = createVehicle ["B_Truck_01_cargo_F", vic3Start, [], 0, "NONE"];
createVehicleCrew VIC3;
VIC4 = createVehicle ["B_Truck_01_cargo_F", vic4Start, [], 0, "NONE"];
createVehicleCrew VIC4;
VIC5 = createVehicle ["B_Truck_01_cargo_F", vic5Start, [], 0, "NONE"];
createVehicleCrew VIC5;
VIC6 = createVehicle ["B_Truck_01_cargo_F", vic6Start, [], 0, "NONE"];
createVehicleCrew VIC6;










execVM "vic1.sqf";
execVM "vic2.sqf";
execVM "vic1CD.sqf";

nearJCT = true;
checkJCT = false;
goAhead = false;

//stop at jct
while {true} do {

	_V1Pos = getPos VIC1;
	_V2Pos = getPos VIC2;
	_JCTPos = getMarkerPos "JCT1";
	_atJCT = _V2Pos distance _JCTPos;
	_avoid = _V1Pos distance _V2Pos;

	if (nearJCT) then {

	_V2Pos = getPos VIC2;
	_JCTPos = getMarkerPos "JCT1";
	_atJCT = _V2Pos distance _JCTPos;

		if (_atJCT <10) then {
			doStop VIC2;
			// systemChat "waiting at jct";
			sleep 2;
			nearJCT = false;
			checkJCT = true;		
		} else {
			// systemChat "not near jct";
		};
	};

	if (checkJCT) then {

	_V1Pos = getPos VIC1;
	_V2Pos = getPos VIC2;
	_avoid = _V1Pos distance _V2Pos;

		if (_avoid >60) then {
			checkJCT = false;
			goAhead = true;
			// systemChat "distance =";
			// systemChat str _avoid;
			// systemChat "safe to proceed";
		} else {
			// systemChat "not safe - WAIT";
		};
	};
 
	if (goAhead) then {
		goAhead = false;
		VIC2 doMove vic2Dest;
		// systemChat "move along";
		sleep 5;
		nearJCT = true;
		
	};

	sleep 0.3;
};

