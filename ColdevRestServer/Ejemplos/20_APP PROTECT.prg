 import "BennuWebServices"
 
 
/*
   APP PROTECT

   29539
*/

 
 
 
//==================================  GLOBALS ==============================
global
   




/*
  ==================================
   MAIN
  ==================================
*/						
private
   string APP_ID = "IDENTIFICADORDEAPLICACION";
	 
	
Begin

  
    
  set_fps (60,0); //max.  frames      
  
   
  write(0,30,10,0," APP HARDWARE ID (Identificador de Hardware): " + APP_HARDWARE_ID()  );
  
  if (APP_EXISTS( APP_ID ) )
   write(0,30,20,0,"YA EXISTE OTRA INSTANCIA DE LA APLICACION " );   
  else
    write(0,30,20,0,"SOLO UNA APLICACION CORRIENDO AL TIEMPO " ); 
  end  

 
  
  while (!key(_esc) )     
    frame;       
  end;    
  	 

End





 