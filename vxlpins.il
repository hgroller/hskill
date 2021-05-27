;;;Procedure to Align VXL placed pins with instances.



procedure(VxlAlignPins()
let((cv pins bBox pin myForm pinLoc)
cv=geGetEditRep()
unless(pins=geGetSelSet() error("\n pins are not selected"))
pinLoc=hiCreateRadioField(
      ?name 'pinLoc
      ?choices list("Top" "Bottom" "Left" "Right")
      ?prompt "Pins Location:"
      ?defValue "Top"
)

myForm= hiCreateAppForm(
   ?name 'myForm
   ?fields list(pinLoc)
   ?formTitle "Select the pin location.."
   ?buttonLayout 'OKCancelApply
   ?initialSize t
   )
  
hiDisplayForm(myForm)
 
 
 ;;enterBox(
         ;;?prompts        list(
                                ;;"Enter the first point:"
                                ;;"Enter the next point:"
                                ;;)
	 ;;?doneProc      "CCSSelectBlock"
        ;;)
    enterPoint(
    ?prompts list("Click on the block with which pins needs to be aligned..")
     ?doneProc "CCSSelectBlock"
    )

  foreach(x car(geGetSelSet())~>instTerms
   
     bBox=dbTransformBBox(car(x~>term~>pins)~>fig~>bBox  car(geGetSelSet())~>transform)
     if(member(x~>net~>term~>name pins~>pin~>name) then
     pin=car(setof(y pins y~>pin~>name==x~>net~>term~>name))
   
     if(member(myForm->pinLoc->value list("Top" "Bottom")) then
     dbMoveFig(pin cv list((xCoord(upperRight(bBox))-rightEdge(pin)):0 "R0" 1))
     else
     if(member(myForm->pinLoc->value list("Left" "Right")) then
     dbMoveFig(pin cv list(0:(yCoord(upperRight(bBox))-topEdge(pin)) "R0" 1))
     ))
   
     ) ;if member
    ) ;if foreach
 
  );let
  );proc
 
  procedure(CCSSelectBlock(w done pts)
   when(done
    geDeselectAll()
   geSelectPoint(w car(pts))
)
   )
