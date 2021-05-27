procedure(dig_place( col )
cv = geGetEditCellView()
pBox = nil;
pInst = nil;
geSelectArea()
    pInst = geGetSelectedSet()                 
foreach(inst pInst
                     inst~>orient = "R0";
                 )
    

geDeselectAll() 



;;pBox=car(pInst~>bBox);
;;len=abs(xCoord(upperRight(pBox)) - xCoord(lowerLeft(pBox)))
;;ht= abs(yCoord(upperRight(pBox)) - yCoord(lowerLeft(pBox)))

build_ref_pt()


x=nth(0 ref_pt);
y=nth(1 ref_pt);
cntp = 0;
cnty = 0;
ot = 0;
foreach(pinst pInst
             
	     pBox = pinst~>bBox;
       if(ot == 0 then
              pinst~>orient = "R0");
       if(ot == 1 then
              pinst~>orient = "MX"
	      );
	      
             len=abs(xCoord(upperRight(pBox)) - xCoord(lowerLeft(pBox)))
             ht= abs(yCoord(upperRight(pBox)) - yCoord(lowerLeft(pBox)))
	     
	     
	     pinst~>xy = list(x y)
	         cntp++;
		 cnty++
	     x = x + len;
	     if(cnty ==  col then
	        y = y + ht;
		cnty = 0;
		x=nth(0 ref_pt);
		not = case( ot
                     (0 ot = 1  y = y + ht 1)
                     (1 ot = 0  y = y - ht 0)
                     (t 'Other))
		);endif
)


geDeselectAll() 

);end procedure
