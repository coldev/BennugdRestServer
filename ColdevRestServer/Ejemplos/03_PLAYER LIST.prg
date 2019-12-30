/*
    LIST PLAYER - Example


	 
	
*/





include "crs/coldevrestserver.prg";



private
   int status;
   string APP_ID = "2618fc21-7d59-4eb3-b400-00c31154f81a";
   string APP_PASS= "MICLAVE";
 
   int i;
 
	
	
begin
	Set_mode(800,600,32);
	set_fps(60,0);	
	
	
	status= CRS_PLAYER_LIST(APP_ID, APP_PASS );
	
    if (status == CRS_MSG_OK 	     )	
	  write(0,5,50,0,"PLAYER LISTADO OK  total : "+ itoa( player_lists.player_count)  );
	  
	  
      for (i=0; i<player_lists.player_count; i++)	  
	     write(0,5,70+(i*10),0,"NOMBRE : "+ player_lists.player_data[i].name+
		 "  EMAIL : "+player_lists.player_data[i].email);
	     
	  end
	  
    end

    if (status == CRS_MSG_RECORD_EMPTY 	     )	
	  write(0,5,50,0,"PLAYER LISTADO VACIO");
    end	
	
	
	
   if (status <= 0)  //error ?		
   
	  write(0,5,50,0,"Player Listado error..");	  
 
	
   end	//fin error  
     
	
 
	
	loop
		frame;
	end
end


 
	