if AIRCRAFT_FILENAME == "Cessna_172SP.acf" 	then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_c172.config")
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/c172_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "Cessna_172SP_G1000.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_c172.config") 
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/c172_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "C172_NG_DIGITAL.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_afl_c172_g1000.config") 
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/c172_g1000_afl_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "Airfoillabs_C172SP_high_res.acf" then
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_afl_c172_sp.config") 
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "b738.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_b738.config") 
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/b738_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end	

if AIRCRAFT_FILENAME == "SSG_B748-F_12.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_b748.config")
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/b748_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "SSG_B748-I_12.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_b748.config") 
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/b748_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "LES_Saab_340A.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_saab340a_16.config") 
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/s340a_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "B733.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_B733.config")
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/b733_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "A330.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_A330.config") 
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "Cessna_CitationX.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_citX.config")
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/laminar_citationX_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end
	
if AIRCRAFT_FILENAME == "DC3_Classic.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_dc3.config")
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/dc3_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "DC3_Modern.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_dc3.config")
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/dc3_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "E170.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_e170.config")
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/e170_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

if AIRCRAFT_FILENAME == "N844X.acf" then 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_lancairevo.config")
	dofile(SCRIPT_DIRECTORY .. "weisair_scripts/laminar_lancairevo_customs.lua")
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)

else 
	dofile(SCRIPT_DIRECTORY .. "arcaze_scripts/myarcaze_generic.config") 
	print("WeisAir Panel Scripts loaded for Aircraft",  AIRCRAFT_FILENAME)
end

-- always include generic functions scripts
dofile(SCRIPT_DIRECTORY .. "weisair_scripts/generic_functions_xcam.lua")