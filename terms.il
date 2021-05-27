procedure(CCSlxGetConnRef(cv)

prog((CellProp mylist)

if(dbFindProp(cv "lxInternal") then

  CellProp=dbFindProp(cv "lxInternal")    

   foreach( CellProp1 CellProp~>value

         when(CellProp1~>name == "source"

         mylist=reverse(setof(x  CellProp1~>value (x~>name=="lib" || x~>name=="cell" || x~>name=="view")) )

         printf("Library = %L, Cellname = %L, Viewname = %L" nth(0 mylist~>value) nth(1 mylist~>value) nth(2 mylist~>value))

         return(t)

         );when

        );foreach

    else

   return(nil)

   );if

  );prog

);procedure

;;--------------Upto here---------------------

 

Steps to be followed:

====================

1)Load the above code via CIW or .cdsinit file.

  load "CCSlxGetConnRef.il"

2)Open layout design in SKILL

  cvId = dbOpenCellViewByType("MyLib" "MyCell" "layout" "" "r")

3)In CIW:  Call the CCSlxGetConnRef as following.

  CCSlxGetConnRef(cvId)

 

This will return the connectivity reference information.


=====================CCSgettermname.il =============================
procedure(gettermname(netname instname)
  let((cv netid instid termid)
      cv = geGetEditCellView()


      ; get netid
      netid = dbFindNetByName(cv  netname)


     ;get instid
     foreach(inst netid~>allInstTerms~>inst
       if(inst~>name == instname
          instid = inst

         )
      );foreach

    ;get termid
    foreach(term instid~>instTerms
      if(car(term~>net~>sigNames) == netname
         termid=term

        )
     );foreach

  printf("Net %L is connected to terminal %L of Instance %L\n" netname termid~>name instname ) 
  );let
);procedure



procedure(move_pin_inst()

cv = geGetEditCellView()
pget = car(geGetSelectedSet())

pinst = car(pget~>net~>instTerms)

iname = pinst~>inst~>name 

iterm = pinst~>inst~>instTerms
itget = nth(7 iterm);
itget~>term~>pins
 Box=dbTransformBBox(itget~>term~>pins~>fig~>bBox car(geGetSelSet())~>transform)
 
 
 
 
 
 
 );
 
 
procedure(vxlpins()
cv = geGetEditCellView()
instList = cv~>instances

termList = cv~>terminals




foreach(pinName termList
    pname = pinName~>name 
    pinst = pinName>net~>instTerms
    iname =  pinst~>inst~>name
    
    
    ;dbMoveFig(pinName cv list(xf:yf "R0"))
    ;
     
foreach(inst instList
     if(inst~>name == iname then

;; This section is to filter out instTerms with external connections

        instTermList = inst~>instTerms
foreach(ter instTermList
     
     if(ter~>net~>name == pname then
;; need to get the origin for the instPins

instTermbBox = dbTransformBBox( car(ter~>term~>pins~>fig~>bBox) inst~>transform )

        xa = caar(instTermbBox)

        xb = caadr(instTermbBox)

        ya = cadar(instTermbBox)

        yb = cadadr(instTermbBox)

        x1 = (xa + xb)/2

        y1 = (ya + yb)/2

        dir = nil
        offset = 0;
        rotation = nil
case(ter~>direction
    ("input"
    xf = x1 - offset
    yf = y1
    rotation = "R0"
    )
   ("output"
    xf = x1 + offset
    yf = y1
    rotation = "R0"
   )
   ("inputOutput"
    xf = x1
    yf = y1 - offset
    rotation = "R90"
   )
);end case
	
  dbMoveFig(pinName cv list(xf:yf "R0"))        
	   
	   );endif
	 );endfor
      ); endif
   );endfor
 );endfor
 );;endprocedure
