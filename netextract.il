procedure(getnet()
 
 cv = geGetEditCellView()
 aa = car(geGetSelectedSet()) 
 shapes = aa~>master~>shapes
 terms =  aa~>instTerms
 netname = "VEE";
 b = nth(39 shapes)
 foreach(term terms
      if(car(term~>net~>sigNames) == netname
         termid=term
         
	 )
    );foreach
 
     
  );endprocedure
  
  
  
 
      

procedure(CCSTransformShapeBBox(layer stopLevel)

   let((cv finalList shapes att_list)

      cv=geGetWindowCellView()

        shapes=dbGetOverlaps(cv cv~>bBox layer 1:stopLevel nil)

          finalList=nil

           foreach(shape shapes

          att_list=CCSTransformBBox(shape)

       if(att_list then

     finalList=append(finalList list(att_list))

     )

     ) ;foreach

finalList

) ;let

) ;procedure

 

procedure(CCSTransformBBox(shape)

   let((flatList y)

      flatList = nil

         while(listp(shape)

            y = car(shape)

             flatList = append(flatList list(y))

          shape = cadr(shape) ; next shape

       );while

geTransformUserBBox(shape~>bBox geGetInstTransform(flatList))

);let

);procedure

 
     
