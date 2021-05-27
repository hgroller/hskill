procedure(dig_place()
cv = geGetEditCellView()
pBox = nil;
pInst = nil;
geSelectArea()
    ;;pInst = geGetSelectedSet()                 
;;foreach(inst pInst
                     ;;inst~>orient = "R0";
                 ;;)
  geDeselectAll() 



;;pBox=car(pInst~>bBox);
;;len=abs(xCoord(upperRight(pBox)) - xCoord(lowerLeft(pBox)))
;;ht= abs(yCoord(upperRight(pBox)) - yCoord(lowerLeft(pBox)))

build_ref_pt()

pstate = 0;
x=nth(0 ref_pt);
y=nth(1 ref_pt);
cntp = 0;
cnty = 0;
orient = 0;
ot = 0;
foreach(pinst pInst
             
	     pBox = pinst~>bBox;
                if(ot == 0 then
	        pBox~>orient = "R0";
	        );endif
	        if(ot == 1 then
	        pBox~>orient = "MX"
	        );endif
	     len=abs(xCoord(upperRight(pBox)) - xCoord(lowerLeft(pBox)))
             ht= abs(yCoord(upperRight(pBox)) - yCoord(lowerLeft(pBox)))
	     pinst~>xy = list(x y)
	         cntp++;
		 cnty++
	     x = x + len;
	     
	     if(cnty == 4 then
		pstate = ot;
		y = y + ht;
		x=nth(0 ref_pt);
		cnty = 0;       
		case( ot
		      ( 0
		        ot = 1;
			)
		      ( 1
		        ot = 0;
			)
		);endcase
	            
		
               );endif
)

geDeselectAll() 

);end procedure
