 import "BennuWebServices"
 
 
/*
    HASH , ENCRYPT, CRC EXAMPLE


*/

 
 
 
//==================================  GLOBALS ==============================
global
   




/*
  ==================================
   MAIN
  ==================================
*/						
private
	int i;	
	
	string cadenaOriginal = "ESTO ES UNA CADENA DE EJEMPLO";
	string clave = "123456";	
	string cadenaEncriptada, cadenaDesencriptada;	
	string hash256Original, hash256Desencriptado;
	
	float crcOriginal, crcDesencriptado, crcBinario;
	
	struct MytinyStruct
	   int x,y; 
	end;
	
Begin

  
  cadenaEncriptada= AES256_ENCRYPT(cadenaOriginal, clave);
  cadenaDesencriptada= AES256_DECRYPT(cadenaEncriptada, clave);
  
  
  set_fps (60,0); //max.  frames      
  
   
  write(0,30,10,0," Cadena Original: " + cadenaOriginal  );
  write(0,30,20,0," Cadena Encriptada: "+cadenaEncriptada );   
  write(0,30,30,0," Cadena Desencriptada: " + cadenaDesencriptada  ); 
  

//verifica integridad del resultado  
  hash256Original =  SHA256_STRING(cadenaOriginal); 
  hash256Desencriptado =  SHA256_STRING(cadenaDesencriptada);  
 
  write(0,30,60,0," Hash256  Original : " + hash256Original   );
  write(0,30,70,0," Hash256 Resultado : " + hash256Desencriptado   );
  
  
  crcOriginal = CRC32(cadenaOriginal);
  crcDesencriptado = CRC32(cadenaDesencriptada);
  
  write(0,30,90,0, " CRC32  Original : " + crcOriginal   );
  write(0,30,100,0," CRC32 Resultado : " + crcDesencriptado   );
  
  
  
  //test binary crc
   crcBinario=  crc32(&MytinyStruct, sizeof(MytinyStruct));  //prueba un binario y su  integridad CRC
   
   write(0,30,120,0," CRC32 Binario : " + crcBinario   );   
  
  
  while (!key(_esc) )     
    frame;       
  end;    
  	 

End





 