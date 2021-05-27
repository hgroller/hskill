PowerCopyLib = hiCreateStringField(
   ?name      'PowerCopyLib
   ?prompt    "Lib Name"
   ?defValue  "Power Copy"
   ?editable  t
   )

PowerCopyCell = hiCreateStringField(
   ?name      'PowerCopyCell
   ?prompt    "Cell Name"
   ?defValue  "Power_Copy"
   ?editable  t
   )

PowerCopyView = hiCreateStringField(
   ?name      'PowerCopyView
   ?prompt    "View Name"
   ?defValue  "layout"
   ?editable  t
   )

PowerCopyForm = hiCreateAppForm(
   ?name          'PowerCopyForm 
   ?formTitle     "Copy Power"
   ?fields        list( PowerCopyLib PowerCopyCell PowerCopyView )      
   ?unmapAfterCB  t
   )





procedure(delpower()
;;;; Written: Tracy Groller, 12-17-2009
;;;;
;;;;procedure to Remove/Copy power from top level design only
;;;;this could be modified to plot power also

cv = geGetEditCellView()

netVEE = dbFindNetByName(cv "VEE")
netVCC = dbFindNetByName(cv "VCC")
netGND = dbFindNetByName(cv "GND")

figVEE = netVEE~>figs
figVCC = netVCC~>figs
figGND = netGND~>figs

;;;;Below Could be basis for power plots or extract net
;;;;Parse the terminals 
;;;;then dbConcatTransform or dbTransformPoint
;;;;to the top level

termVEE = netVEE~>instTerms
termVCC = netVCC~>instTerms
termGND = netGND~>instTerms


foreach(vee figVEE
        dbDeleteObject(vee)
        );endfor
foreach(vcc figVCC
        dbDeleteObject(vcc)
        );endfor    
foreach(gnd figGND
        dbDeleteObject(gnd)
        );endfor 

foreach( inst cv~>instances
       when( inst~>cellName =="via12"
              if(car(inst~>instTerms~>net~>name) == "VEE" then
	      dbDeleteObject(inst)
	         );endif
	      if(car(inst~>instTerms~>net~>name) == "VCC" then
	      dbDeleteObject(inst)
	         );endif
	      if(car(inst~>instTerms~>net~>name) == "GND" then
	      dbDeleteObject(inst)
	         );endif
	    );endwhen
       when( inst~>cellName =="via23"
              if(car(inst~>instTerms~>net~>name) == "VEE" then
	      dbDeleteObject(inst)
	         );endif
	      if(car(inst~>instTerms~>net~>name) == "VCC" then
	      dbDeleteObject(inst)
	         );endif
	      if(car(inst~>instTerms~>net~>name) == "GND" then
	      dbDeleteObject(inst)
	         );endif
	    );endwhen
	
       when( inst~>cellName == "subcont"
	   dbDeleteObject(inst) 
	   )
	
	);endfor

);end procedure





procedure(copypower()


cv = geGetEditCellView()
PowerCopyForm->PowerCopyLib->value = cv~>libName;
hiDisplayForm( PowerCopyForm );

lib =  PowerCopyForm->PowerCopyLib->value
cell = PowerCopyForm->PowerCopyCell->value
view = PowerCopyForm->PowerCopyView->value

cvdest = dbOpenCellViewByType(lib cell view)

netVEE = dbFindNetByName(cv "VEE")
netVCC = dbFindNetByName(cv "VCC")
netGND = dbFindNetByName(cv "GND")

figVEE = netVEE~>figs;
figVCC = netVCC~>figs;
figGND = netGND~>figs;

;;;;;;Copies and transforms a figure and places it in a cellview
;;;;;;from the top level cell only


foreach(vee figVEE
        dstFig = dbCopyFig(vee, cvdest);
	);endfor
foreach(vcc figVCC
        dstFig = dbCopyFig(vcc, cvdest);
        );endfor    
foreach(gnd figGND
        dstFig = dbCopyFig(gnd, cvdest);
        );endfor 


;;;;;;finds all vias connected to power and ground
;;;;;;at the top level and copies to new cell


foreach( inst cv~>instances
       
       
       when( inst~>cellName =="via12"
              if(car(inst~>instTerms~>net~>name) == "VEE" then
	         dbCopyFig(inst, cvdest)
	         );endif
	      if(car(inst~>instTerms~>net~>name) == "VCC" then
	         dbCopyFig(inst, cvdest)
	         );endif
	      if(car(inst~>instTerms~>net~>name) == "GND" then
	         dbCopyFig(inst, cvdest)
	         );endif
              );endwhen
       
       when( inst~>cellName =="via23"
              if(car(inst~>instTerms~>net~>name) == "VEE" then
	         dbCopyFig(inst, cvdest)
	         );endif
	      if(car(inst~>instTerms~>net~>name) == "VCC" then
	         dbCopyFig(inst, cvdest)
	         );endif
              if(car(inst~>instTerms~>net~>name) == "GND" then
	         dbCopyFig(inst, cvdest)
	         );endif
	      );endwhen
         
	when( inst~>cellName == "subcont"
               dbCopyFig(inst, cvdest)
	      );endwhen
	 
	 
	 );endfor

);endprocedure

