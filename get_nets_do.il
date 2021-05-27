procedure(write_do()

cv = geGetEditCellView()

port = outfile("/home/x0122550/route_nets.do")


foreach(net cv~>nets
     fprintf(port "\n")
     fprintf(port "sel net %s \n" net~>name)
     fprintf(port "route 2; clean 5 \n");
     fprintf(port "protect selected \n");
     fprintf(port "unsel net %s \n" net~>name);
     fprintf(port "\n")
       );end for
  fprintf(port "remove_notch\n")    
 close(port);
 
 );end procedure    
      
