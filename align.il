procedure(CCSAlignPins()
let((cv pins bBox pin myForm pinLoc)
cv=geGetEditRep()
unless(pins=geGetSelSet() error("\n pins are not selected"))
geDeselectAll()
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
 

geSelectArea()

pInst = geGetSelectedSet()

geDeselectAll()


  foreach(x pInst~>instTerms
   
     bBox=dbTransformBBox(car(x~>term~>pins)~>fig~>bBox  x~>transform)
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
