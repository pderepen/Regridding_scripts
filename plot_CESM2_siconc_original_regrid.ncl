;************************************************************************************
; Plot maps of sea ice concentration for CESM2 before and after regridding
;************************************************************************************

begin

;************************************************************************************
; Read in original data
;************************************************************************************

f_mod_og  = addfile("/Users/pade7652/Google Drive/CUBoulder/Projects/CESM2/Data/CESM2-CMIP6/siconc_SImon_CESM2_historical_r1i1p1f1_gn_185001-201412.nc","r")
siconc_og = f_mod_og->siconc ; [in %]
lat_og    = f_mod_og->lat ; read in 2D lat/lon
lon_og    = f_mod_og->lon
; printVarSummary(siconc_og)

;************************************************************************************
; Read in regridded data
;************************************************************************************

f_mod_rg  = addfile("/Users/pade7652/Google Drive/CUBoulder/Projects/Summer2021_Patricia/Data/CESM2_siconc_hist_r1i1p1f1_xesmf_rg_1x1.nc","r")
siconc_rg = f_mod_rg->siconc ; [in %]
lat_rg    = f_mod_rg->lat ; read in 2D lat/lon
lon_rg    = f_mod_rg->lon
; printVarSummary(siconc_rg)

;************************************************************************************
; Assign 2d lat/lon for plotting
;************************************************************************************

siconc_og@lon2d      = lon_og ; assign required attributes for plotting on original grid
siconc_og@lat2d      = lat_og
siconc_og@_FillValue = 1e+20

siconc_rg@lon2d      = lon_rg ; assign required attributes for plotting on original grid
siconc_rg@lat2d      = lat_rg
siconc_rg@_FillValue = 1e+20

;************************************************
; Create plots
;************************************************
type = "pdf"
type@wkOrientation = "portrait"

wks = gsn_open_wks(type,"Map_siconc_CESM2_original_regrid_diff")
gsn_define_colormap(wks,"WhiteBlue")
gsn_reverse_colormap(wks)

;*** Set-up for panel
plot  = new(4,graphic)

;*** Setup filled contour plot resources for NH
res1                          = True
res1@gsnPolar                 = "NH" ; choose NH hemisphere
res1@gsnPolarLabelFontHeightF = 0.02 ; changes size of lat/lon labels
res1@gsnPolarLabelDistance    = 1.08 ; determines how far lat/lon labels are from the map perimeter
res1@gsnAddCyclic             = True
res1@gsnMaximize              = True ; maximize plot size on page
res1@gsnDraw                  = False ; don't draw yet
res1@gsnFrame                 = False ; don't advance frame
res1@gsnLeftString            = " " ; no left string
res1@gsnRightString           = " " ; no right string
res1@gsnSpreadColors          = True ; use full colormap

res1@mpFillOn          = True ; turn on filled land
res1@mpLandFillColor   = "grey"
res1@mpOceanFillColor  = (/27./255,44./255,98./255/) ; Fill the missing values over the ocean with the first color of the colormap
res1@mpOutlineOn       = True ; turn on default continental outline
res1@mpMinLatF         = 50 
res1@mpGridLonSpacingF = 90. ; change longitude line spacing

res1@cnFillOn             = True ; color fill
res1@cnLinesOn            = False ; no contour lines
res1@cnLineLabelsOn       = False ; no line labels
res1@cnLevelSelectionMode = "ExplicitLevels" ; Explicit levels since not equally spaced
res1@cnLevels             = (/15,25,35,45,55,65,75,85,95/) 
; res1@cnMissingValPerimOn         = True ; draw border of missing value areas to create continents
; res1@cnMissingValPerimColor      = "black" ; make the missing value boarder black
; res1@cnMissingValPerimThicknessF = 1.0 ; sets the thickness of the missing value perimeter (factor of x)
; res1@cnMissingValFillColor       = "grey" ; fill color of missing value area
; res1@cnMissingValFillPattern     =  0 ; 0 fills missing value area with solid color, 1 makes it transparent
; res1@mpOutlineOn                 = False ; turn on default continental outline

res1@lbLabelBarOn = False ; turn off individual colorbar for each panel

res1@trGridType = "TriangularMesh"

;*** Setup filled contour plot resources for SH
res2                          = True
res2@gsnPolar                 = "SH" ; choose SH hemisphere
res2@gsnPolarLabelFontHeightF = 0.02 ; changes size of lat/lon labels
res2@gsnPolarLabelDistance    = 1.08 ; determines how far lat/lon labels are from the map perimeter
res2@gsnAddCyclic             = True
res2@gsnMaximize              = True ; maximize plot size on page
res2@gsnDraw                  = False ; don't draw yet
res2@gsnFrame                 = False ; don't advance frame
res2@gsnLeftString            = " " ; no left string
res2@gsnRightString           = " " ; no right string
res2@gsnSpreadColors          = True ; use full colormap

res2@mpFillOn          = True ; turn on filled land
res2@mpLandFillColor   = "grey"
res2@mpOceanFillColor  = (/27./255,44./255,98./255/) ; Fill the missing values over the ocean with the first color of the colormap
res2@mpOutlineOn       = True ; turn on default continental outline
res2@mpMaxLatF         = -50 
res2@mpGridLonSpacingF = 90. ; change longitude line spacing

res2@cnFillOn             = True ; color fill
res2@cnLinesOn            = False ; no contour lines
res2@cnLineLabelsOn       = False ; no line labels
res2@cnLevelSelectionMode = "ExplicitLevels" ; Explicit levels since not equally spaced
res2@cnLevels             = (/15,25,35,45,55,65,75,85,95/) 
; res2@cnMissingValPerimOn         = True ; draw border of missing value areas to create continents
; res2@cnMissingValPerimColor      = "black" ; make the missing value boarder black
; res2@cnMissingValPerimThicknessF = 1.0 ; sets the thickness of the missing value perimeter (factor of x)
; res2@cnMissingValFillColor       = "grey" ; fill color of missing value area
; res2@cnMissingValFillPattern     =  0 ; 0 fills missing value area with solid color, 1 makes it transparent
; res2@mpOutlineOn                 = False ; turn on default continental outline

res2@lbLabelBarOn = False ; turn off individual colorbar for each panel

res2@trGridType = "TriangularMesh"

;*** Plot contour maps for March 2000
plot(0) = gsn_csm_contour_map_polar(wks,siconc_og(2,:,:),res1)
plot(1) = gsn_csm_contour_map_polar(wks,siconc_rg(2,:,:),res1)
plot(2) = gsn_csm_contour_map_polar(wks,siconc_og(8,:,:),res2)
plot(3) = gsn_csm_contour_map_polar(wks,siconc_rg(8,:,:),res2)

;*** Setup panel plot resources
resP                            = True ; modify the panel plot
resP@gsnFrame                   = False ; don't advance panel plot
resP@gsnMaximize                = True ; maximize area plot takes up on page
resP@gsnPanelMainString         = "NH: March 1850 / SH: September 1850"
resP@gsnPanelLabelBar           = True ; adds common colorbar
resP@gsnPaperOrientation        = "portrait" ; portrait landscape plot
; resP@gsnPanelYWhiteSpacePercent = 5 ; add some white space between panels
resP@gsnPanelFigureStrings      = (/"NH: original","NH: regridded","SH: original","SH: regridded"/) ; adds labels to subplots
resP@gsnPanelFigureStringsBackgroundFillColor = "white" ; makes background of label box white
resP@gsnPanelFigureStringsFontHeightF = 0.015 ; text height of label
resP@amJust                     = "TopLeft" ; put label in top left corner
; resP@pmLabelBarWidthF           = 0.6 ; make labelbar wider
; resP@pmLabelBarHeightF          = 0.7 ; make labelbar higher
; resP@lbOrientation              = "Horizontal"
; resP@lbLabelPosition            = "Bottom"
resP@lbLabelFontHeightF         = 0.013 ; make labels smaller
resP@lbTitleString              = "September Ice Concentration [%]"
resP@lbTitlePosition            = "Bottom"
resP@lbTitleFontHeightF         = 0.015

;*** Draw panel plot
gsn_panel(wks,plot,(/2,2/),resP)

; ;*** Move to results folder
; system("mv Map_siconc_CESM2_original_regrid_diff.pdf ../Results/")

end
