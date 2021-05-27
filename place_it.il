procedure(place_it()
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

foreach(pinst pInst
             
	     pBox = pinst~>bBox;
             len=abs(xCoord(upperRight(pBox)) - xCoord(lowerLeft(pBox)))
             ht= abs(yCoord(upperRight(pBox)) - yCoord(lowerLeft(pBox)))
	     
	     
	     pinst~>xy = list(x y)
	         cntp++;
		 cnty++
	     x = x + len;
	     if(cnty == 4 then
	        y = y + ht;
		cnty = 0;
		x=nth(0 ref_pt);
		);endif
)


geDeselectAll() 

);end procedure
