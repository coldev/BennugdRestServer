/*
     PLAYER CATALOG SET - Example


	 
	
*/





include "crs/coldevrestserver.prg";



private
   int status;
   string APP_ID = "2618fc21-7d59-4eb3-b400-00c31154f81a";
   string APP_PASS= "MICLAVE";
    string USER = "laurita";
   string USER_PASS = "78127172mm";   
   string CATALOG_CODE = "B001";   
   string CATALOG_DATA = "ABSNNHHD7767E4343433";   
   

   
 
	
	
begin
	Set_mode(800,600,32);
	set_fps(60,0);	
	
	
	status= CRS_PLAYER_CATALOG_SET(APP_ID, APP_PASS , USER, USER_PASS,
	      CATALOG_CODE, CATALOG_DATA);
	
    if (status == CRS_MSG_OK 	     )	
	  write(0,5,50,0,"PLAYER CATALOG SET OK");
    end

   	
	
   if (status <= 0)  //error ?		
   
	  write(0,5,50,0,"Player CATALOG error..");	  
 
	
   end	//fin error  
     
	
 
	
	loop
		frame;
	end
end


 
	