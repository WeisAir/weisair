------------------------
-- BOEING 737NG EICAS --
------------------------

-- GLOBAL VARIABLES --
local startervalveE1_old = 0
local startervalveE2_old = 0

-- ADD IMAGES --
-- BACKGROUND (BLACK)
img_add_fullscreen("EICASback.png")
-- NEEDLES
img_oilpneE1w = img_add("oilneedlew.png", 521, 166, 120, 120)
img_oilpneE1a = img_add("oilneedlea.png", 521, 166, 120, 120)
img_oilpneE1r = img_add("oilneedler.png", 521, 166, 120, 120)
img_oilpneE2w = img_add("oilneedlew.png", 706, 166, 120, 120)
img_oilpneE2a = img_add("oilneedlea.png", 706, 166, 120, 120)
img_oilpneE2r = img_add("oilneedler.png", 706, 166, 120, 120)

img_oiltneE1w = img_add("oiltneedlew.png", 521, 316, 120, 120)
img_oiltneE1a = img_add("oiltneedlea.png", 521, 316, 120, 120)
img_oiltneE1r = img_add("oiltneedler.png", 521, 316, 120, 120)
img_oiltneE2w = img_add("oiltneedlew.png", 707, 316, 120, 120)
img_oiltneE2a = img_add("oiltneedlea.png", 707, 316, 120, 120)
img_oiltneE2r = img_add("oiltneedler.png", 707, 316, 120, 120)

img_vibcakep1E1 = img_add("VIBcakep1.png", 520, 512, 120, 120)
img_vibcakep2E1 = img_add("VIBcakep2.png", 520, 512, 120, 120)
img_vibcakep1E2 = img_add("VIBcakep1.png", 707, 512, 120, 120)
img_vibcakep2E2 = img_add("VIBcakep2.png", 707, 512, 120, 120)

img_hydpnewE1 = img_add("hydneedlew.png", 518, 662, 126, 126)
img_hydpneaE1 = img_add("hydneedlea.png", 518, 662, 126, 126)
img_hydpnerE1 = img_add("hydneedler.png", 518, 662, 126, 126)
img_hydpnewE2 = img_add("hydneedlew.png", 712, 662, 126, 126)
img_hydpneaE2 = img_add("hydneedlea.png", 712, 662, 126, 126)
img_hydpnerE2 = img_add("hydneedler.png", 712, 662, 126, 126)

img_N1pbE1 = img_add("TPpiebig.png", 51, 77, 156, 156)
img_N1spE1 = img_add("TPpiesmall.png", 51, 77, 156, 156)
img_N1pbE2 = img_add("TPpiebig.png", 283, 77, 156, 156)
img_N1spE2 = img_add("TPpiesmall.png", 283, 77, 156, 156)
img_N1ind1 = img_add("indline.png", 51, 77, 156, 156)
img_N1ind2 = img_add("indline.png", 283, 77, 156, 156)

img_EGTpbE1 = img_add("TPpiebig.png", 51, 228, 156, 156)
img_EGTspE1 = img_add("TPpiesmall.png", 51, 228, 156, 156)
img_EGTpbE2 = img_add("TPpiebig.png", 283, 228, 156, 156)
img_EGTspE2 = img_add("TPpiesmall.png", 283, 228, 156, 156)
img_EGTind1 = img_add("indline.png", 51, 228, 156, 156)
img_EGTind2 = img_add("indline.png", 283, 228, 156, 156)

img_N2pbE1 = img_add("TPpiebig.png", 51, 377, 156, 156)
img_N2spE1 = img_add("TPpiesmall.png", 51, 377, 156, 156)
img_N2pbE2 = img_add("TPpiebig.png", 283, 377, 156, 156)
img_N2psE2 = img_add("TPpiesmall.png", 283, 377, 156, 156)
img_N2ind1 = img_add("indline.png", 51, 377, 156, 156)
img_N2ind2 = img_add("indline.png", 283, 377, 156, 156)

img_FFpbE1 = img_add("ffbigpie.png", 60, 548, 136, 136)
img_FFspE1 = img_add("ffsmallpie.png", 60, 548, 136, 136)
img_FFpbE2 = img_add("ffbigpie.png", 294, 548, 136, 136)
img_FFspE2 = img_add("ffsmallpie.png", 294, 548, 136, 136)
img_FFind1 = img_add("indline.png", 60, 548, 136, 136)
img_FFind2 = img_add("indline.png", 294, 548, 136, 136)

-- FOREGROUND
eicasfront = img_add_fullscreen("EICASfront.png")
-- VIBRATION CAKE LINES
img_vibcakeliE1 = img_add("vibcakeline.png", 520, 512, 120, 120)
img_vibcakeliE2 = img_add("vibcakeline.png", 707, 512, 120, 120)
-- WARNINGS
img_startvE1 = img_add("startvalveopen.png", 515, 34, 152, 40)
img_startvE2 = img_add("startvalveopen.png", 690, 34, 152, 40)
img_oilbypE1 = img_add("oilfiltby.png", 515, 77, 152, 40)
img_oilbypE2 = img_add("oilfiltby.png", 690, 77, 152, 40)
img_oilploE1 = img_add("lowoilpress.png", 515, 120, 152, 40)
img_oilploE2 = img_add("lowoilpress.png", 690, 120, 152, 40)

-- ADD TEXT --
-- TURBINE ENGINE TEXT
txt_N1E1 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 135,107,100,50)
txt_N1E2 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 367,107,100,50)
txt_EGTE1 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 100,259,100,50)
txt_EGTE2 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 332,259,100,50)
txt_N2E1 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 135,407,100,50)
txt_N2E2 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 367,407,100,50)
txt_FFE1 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 135,568,100,50)
txt_FFE2 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 367,568,100,50)
txt_FQT1 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: center;", 40,755,100,50)
txt_FQT2 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: center;", 150,755,100,50)
txt_FQT3 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: center;", 263,755,100,50)
txt_FQTO = txt_add(" ","size:45px; font:arimo_bold.ttf; color: white; halign: center;", 380,740,100,50)
-- TURBINE OIL TEXT
txt_OILQE1 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 513,456,100,50)
txt_OILQE2 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 698,456,100,50)
txt_HYDQE1 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 509,803,100,50)
txt_HYDQE2 = txt_add(" ","size:39px; font:arimo_bold.ttf; color: white; halign: right;", 694,803,100,50)
-- WARNINGS AND INFORMATION
txt_add("TAT","size:25px; font:arimo_bold.ttf; color: aqua; halign: right;", 297,33,100,50)
txt_TAT = txt_add(" ","size:35px; font:arimo_bold.ttf; color: white; halign: right;", 346,26,150,50)

-- SET DEFAULT VISIBILITY --
visible(img_startvE1, false)
visible(img_startvE2, false)
visible(img_oilbypE1, false)
visible(img_oilbypE2, false)

viewport_rect(img_vibcakep1E1,521,512,60,120)
viewport_rect(img_vibcakep2E1,581,512,60,120)
viewport_rect(img_vibcakep1E2,707,512,60,120)
viewport_rect(img_vibcakep2E2,767,512,60,120)

viewport_rect(img_N2pbE1, 51, 455, 156, 78)
viewport_rect(img_N2spE1, 51, 377, 156, 78)
viewport_rect(img_N2pbE2, 283, 455, 156, 78)
viewport_rect(img_N2psE2, 283, 377, 156, 78)

viewport_rect(img_N1pbE1, 51, 155, 156, 78)
viewport_rect(img_N1spE1, 51, 77, 156, 78)
viewport_rect(img_N1pbE2, 283, 155, 156, 78)
viewport_rect(img_N1spE2, 283, 77, 156, 78)

viewport_rect(img_EGTpbE1, 51, 306, 156, 78)
viewport_rect(img_EGTspE1, 51, 228, 156, 78)
viewport_rect(img_EGTpbE2, 283, 306, 156, 78)
viewport_rect(img_EGTspE2, 283, 228, 156, 78)

viewport_rect(img_FFpbE1, 60, 616, 136, 68)
viewport_rect(img_FFspE1, 60, 548, 136, 68)
viewport_rect(img_FFpbE2, 294, 616, 136, 68)
viewport_rect(img_FFspE2, 294, 548, 136, 68)

-- FUNCTIONS --
function new_turbine(N1, EGT, N2, FF, FQ)
    
    -- TURBINE N1
    txt_set(txt_N1E1, string.format("%.01f", N1[1]) )
    txt_set(txt_N1E2, string.format("%.01f", N1[2]) )
    
    -- ENGINE 1 N1 PIE
    N1indlineE1 = var_cap(N1[1], 0 , 105.2)
    rotate(img_N1ind1, 211 / 105.2 * N1indlineE1)    
    
    N1bpE1 = var_cap(N1[1], 0, 90)
    rotate(img_N1pbE1, (180 / 90 * N1bpE1) - 180)
    
    visible(img_N1spE1, N1[1] > 90)
    N1spE1 = var_cap(N1[1], 90, 105.2)
    rotate(img_N1spE1, (31 / 15.2 * (N1spE1 - 90)) - 31)
    
    -- ENGINE 2 N1 PIE
    N1indlineE2 = var_cap(N1[2], 0 , 105.2)
    rotate(img_N1ind2, 211 / 105.2 * N1indlineE2)    
    
    N1bpE2 = var_cap(N1[2], 0, 90)
    rotate(img_N1pbE2, (180 / 90 * N1bpE2) - 180)
    
    visible(img_N1spE2, N1[2] > 90)
    N1spE2 = var_cap(N1[2], 90, 105.2)
    rotate(img_N1spE2, (31 / 15.2 * (N1spE2 - 90)) - 31)
    
    -- EXHAUST GAS TEMPERATURE
    EGT1 = var_cap(EGT[1], 0, 999)
    EGT2 = var_cap(EGT[2], 0, 999)
    
    txt_set(txt_EGTE1, string.format("%.0f", EGT1) )
    txt_set(txt_EGTE2, string.format("%.0f", EGT2) )
    
    -- ENGINE 1 EGT PIE
    EGTindlineE1 = var_cap(EGT[1], 0 , 950)
    rotate(img_EGTind1, 211 / 950 * EGTindlineE1)    
    
    EGTbpE1 = var_cap(EGT[1], 0, 810)
    rotate(img_EGTpbE1, (180 / 810 * EGTbpE1) - 180)
    
    visible(img_EGTspE1, EGT[1] > 810)
    EGTspE1 = var_cap(EGT[1], 811, 950)
    rotate(img_EGTspE1, (31 / 139 * (EGTspE1 - 811)) - 31)
    
    -- ENGINE 2 EGT PIE
    EGTindlineE2 = var_cap(EGT[2], 0 , 950)
    rotate(img_EGTind2, 211 / 950 * EGTindlineE2)    
    
    EGTbpE2 = var_cap(EGT[2], 0, 810)
    rotate(img_EGTpbE2, (180 / 810 * EGTbpE2) - 180)
    
    visible(img_EGTspE2, EGT[2] > 810)
    EGTspE2 = var_cap(EGT[2], 811, 950)
    rotate(img_EGTspE2, (31 / 139 * (EGTspE2 - 811)) - 31)
    
    -- TURBINE N2
    N2E1 = var_cap(N2[1], 0, 100)
    N2E2 = var_cap(N2[2], 0, 100)
    
    txt_set(txt_N2E1, string.format("%.01f", N2E1) )
    txt_set(txt_N2E2, string.format("%.01f", N2E2) )
    
    -- ENGINE 1 N2 PIE
    N2indlineE1 = var_cap(N2[1], 0 , 100)
    rotate(img_N2ind1, 209 / 100 * N2indlineE1)
    
    N2bpE1 = var_cap(N2[1], 0, 86)
    rotate(img_N2pbE1, (180 / 86 * N2bpE1) - 180)
    
    visible(img_N2spE1, N2[1] > 86)
    N2spE1 = var_cap(N2[1], 86, 100)
    rotate(img_N2spE1, (29 / 14 * (N2spE1 - 86)) - 32)
    -- ENGINE 2 N2 PIE
    N2indlineE2 = var_cap(N2[2], 0 , 100)
    rotate(img_N2ind2, 209 / 100 * N2indlineE2)
    
    N2bpE2 = var_cap(N2[2], 0, 86)
    rotate(img_N2pbE2, (180 / 86 * N2bpE2) - 180)
    
    visible(img_N2psE2, N2[2] > 86)
    N2spE2 = var_cap(N2[2], 86, 100)
    rotate(img_N2psE2, (29 / 14 * (N2spE2 - 86)) - 32)
    
    -- FUEL FLOW IN POUNDS PER HOUR X 1000
    FFE1 = (FF[1] * 2.20462262 * 3600) / 1000
    FFE2 = (FF[2] * 2.20462262 * 3600) / 1000
    
    FFE1 = var_cap(FFE1, 0, 99.99)
    FFE2 = var_cap(FFE2, 0, 99.99)
    
    txt_set(txt_FFE1, string.format("%.02f", FFE1) )
    txt_set(txt_FFE2, string.format("%.02f", FFE2) )
    
    -- ENGINE 1 FF PIE
    FFindlineE1 = var_cap(FFE1, 0 , 12)
    rotate(img_FFind1, 234 / 12 * FFindlineE1)    
    
    FFbpE1 = var_cap(FFE1, 0, 9.23)
    rotate(img_FFpbE1, (180 / 9.23 * FFbpE1) - 180)
    
    visible(img_FFspE1, FFE1 > 9.23)
    FFspE1 = var_cap(FFE1, 9.24, 12)
    rotate(img_FFspE1, (54 / 2.77 * (FFspE1 - 9.23)) - 54)
    
    -- ENGINE 1 FF PIE
    FFindlineE2 = var_cap(FFE2, 0 , 12)
    rotate(img_FFind2, 234 / 12 * FFindlineE2)    
    
    FFbpE2 = var_cap(FFE2, 0, 9.23)
    rotate(img_FFpbE2, (180 / 9.23 * FFbpE2) - 180)
    
    visible(img_FFspE2, FFE2 > 9.23)
    FFspE2 = var_cap(FFE2, 9.24, 12)
    rotate(img_FFspE2, (54 / 2.77 * (FFspE2 - 9.23)) - 54)
    
    -- FUEL QUANTITY IN LBS X 1000
    FQT1 = (FQ[1] * 2.20462262) / 1000
    FQT2 = (FQ[2] * 2.20462262) / 1000
    FQT3 = (FQ[3] * 2.20462262) / 1000
    
    FQTO = FQT1 + FQT2 + FQT3
    
    FQT1 = var_cap(FQT1, 0, 9.99)
    FQT2 = var_cap(FQT2, 0, 99.99)
    FQT3 = var_cap(FQT3, 0, 9.99)
    
    txt_set(txt_FQT1, string.format("%.02f", FQT1) )
    txt_set(txt_FQT2, string.format("%.02f", FQT2) )
    txt_set(txt_FQT3, string.format("%.02f", FQT3) )
    txt_set(txt_FQTO, string.format("%.1f", FQTO) )
    
end

function new_oil(quantity, hydq1, hydq2, pressure, temperature, vibE1, vibE2, hydpE1, hydpE2)

    -- ENGINE OIL QUANTITY
    QE1 = quantity[1] * 100
    QE2 = quantity[2] * 100
    
    QE1 = var_cap(QE1, 0, 99)
    QE2 = var_cap(QE2, 0, 99)
    
    txt_set(txt_OILQE1, string.format("%.0f", QE1) )
    txt_set(txt_OILQE2, string.format("%.0f", QE2) )

    -- HYDRAULIC OIL QUANTITY
    HYDQE1 = hydq1 * 100
    HYDQE2 = hydq2 * 100
    
    HYDQE1 = var_cap(HYDQE1, 0, 99)
    HYDQE2 = var_cap(HYDQE2, 0, 99)
    
    txt_set(txt_HYDQE1, string.format("%.0f", HYDQE1) )
    txt_set(txt_HYDQE2, string.format("%.0f", HYDQE2) )
    
    -- ENGINE OIL PRESSURE
    pressureE1 = var_cap(pressure[1], 0, 100)
    pressureE2 = var_cap(pressure[2], 0, 100)
    
    visible(img_oilpneE1w, pressureE1 > 26)
    visible(img_oilpneE2w, pressureE2 > 26)
    visible(img_oilpneE1a, pressureE1 <= 26 and pressureE1 >13)
    visible(img_oilpneE2a, pressureE2 <= 26 and pressureE2 >13)
    visible(img_oilpneE1r, pressureE1 <=13)
    visible(img_oilpneE2r, pressureE2 <=13)
    
    rotate(img_oilpneE1w, 301 / 100 * pressureE1)
    rotate(img_oilpneE1a, 301 / 100 * pressureE1)
    rotate(img_oilpneE1r, 301 / 100 * pressureE1)
    rotate(img_oilpneE2w, 301 / 100 * pressureE2)
    rotate(img_oilpneE2a, 301 / 100 * pressureE2)
    rotate(img_oilpneE2r, 301 / 100 * pressureE2)
    
    -- ENGINE OIL TEMPERATURE
    temperatureE1 = var_cap(temperature[1], -50, 200)
    temperatureE2 = var_cap(temperature[2], -50, 200)
    
    visible(img_oiltneE1w, temperatureE1 < 143)
    visible(img_oiltneE2w, temperatureE2 < 143)
    visible(img_oiltneE1a, temperatureE1 >= 143 and temperatureE1 <159)
    visible(img_oiltneE2a, temperatureE2 >= 143 and temperatureE2 <159)
    visible(img_oiltneE1r, temperatureE1 >= 159)
    visible(img_oiltneE2r, temperatureE2 >= 159)

    rotate(img_oiltneE1w, (201 / 200 * temperatureE1))
    rotate(img_oiltneE1a, (201 / 200 * temperatureE1))
    rotate(img_oiltneE1r, (201 / 200 * temperatureE1))
    rotate(img_oiltneE2w, (201 / 200 * temperatureE2))
    rotate(img_oiltneE2a, (201 / 200 * temperatureE2))
    rotate(img_oiltneE2r, (201 / 200 * temperatureE2))
    
    -- ENGINE VIBRATION
    -- ENGINE 1
    
    vibE1 = vibE1 / 5
    vibE2 = vibE2 / 5
    
    vibcakep1E1rot = 146 / 0.56371 * vibE1 - 146
    vibcakep1E1rot = var_cap(vibcakep1E1rot, -146, 0)
    visible(img_vibcakep1E1, vibE1 > 0)
    rotate(img_vibcakep1E1, vibcakep1E1rot)
    
    vibcakep2E1rot = 112 / 0.43 * (vibE1 - 0.57)
    vibcakep2E1rot = var_cap(vibcakep2E1rot, 0, 120)
    visible(img_vibcakep2E1, vibcakep2E1rot > 0)
    rotate(img_vibcakep2E1, vibcakep2E1rot - 112)
    rotate(img_vibcakeliE1, 256 * vibE1)
    -- ENGINE 2
    vibcakep1E2rot = 146 / 0.57 * vibE2 - 146
    vibcakep1E2rot = var_cap(vibcakep1E2rot, -146, 0)
    visible(img_vibcakep1E2, vibE2 > 0)
    rotate(img_vibcakep1E2, vibcakep1E2rot)
    
    vibcakep2E2rot = 112 / 0.43 * (vibE2 - 0.57)
    vibcakep2E2rot = var_cap(vibcakep2E2rot, 0, 112)
    visible(img_vibcakep2E2, vibcakep2E2rot > 0)
    rotate(img_vibcakep2E2, vibcakep2E2rot - 112)
    rotate(img_vibcakeliE2, 256 * vibE2)
    
    -- HYDRAULIC PRESSURE
    -- ENGINE 1
    visible(img_hydpnewE1, hydpE1 > 2410 and hydpE1 < 3200)
    visible(img_hydpneaE1, hydpE1 > 2000 and hydpE1 < 2411 or hydpE1 >= 3200 and hydpE1 < 3480)
    visible(img_hydpnerE1, hydpE1 <= 2000 or hydpE1 >= 3480)
    
    if hydpE1 <= 2000 then
        rotate(img_hydpnewE1, 81 / 2000 * hydpE1)
        rotate(img_hydpneaE1, 81 / 2000 * hydpE1)
        rotate(img_hydpnerE1, 81 / 2000 * hydpE1)
    elseif hydpE1 > 2000 and hydpE1 <= 3000 then
        rotate(img_hydpnewE1, (100 / 1000 * (hydpE1 - 2000)) + 81)
        rotate(img_hydpneaE1, (100 / 1000 * (hydpE1 - 2000)) + 81)
        rotate(img_hydpnerE1, (100 / 1000 * (hydpE1 - 2000)) + 81)
    elseif hydpE1 > 3000 then
        rotate(img_hydpnewE1, (84 / 1000 * (hydpE1 - 3000)) + 181)
        rotate(img_hydpneaE1, (84 / 1000 * (hydpE1 - 3000)) + 181)
        rotate(img_hydpnerE1, (84 / 1000 * (hydpE1 - 3000)) + 181)
    end
    -- ENGINE 2
    hydpE2 = hydpE1 -- LOOKING FOR BETTER OR CORRECT DATAREF
    visible(img_hydpnewE2, hydpE2 > 2410 and hydpE2 < 3200)
    visible(img_hydpneaE2, hydpE2 > 2000 and hydpE2 < 2411 or hydpE2 >= 3200 and hydpE2 < 3480)
    visible(img_hydpnerE2, hydpE2 <= 2000 or hydpE2 >= 3480)

    if hydpE2 <= 2000 then
        rotate(img_hydpnewE2, 81 / 2000 * hydpE2)
        rotate(img_hydpneaE2, 81 / 2000 * hydpE2)
        rotate(img_hydpnerE2, 81 / 2000 * hydpE2)
    elseif hydpE2 > 2000 and hydpE2 <= 3000 then
        rotate(img_hydpnewE2, (100 / 1000 * (hydpE2 - 2000)) + 81)
        rotate(img_hydpneaE2, (100 / 1000 * (hydpE2 - 2000)) + 81)
        rotate(img_hydpnerE2, (100 / 1000 * (hydpE2 - 2000)) + 81)
    elseif hydpE2 > 3000 then
        rotate(img_hydpnewE2, (84 / 1000 * (hydpE2 - 3000)) + 181)
        rotate(img_hydpneaE2, (84 / 1000 * (hydpE2 - 3000)) + 181)
        rotate(img_hydpnerE2, (84 / 1000 * (hydpE2 - 3000)) + 181)
    end
end

function new_information(TAT, pressure)

    -- TOTAL AIR TEMPERATURE
    if TAT > 0 then
        txt_set(txt_TAT, string.format("+%.0f C", TAT))
    else
        txt_set(txt_TAT, string.format("%.0f C", TAT))
    end
    
    -- OIL PRESSURE LOW
    visible(img_oilploE1, pressure[1] <= 13)
    visible(img_oilploE2, pressure[2] <= 13)

end

function new_startervalve(starter)

    -- STARTER VALVE OPEN USES IGNITION
    -- VALUE STABLE AT 3 FOR 1 SECONDS MEANS STARTERVALVE CLOSED
    
end

-- DATA CONVERSION FSX / P3D --
function new_turbine_FSX(N11, N12, EGT1, EGT2, N21, N22, FF1, FF2, FQC, FQL, FQR, FWG)

    FQC = FQC * FWG
    FQL = FQL * FWG
    FQR = FQR * FWG
    
    new_turbine({N11, N12}, {EGT1, EGT2}, {N21, N22}, {FF1, FF2}, {FQL, FQC, FQR})

end

function new_oil_FSX(oilq1, oilq2, hydq1, hydq2, oilp1, oilp2, oilt1, oilt2, vibE1, vibE2, hydpE1, hydpE2)
    
    new_oil({oilq1, oilq2}, hydq1, hydq2, {oilp1, oilp2}, {oilt1, oilt2}, vibE1, vibE2, hydpE1, hydpE2)
    
end

function new_information_FSX(TAT, pressure1, pressure2)

    new_information(TAT, {pressure1, pressure2})
    
end

background = img_add_fullscreen("display_frame.png")

-- BUS SUBSCRIBE X-PLANE --
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/N1_percent", "FLOAT[8]",
                      "sim/flightmodel/engine/ENGN_EGT_c", "FLOAT[8]",
                      "sim/cockpit2/engine/indicators/N2_percent", "FLOAT[8]",
                      "sim/flightmodel/engine/ENGN_FF_", "FLOAT[8]",
                      "sim/flightmodel/weight/m_fuel", "FLOAT[9]", new_turbine)
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/oil_quantity_ratio", "FLOAT[8]",
                      "sim/cockpit2/hydraulics/indicators/hydraulic_fluid_ratio_1", "FLOAT", 
                      "sim/cockpit2/hydraulics/indicators/hydraulic_fluid_ratio_2", "FLOAT",
                      "sim/flightmodel/engine/ENGN_oil_press_psi", "FLOAT[8]",
                      "sim/flightmodel/engine/ENGN_oil_temp_c", "FLOAT[8]",
                      "x737/engine/viblevel_1", "FLOAT", 
                      "x737/engine/viblevel_2", "FLOAT",
                      "sim/cockpit2/hydraulics/indicators/hydraulic_pressure_1", "FLOAT",
                      "sim/cockpit2/hydraulics/indicators/hydraulic_pressure_2", "FLOAT", new_oil)
xpl_dataref_subscribe("sim/weather/temperature_le_c", "FLOAT",
                      "sim/flightmodel/engine/ENGN_oil_press_psi", "FLOAT[8]", new_information)
xpl_dataref_subscribe("sim/cockpit2/engine/actuators/ignition_key", "INT[8]", new_startervalve)
-- BUS SUBSCRIBE FSX / P3D --
fsx_variable_subscribe("TURB ENG N1:1", "Percent",
                       "TURB ENG N1:2", "Percent",
                       "ENG EXHAUST GAS TEMPERATURE:1", "Celsius",
                       "ENG EXHAUST GAS TEMPERATURE:2", "Celsius",
                       "TURB ENG N2:1", "Percent",
                       "TURB ENG N2:2", "Percent",
                       "TURB ENG FUEL FLOW PPH:1", "kilogram per second",
                       "TURB ENG FUEL FLOW PPH:2", "kilogram per second",
                       "FUEL TANK CENTER QUANTITY", "Gallons",
                       "FUEL LEFT QUANTITY", "Gallons",
                       "FUEL RIGHT QUANTITY", "Gallons",
                       "FUEL WEIGHT PER GALLON", "kilogram", new_turbine_FSX)
fsx_variable_subscribe("ENG OIL QUANTITY:1", "percent over 100",
                       "ENG OIL QUANTITY:2", "percent over 100", 
                       "ENG HYDRAULIC QUANTITY:1", "percent over 100", 
                       "ENG HYDRAULIC QUANTITY:2", "percent over 100",
                       "ENG OIL PRESSURE:1", "PSI", 
                       "ENG OIL PRESSURE:2", "PSI", 
                       "ENG OIL TEMPERATURE:1", "Celsius", 
                       "ENG OIL TEMPERATURE:2", "Celsius",
                       "ENG VIBRATION:1", "Number",
                       "ENG VIBRATION:2", "Number",
                       "ENG HYDRAULIC PRESSURE:1", "PSI", 
                       "ENG HYDRAULIC PRESSURE:1", "PSI", new_oil_FSX)
fsx_variable_subscribe("TOTAL AIR TEMPERATURE", "Celsius",
                       "ENG OIL PRESSURE:1", "PSI",
                       "ENG OIL PRESSURE:2", "PSI", new_information_FSX)
-- BUS SUBSCRIBE FS2020 --
fs2020_variable_subscribe("TURB ENG N1:1", "Percent",
                          "TURB ENG N1:2", "Percent",
                          "ENG EXHAUST GAS TEMPERATURE:1", "Celsius",
                          "ENG EXHAUST GAS TEMPERATURE:2", "Celsius",
                          "TURB ENG N2:1", "Percent",
                          "TURB ENG N2:2", "Percent",
                          "TURB ENG FUEL FLOW PPH:1", "kilogram per second",
                          "TURB ENG FUEL FLOW PPH:2", "kilogram per second",
                          "FUEL TANK CENTER QUANTITY", "Gallons",
                          "FUEL LEFT QUANTITY", "Gallons",
                          "FUEL RIGHT QUANTITY", "Gallons",
                          "FUEL WEIGHT PER GALLON", "kilogram", new_turbine_FSX)
fs2020_variable_subscribe("ENG OIL QUANTITY:1", "percent over 100",
                          "ENG OIL QUANTITY:2", "percent over 100", 
                          "ENG HYDRAULIC QUANTITY:1", "percent over 100", 
                          "ENG HYDRAULIC QUANTITY:2", "percent over 100",
                          "ENG OIL PRESSURE:1", "PSI", 
                          "ENG OIL PRESSURE:2", "PSI", 
                          "ENG OIL TEMPERATURE:1", "Celsius", 
                          "ENG OIL TEMPERATURE:2", "Celsius",
                          "ENG VIBRATION:1", "Number",
                          "ENG VIBRATION:2", "Number",
                          "ENG HYDRAULIC PRESSURE:1", "PSI", 
                          "ENG HYDRAULIC PRESSURE:1", "PSI", new_oil_FSX)
fs2020_variable_subscribe("TOTAL AIR TEMPERATURE", "Celsius",
                          "ENG OIL PRESSURE:1", "PSI",
                          "ENG OIL PRESSURE:2", "PSI", new_information_FSX)