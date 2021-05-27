Here is a SKILL script that will work for a rectilinear prBoundary:
;;------------------

procedure(CCSUtil(pinShpId @optional (cv geGetEditCellView()) )  

 prog( (prBndy prBndyPts)

  unless(pinShpId~>pin error("Please pass a pin shape.."))

   prBndy=cv~>prBoundary
   if(prBndy~>isRectangle then
    ; prBoundary is rectangular
    println("prBoundary is rectangular")

    else
    ; prBoundary is rectilinear
    prBndyPts = prBndy~>points

    foreach(pt prBndyPts

     if(member(topEdge(pinShpId) pt) || member(bottomEdge(pinShpId) pt) then
     printf("\n Pin %s is on a horizontal edge of prBoundary"
     pinShpId~>pin~>term~>name)
     return("horizontal")
      else
	if(member(leftEdge(pinShpId) pt) || member(rightEdge(pinShpId) pt) then
	printf("\n Pin %s is on a vertical edge of prBoundary"
	pinShpId~>pin~>term~>name)
	return("vertical")
      )
     );if
    );foreach
   );if
  );prog
 );procedure

;;------------------

- load the SKILL code in CIW
- Open a cellview with the rectilinear prBoundary and select a pin and run the following:
CCSUtil(car(geGetSelSet())
- It will return a string "horizontal" or "vertical" depending on the orientation with respect to the prBoundary edges and it will print a message in CIW as well.
- Feel free to add the code when prBoundary is rectangular. This will be the then block of the first if statement in the code.
- To make this non graphic and run on all pin shapes in your cellview, you can do the following:

let( (cv)
cv=dbOpenCellViewByType("lib" "cell" "abstract")  

 foreach(term cv~>terminals
  foreach(pin term~>pins 
    CCSUtil(pin~>fig cv)
    );foreach
   );foreach
  );let

