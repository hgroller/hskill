;;;;;;Procedure to Build Sup Caps for Top Level
;;;;;;Written :Tracy Groller
;;;;;;For Org : HDD


procedure(BuildCap()
cv = geGetEditCellView()
ccount = 250;
rcount = 250
instcnt = length(cv~>instances);
inst = cv~>instances

foreach(insget inst
      if( insget~>cellName == "CAP_3STK_NWDN" then
          ccount++ )
	if( insget~>cellName == "RES_PEMIT" then
          rcount++ )  
);endforeach
	  

ccount = ccount + 1;
rcount = rcount + 1;;
iname = sprintf(nil "|CC%d" ccount);
;;if(fndinst = dbFindAnyInstByName(cv iname) != nil then
      ;;ccount = ccount + 1;
      ;;rcount = rcount + 1
      ;;);
      
;;until(fndinst != nil then
   ;;ccount = ccount + 1;
   ;;rcount = rcount + 1;);end until
   




VCCcap =  enterBox(
         ?prompts        list(
                                "Enter the first point:"
                                "Enter the next point:"
                                )
	 ?doneProc      "returnPoints"
        )
	

ll = nth(0 VCCcap);
uu = nth(1 VCCcap);
llx = nth(0 ll);
lly = nth(1 ll);


wd = nth(0 uu) - nth(0 ll) - 15
ln = nth(1 uu) - nth(1 ll) - 15


lnf = sprintf(nil "%f" ln)
wdf = sprintf(nil "%f" wd)


procedure( returnPoints( w_windowId b_done l_points )

        printf( "List of points entered %L\n" l_points )
       lpts = l_points;

)


capinstvcc =  dbOpenCellViewByType("50bicom3xl" "CAP_3STK_NWDN" "layoutE")
iname = sprintf(nil "|CC%d" ccount);

addcapvcc = dbCreateInst(cv capinstvcc iname
                            llx:lly "R0" 1)
dbCreateProp(addcapvcc "termOffset" "string" "10")
dbCreateProp(addcapvcc "exitMetalConfig" "string" "W")
dbCreateProp(addcapvcc "topContactConfig" "string" "1NSWE")
dbCreateProp(addcapvcc "termWidth" "string" "10")
dbCreateProp(addcapvcc "aspect" "string" "8.75")
dbCreateProp(addcapvcc "l" "string" lnf)
dbCreateProp(addcapvcc "w" "string" wdf)
dbCreateProp(addcapvcc "Ctype" "string" "enter w/l, r calculated")
dbCreateProp(addcapvcc "unitC" "string" "10.82p")
dbCreateProp(addcapvcc "exitMetalConfig2" "string" "E")
dbCreateProp(addcapvcc "c" "string" "10.82p")
dbCreateProp(addcapvcc "c1" "string" "2.52p")
dbCreateProp(addcapvcc "c3" "string" "4.714p")
dbCreateProp(addcapvcc "c2" "string" "3.588p")

cBbox = lowerLeft(addcapvcc~>bBox)
rlx = nth(0 cBbox) - 5;
rly = nth(1 cBbox);
resinst = dbOpenCellViewByType("50bicom3xl" "RES_PEMIT" "layoutF")
rname = sprintf(nil "|RR%d" rcount);
addres = dbCreateInst(cv resinst rname rlx:rly "MXR90" 1)	
dbCreateProp(addres "linkR" "string" "69.56")
dbCreateProp(addres "semiResL" "string" "2.50")
dbCreateProp(addres "parasiticL" "string" "3.50")
dbCreateProp(addres "bodyR" "string" "48.35")
dbCreateProp(addres "headR" "string" "10.61")
dbCreateProp(addres "linkL" "string" "2.50")
dbCreateProp(addres "w" "string" "16")
dbCreateProp(addres "tfviaNum" "string" "0")
dbCreateProp(addres "r" "string" "69.56")
dbCreateProp(addres "round" "string" "yes")
dbCreateProp(addres "dataEntryMode" "string" "enter w/l, r calculated")

		    		    )
 
