/*
    BOARD GET - Example
	 
	
*/





include "crs/coldevrestserver.prg";



private
   int status;
   string APP_ID = "2618fc21-7d59-4eb3-b400-00c31154f81a";
   string APP_PASS= "MICLAVE";    
   string BOARD_CODE= "BEST";
   string DATE1 = "2018-01-01";
   string DATE2 = "2018-12-30";
   int RESULT_LIMIT = 10;
   int NO_REPETIR_JUGADOR = true;
   
   int i;  
	
	
begin
	Set_mode(800,600,32);
	set_fps(60,0);	
	
	
	status= CRS_BOARD_GET(APP_ID, APP_PASS, BOARD_CODE, 
	        DATE1,DATE2,  RESULT_LIMIT    , NO_REPETIR_JUGADOR   );
	
    if (status == CRS_MSG_OK 	     )	
	  write(0,5,50,0,"LISTA TABLA OK    Total: "  +itoa(board_lists.board_count));
	  
	  for (i=0; i<board_lists.board_count; i++)
	    write(0,5,70+(i*10),0,"NAME: "  +board_lists.board_data[i].name+
		 " SCORE: "+  board_lists.board_data[i].score  +
		 " DATE: "+ board_lists.board_data[i].scoredate
		 );
		 
	  end
	  
   end
	
	
   if (status <= 0)  //error ?		
    
	  write(0,5,50,0,"LISTA TABLA ERROR # " + itoa(status) + 
	  string_WEB_rest);   	 
	
   end	//fin error  
     
	
 
	
	loop
		frame;
	end
end


 
	