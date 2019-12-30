 import "BennuWebServices"
 
 
/*
   BASE64


*/

 
 
 
//==================================  GLOBALS ==============================
global
   

 type MyGamedata
      int x,y;
	  
	  
   end;


/*
  ==================================
   MAIN
  ==================================
*/						
private

   MyGamedata   estructura;
   MyGamedata  pointer Pestructura; 
   
   string CadenaOriginal= "CADENA DE EJEMPLO X[123456:0001223]  Y{89892832,343434}";
     string cadenaBase64;
   string cadenaDecodificada;
   
   int tamanoestructura;
	
Begin

  
    
  set_fps (60,0); //max.  frames  

  
  //binary
  
  estructura.x= 10; estructura.y=20;  
  
  tamanoestructura= sizeof(estructura) ;
  
 cadenaBase64= BASE64_ENCODE( &estructura, tamanoestructura);
 Pestructura= BASE64_DECODE( cadenaBase64, &tamanoestructura);
 
 
 write(0,30,10,0," base64 BINARY encode   " +  cadenaBase64);  
 write(0,30,30,0," base64 BINARY decoded  X " + Pestructura.x + " Y " +  Pestructura.y);
 
 
 //strings
 
   cadenaBase64= BASE64_ENCODE_STRING( CadenaOriginal );
 cadenaDecodificada= BASE64_DECODE_string( cadenaBase64 );
 
 
 write(0,30,90,0," base64  encode   " +  cadenaBase64);  
 write(0,30,100,0," base64  decoded  " + cadenaDecodificada);
 
 
 
  
  while (!key(_esc) )     
    frame;       
  end;    
  	 

End





 