// check is start area is clear..

While {true} do {

	// check if anythiung is in area 
	_chkSpawn = allUnits inAreaArray "route1Start";
	_chkSpawnCnt = count _potImpact;


	If (_chkSpawnCnt >=1) then {

		// something is there, wait and retry
		sleep 2;
	} else {

		// spawn a vehicle but check which ones are not spawned first 
		// i.e. you need to declare the full set of vics in advance 

		_cntGrp1 = count units groupAlpha1;
		_cntGrp2 = count units groupAlpha2;
		_cntGrp3 = count units groupAlpha3;
		_cntGrp4 = count units groupAlpha4;
		_cntGrp5 = count units groupAlpha5;
		_cntGrp6 = count units groupAlpha6;

		switch (true) do {
			case (_cntGrp1 == 0):  {deployedGroup = groupAlpha1};
			case (_cntGrp2 == 0):  {deployedGroup = groupAlpha2};
			case (_cntGrp3 == 0):  {deployedGroup = groupAlpha3};
			case (_cntGrp4 == 0):  {deployedGroup = groupAlpha4};
			case (_cntGrp5 == 0):  {deployedGroup = groupAlpha5};
			case (_cntGrp6 == 0):  {deployedGroup = groupAlpha6};
			default { hint "no more groups allowed" }; // need an exit with here?
		};


	};

};




	if (colDetect) then {
		_relpos = VIC1 getRelPos [20, 0];
		_azimuth = getDir VIC1;
		deleteMarker "_V1CD";
		_V1CD = createMarker ["_V1CD", _relpos];
		"_V1CD" setMarkerSize [4, 4];
		"_V1CD" setMarkerColor "ColorRed";
		"_V1CD" setMarkerShape "RECTANGLE";
		"_V1CD" setMarkerDir _azimuth;

		_potImpact = allUnits inAreaArray "_V1CD";
		_potImpactCnt = count _potImpact;
		
		if (_potImpactCnt >=1) then {
			// systemChat "IMPACT AHOY";
			doStop VIC1;
			(driver VIC1) forceWeaponFire [currentWeapon VIC1, currentWeapon VIC1];
			colDetect = false;
			waitSafe = true;
		};
	};