procedure(fixit()

cv = geGetEditCellView()


inst = geGetSelectedSet()
geDeselectAll()

foreach(in inst
     
     x = nth(0 in~>xy)
     y = nth(1 in~>xy)
     
     in~>xy = list(22 y);
     );endfor
     
     );end pro
     
     
      
