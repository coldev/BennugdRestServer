 import "BennuWebServices"
 
 
/*
   DATA COMPRESSED


*/

 
 
 
//==================================  GLOBALS ==============================
global
   

 type MyGamedata
      int x,y;
	  
	  int Gamedata[100][100];
   end;


/*
  ==================================
   MAIN
  ==================================
*/						
private

   MyGamedata   estructura;
   MyGamedata  pointer Pestructura; 
   
     string cadenaComprimida;   
   int tamanoestructura;
	
Begin

  
    
  set_fps (60,0); //max.  frames  

  estructura.x= 10; estructura.y=20;  
  
  tamanoestructura= sizeof(estructura) ;
  
  cadenaComprimida=  DATA_COMPRESS(&estructura, tamanoestructura );
  
  Pestructura= DATA_UNCOMPRESS( cadenaComprimida, &tamanoestructura); 
  
 write(0,30,10,0," DATA size " + tamanoestructura + " Data size compressed " + strlen(cadenaComprimida) );
   
  write(0,30,30,0," DATA COMPRESSED: " + cadenaComprimida  );
  
   write(0,30,50,0,  " DATA UNCOMPRESSED    X " + Pestructura.x + " Y " + Pestructura.y  );
 
  
  while (!key(_esc) )     
    frame;       
  end;    
  	 

End





 