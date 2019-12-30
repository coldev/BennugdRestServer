/*
    GAME CATALOG GET - Example
	 
	
*/





include "crs/coldevrestserver.prg";



private
   int status;
   string APP_ID = "2618fc21-7d59-4eb3-b400-00c31154f81a";
   string APP_PASS= "MICLAVE";
   string CATALOG_CODE= "CURRENCY";
   
   string CATALOG_DATA  ;
   
   
 
	
	
begin
	Set_mode(800,600,32);
	set_fps(60,0);	
	
	
	status= CRS_GAME_CATALOG_GET(APP_ID, APP_PASS, CATALOG_CODE );
	
    if (status == CRS_MSG_OK 	     )	
	  write(0,5,50,0,"GAME CATALOGO DESCARGADO OK  ( "+ crs_catalog +" )");
    end
	
	
   if (status <= 0)  //error ?		
    
	  write(0,5,50,0,"GAME CATALOGO  ERROR # " + itoa(status));   	 
	
   end	//fin error  
     
	
 
	
	loop
		frame;
	end
end


 
	