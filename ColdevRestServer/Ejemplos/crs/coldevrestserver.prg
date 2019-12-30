/*
   COLDEV REST SERVER (c)  COLOMBIAN DEVELOPERS
   
   ===   MIT LICENSE  ===

   
   
   
  >> John 1:12  (Jesus Christ Lord and Savior)
   
   Yet to all who did receive him, to those who believed in his name,
   he gave the right to become children of God <<<

*/


const 
   CRS_MSG_RECORD_EMPTY= 2;
  CRS_MSG_OK =1;
  
  
  CRS_MSG_ERROR =0;
  CRS_MSG_ERROR_EXISTS =-1;
  CRS_MSG_ERROR_APP_PASS = -2;
  CRS_MSG_ERROR_USER_PASS = -3;
  
  CRS_BUFFER_SIZE = 1000000; //1mb
  
end;



global
   string string_WEB_rest; 
   string crs_catalog;
   string CRS_ServerAddress =
   "http://coldev.co.nf/coldevrestserver/server.php";
   
   
   struct player_lists
    int player_count;
	
    struct player_data[9000]
      string name;
	  string email;   
    end;
   end;
 
 
 
  struct board_lists
    int board_count;
 
   struct board_data[9000]
      string name;
	  string  score;
	  string scoredate;   
   end;
  end;
 
  int inetapi_curl,inetapi_status; 
 
end;




//-----------------------------------------------------------------------------
function inetGetPublicString( string  direccion , string postvars)	
	
begin
   inetapi_curl = curl_init();
   
    if(inetapi_curl == -1)
        say("Curl initialisation failed, quitting");
        return;
    end;
 	
	curl_setopt(inetapi_curl, cURLOPT_url, direccion );
	curl_setopt(inetapi_curl, cURLOPT_POSTFIELDS, postvars );
	curl_setopt(inetapi_curl, cURLOPT_WRITEDATA, &string_WEB_rest);
//	url_set_opt(inetapi_curl, URLOPT_USERAGENT, "User-Agent: Mozilla/4.0 (Windows 7 6.1) Java/1.7.0_51");
	
	  curl_perform(inetapi_curl, &inetapi_status);
    
    // Wait for the transfer to finish
    while(inetapi_status == -2)
        FRAME;
    end;
   
	curl_cleanup(inetapi_curl);
 
	
	return(inetapi_status);
end
//-----------------------------------------------------------------------------







//-----------------------------------------------------------------------------
//                ==== CREATE APP  ===
//-----------------------------------------------------------------------------
function CRS_APP_CREATE(string APPID, string APP_PASS, string EMAIL)
private
	int status;
	string varsenviar;
	
	int resultado_peticion=0, item, json;
	
BEGIN 

    varsenviar = "pp=1000&appid=" + APPID+ "&pass="+ APP_PASS + 
	         "&email=" +  EMAIL;

	status = inetGetPublicString( CRS_ServerAddress, varsenviar  );
	
 
    
    if (status == 0) 	//recibe la respuesta JSON
	 json = json_new(string_WEB_rest);
 	 if (json > 0 )	
	
	   item= json_object_get(json,"rest");
	   resultado_peticion= json_int_get(item);	
	     	   
	 end
	 
	end
	
    RETURN (resultado_peticion);    
END
//-----------------------------------------------------------------------------













//==================================  PLAYERS =====================




//-----------------------------------------------------------------------------
//                ==== CREATE PLAYERS  ===
//-----------------------------------------------------------------------------
function CRS_PLAYER_CREATE(string APPID, string APP_PASS, 
       string USER, string USER_PASS, string EMAIL)
private
	int status;
	string varsenviar;
	
	int resultado_peticion=0, item, json;
	
BEGIN 

    varsenviar = "pp=4000&appid=" + APPID+ "&apppass="+ APP_PASS + 
	        "&user="+ USER + "&userpass="+USER_PASS +
			"&email=" +  EMAIL;

			 
			 
	status = inetGetPublicString( CRS_ServerAddress, varsenviar  );
	
 
    
    if (status == 0) 	//recibe la respuesta JSON
	 json = json_new(string_WEB_rest);
 	 if (json > 0 )	
	
	   item= json_object_get(json,"rest");
	   resultado_peticion= json_int_get(item);	
	     	   
	 end
	 
	end
	
    RETURN (resultado_peticion);    
END
//-----------------------------------------------------------------------------







//-----------------------------------------------------------------------------
//                ==== LIST PLAYERS  ===
//-----------------------------------------------------------------------------
function CRS_PLAYER_LIST(string APPID, string APP_PASS        )
private
	int status;
	string varsenviar;
	
	int resultado_peticion=0, item, json, i, itemarray;
	
BEGIN 

    varsenviar = "pp=4100&appid=" + APPID+ "&apppass="+ APP_PASS     ;

			 
			 
	status = inetGetPublicString( CRS_ServerAddress, varsenviar  );
	
 
    
    if (status == 0) 	//recibe la respuesta JSON
	 json = json_new(string_WEB_rest);
 	 if (json > 0 )	
	
	   item= json_object_get(json,"rest");
	   resultado_peticion= json_int_get(item);	
	   
	   //obtiene listado
	   item= json_object_get(json, "list");   

       player_lists.player_count =   json_array_size(item);
       for (i=0; i<player_lists.player_count; i++)
 	      itemarray= json_array_get(item, i  );		
		  
		  player_lists.player_data[i].name= 
		  json_string_get( json_object_get(itemarray, "user"));
		  player_lists.player_data[i].email= 
		  json_string_get( json_object_get(itemarray, "email") );
		  
	   end 
	   //fin listado
	 end
	 
	end
	
    RETURN (resultado_peticion);    
END
//-----------------------------------------------------------------------------





//-----------------------------------------------------------------------------
//                ====  PLAYER LOGIN  ===
//-----------------------------------------------------------------------------
function CRS_PLAYER_LOGIN(string APPID, string APP_PASS  ,
			string USER, string USER_PASS      )
private
	int status;
	string varsenviar;
	
	int resultado_peticion=0, item, json;
	
BEGIN 

    varsenviar = "pp=4200&appid=" + APPID+ "&apppass="+ APP_PASS  +
	"&user="+ USER + "&userpass="+USER_PASS;

			 
			 
	status = inetGetPublicString( CRS_ServerAddress, varsenviar  );
	
 
    
    if (status == 0) 	//recibe la respuesta JSON
	 json = json_new(string_WEB_rest);
 	 if (json > 0 )	
	
	   item= json_object_get(json,"rest");
	   resultado_peticion= json_int_get(item);	
	     	   
	 end
	 
	end
	
    RETURN (resultado_peticion);    
END
//-----------------------------------------------------------------------------






//-----------------------------------------------------------------------------
//                ====  PLAYER CATALOG SET  ===
//-----------------------------------------------------------------------------
function CRS_PLAYER_CATALOG_SET(string APPID, string APP_PASS  ,
			string USER, string USER_PASS  , string CAT_CODE,
			string CAT_DATA 
			)
private
	int status;
	string varsenviar;
	
	int resultado_peticion=0, item, json;
	
BEGIN 

    varsenviar = "pp=4300&appid=" + APPID+ "&apppass="+ APP_PASS  +
	"&user="+ USER + "&userpass="+USER_PASS+
	"&cat_code="+CAT_CODE +  "&data="+ CAT_DATA;

 			 
			 
	status = inetGetPublicString( CRS_ServerAddress, varsenviar  );
	
 
    
    if (status == 0) 	//recibe la respuesta JSON
	 json = json_new(string_WEB_rest);
 	 if (json > 0 )	
	
	   item= json_object_get(json,"rest");
	   resultado_peticion= json_int_get(item);	
	     	   
	 end
	 
	end
	
    RETURN (resultado_peticion);    
END
//-----------------------------------------------------------------------------





//-----------------------------------------------------------------------------
//                ====  PLAYER CATALOG GET  ===
//-----------------------------------------------------------------------------
function CRS_PLAYER_CATALOG_GET(string APPID, string APP_PASS  ,
			string USER, string USER_PASS  , string CAT_CODE 			)
private
	int status;
	string varsenviar;
	
	int resultado_peticion=0, item, json;
	
	int  itemarray;
	
BEGIN 

    varsenviar = "pp=4400&appid=" + APPID+ "&apppass="+ APP_PASS  +
	"&user="+ USER + "&userpass="+USER_PASS+
	"&cat_code="+CAT_CODE  ;

 			 
			 
	status = inetGetPublicString( CRS_ServerAddress, varsenviar  );
	
 
    
    if (status == 0) 	//recibe la respuesta JSON
	 json = json_new(string_WEB_rest);
 	 if (json > 0 )	
	
	   item= json_object_get(json,"rest");
	   resultado_peticion= json_int_get(item);

	   //obtiene catalogo
	   item= json_object_get(json, "list");   

       if  (json_array_size(item)  > 0 )        
 	      itemarray= json_array_get(item, 0  );		
		  
		  crs_catalog= json_string_get( json_object_get(itemarray, "data"));		  
	   end 
	   //fin obtiene cat        
	     	   
	 end
	 
	end
	
    RETURN (resultado_peticion);    
END
//-----------------------------------------------------------------------------









//==================================  BOARDS =====================



//-----------------------------------------------------------------------------
//                ==== BOARD  SET  ===
//-----------------------------------------------------------------------------
function CRS_BOARD_SET(string APPID, string APP_PASS, 
         string USER, string USER_PASS, string BOARDCODE, int SCOREUP)
private
	int status;
	string varsenviar;
	
	int resultado_peticion=0, item, json;
	
BEGIN 

    varsenviar = "pp=2000&appid=" + APPID+ "&apppass="+ APP_PASS + 
	         "&user="+USER + "&userpass="+ USER_PASS +
			 "&boardcode="+BOARDCODE + "&score=" + itoa(SCOREUP);
			  

			 
	status = inetGetPublicString( CRS_ServerAddress, varsenviar  );
	
 
    
    if (status == 0) 	//recibe la respuesta JSON
	 json = json_new(string_WEB_rest);
 	 if (json > 0 )	
	
	   item= json_object_get(json,"rest");
	   resultado_peticion= json_int_get(item);	
	     	   
	 end
	 
	end
	
    RETURN (resultado_peticion);    
END
//-----------------------------------------------------------------------------





//-----------------------------------------------------------------------------
//                ==== BOARD  GET  ===
//-----------------------------------------------------------------------------
function CRS_BOARD_GET(string APPID, string APP_PASS, 
          string BOARDCODE, string DATE1, string DATE2, int RES_LIMIT, 
		  int notrepeat )
private
	int status;
	string varsenviar;
	
	int resultado_peticion=0, item, json;
	
	int i, itemarray;
BEGIN 

    varsenviar = "pp=2100&appid=" + APPID+ "&apppass="+ APP_PASS + 	         
			 "&boardcode="+BOARDCODE + 
			 "&date1="+ DATE1 +  "&date2=" + DATE2 + 
			 "&count=" + itoa(RES_LIMIT);
	
	if (notrepeat) //no repetir players en listado
	   varsenviar = varsenviar + "&notrepeat=true";
	end
	 	 
	status = inetGetPublicString( CRS_ServerAddress, varsenviar  );
	
 
    
    if (status == 0) 	//recibe la respuesta JSON
	 json = json_new(string_WEB_rest);
 	 if (json > 0 )	
	
	   item= json_object_get(json,"rest");
	   resultado_peticion= json_int_get(item);
	   

	   //obtiene listado
	   item= json_object_get(json, "list");   

       board_lists.board_count =   json_array_size(item);
	   
       for (i=0; i<board_lists.board_count; i++)	    
	   
 	      itemarray= json_array_get(item, i  );		
		  
		  board_lists.board_data[i].name= 
		    json_string_get( json_object_get(itemarray, "user"));
		  board_lists.board_data[i].score= 
		    json_string_get( json_object_get(itemarray, "score") );
		  board_lists.board_data[i].scoredate= 
		    json_string_get( json_object_get(itemarray, "scoredate") );
		  
	   end 
	   //fin listado
	   

	   
	 end
	 
	end
	
    RETURN (resultado_peticion);    
END
//-----------------------------------------------------------------------------












//==================================  GAMES =====================






//-----------------------------------------------------------------------------
//                ====  GAME CATALOG SET  ===
//-----------------------------------------------------------------------------
function CRS_GAME_CATALOG_SET(string APPID, string APP_PASS  ,
			  string CAT_CODE, 			string CAT_DATA 
			)
private
	int status;
	string varsenviar;
	
	int resultado_peticion=0, item, json;
	
BEGIN 

    varsenviar = "pp=3000&appid=" + APPID+ "&apppass="+ APP_PASS  +	 
	"&cat_code="+CAT_CODE +  "&data="+ CAT_DATA;

 			 
			 
	status = inetGetPublicString( CRS_ServerAddress, varsenviar  );
	
 
    
    if (status == 0) 	//recibe la respuesta JSON
	 json = json_new(string_WEB_rest);
 	 if (json > 0 )	
	
	   item= json_object_get(json,"rest");
	   resultado_peticion= json_int_get(item);	
	     	   
	 end
	 
	end
	
    RETURN (resultado_peticion);    
END
//-----------------------------------------------------------------------------







//-----------------------------------------------------------------------------
//                ====  GAME CATALOG GET  ===
//-----------------------------------------------------------------------------
function CRS_GAME_CATALOG_GET(string APPID, string APP_PASS  ,
			  string CAT_CODE  
			)
private
	int status;
	string varsenviar;
	
	int resultado_peticion=0, item, json;
	int itemarray;
	
BEGIN 

    varsenviar = "pp=3100&appid=" + APPID+ "&apppass="+ APP_PASS  +	 
	"&cat_code="+CAT_CODE  ;

 			 
			 
	status = inetGetPublicString( CRS_ServerAddress, varsenviar  );
	
 
    
    if (status == 0) 	//recibe la respuesta JSON
	 json = json_new(string_WEB_rest);
 	 if (json > 0 )	
	
	   item= json_object_get(json,"rest");
	   resultado_peticion= json_int_get(item);	

	   //obtiene catalogo
	   item= json_object_get(json, "list");   

       if  (json_array_size(item)  > 0 )        
 	      itemarray= json_array_get(item, 0  );		
		  
		  crs_catalog= json_string_get( json_object_get(itemarray, "data"));		  
	   end 
	   //fin obtiene cat        


	   
	 end
	 
	end
	
    RETURN (resultado_peticion);    
END
//-----------------------------------------------------------------------------

