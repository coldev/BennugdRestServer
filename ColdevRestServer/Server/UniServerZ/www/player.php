<?php  
  
 


function PLAYER_USER_CREATE($appid, $user, $pass ,$email )
{
  //existe player?
  
  $stmt = SQLITEexecSQL('SELECT * FROM  player 
            WHERE appid = :appid AND user = :user  ', 
            
            array(':appid' => $appid  , ':user' => $user  )   ); 
    
  $arr = $stmt->fetchAll(PDO::FETCH_ASSOC);
  
  foreach ($arr as $titleData) 
  { 
    echo  json_encode(array('rest' => -1 ) );
    exit(); 
  } 

  
	
 //==================== ingresar 	
    $clave = hash('sha256', $pass);

    $stmt = SQLITEexecSQL('INSERT INTO player(appid,user,pass,email) VALUES(:appid,:user,:pass,:email)', 
            array(':appid' => $appid , ':user' => $user,  ':pass' => $clave ,   ':email' => $email )   );
    
    if ( $stmt->rowCount() > 0)     
     echo  json_encode(array('rest' => 1 ) ); 
    else
     echo  json_encode(array('rest' => 0 ) ); 
      
      
   exit();
        
}




 





function PLAYER_USER_LIST($appid )
{
    $stmt = SQLITEexecSQL('SELECT user,email FROM  player WHERE appid = :appid', 
            array(':appid' => $appid    )   );
 
    
 $arr = $stmt->fetchAll(PDO::FETCH_ASSOC);
 
 
 $registros = json_encode(array('rest' => 1 , 'list' => $arr)  );
 
 if (count($arr) > 0)
   echo  $registros; 
 else
   echo  json_encode(array('rest' => 0  )  );     //vacio
      
  exit();  
}




function PLAYER_USER_LOGIN($appid , $user, $pass)
{   
 
 if ( VerificarCredencialesUSER($appid , $user, $pass)    )   
 {  
     Login_Insert_Record($appid , $user);
   
     echo  json_encode(array('rest' => 1 ) ); 
 }
  
 exit();   
}





function PLAYER_USER_CATALOG_UPLOAD($appid, $user , $code, $data )
{     
   SQLITEexecSQL('DELETE FROM player_catalog WHERE appid = :appid AND user = :user AND code = :code ',
              array(':appid' => $appid , ':user' => $user,  ':code' => $code)
              );  //borra el actual catalogo
   
   
    $stmt = SQLITEexecSQL('INSERT INTO player_catalog(appid,user,code, data) VALUES(:appid,:user, :code, :data)', 
            array(':appid' => $appid , ':user' => $user,  ':code' => $code , ':data' => $data )   );
    
    if ( $stmt->rowCount() > 0)     
     echo  json_encode(array('rest' => 1 ) ); 
    else
     echo  json_encode(array('rest' => 0 ) ); 
      
      
   exit();
        
}





function PLAYER_USER_CATALOG_GET($appid, $user , $code )
{
    $stmt = SQLITEexecSQL('SELECT data FROM  player_catalog 
		WHERE appid = :appid  AND user = :user AND code = :code', 
            array(':appid' => $appid , ':user' => $user, ':code' => $code   )   );
 
    
 $arr = $stmt->fetchAll(PDO::FETCH_ASSOC);
 
  
 
 if (count($arr) > 0)
   echo  json_encode(array('rest' => 1 ,'list' => $arr ) ); 
 else
   echo  json_encode(array('rest' => 0  )  );     //vacio
      
  exit();  
}



 
 
 
 
 
 
 

  //====================================================================
//====================================================================
//====================================================================

 $DeliveryD = null;  

  if (isset( $_POST["pp"] )  )   $DeliveryD = $_POST;
  if (isset( $_GET["pp"] )  )    $DeliveryD = $_GET;



if (isset( $_POST["pp"] ) || isset( $_GET["pp"] ) )
{

 
 //crear player 
 if ( $DeliveryD["pp"] == 4000   
     &&  isset( $DeliveryD["appid"]) && isset( $DeliveryD["apppass"])	 
     &&  isset( $DeliveryD["user"]) &&  isset( $DeliveryD["userpass"])
     &&  isset( $DeliveryD["email"])	  
 )  
 {	 
  
   if (VerificarCredencialesAPP($DeliveryD["appid"], $DeliveryD["apppass"]  )      )	   
   {    
	PLAYER_USER_CREATE($DeliveryD["appid"], $DeliveryD["user"], $DeliveryD["userpass"] , $DeliveryD["email"] );
   }
   
 }
 //=====================
 


 //listar players 
 if ( $DeliveryD["pp"] == 4100   
     &&  isset( $DeliveryD["appid"]) && isset( $DeliveryD["apppass"])	 
     
	  
 )  
 {	 
  
   if (VerificarCredencialesAPP($DeliveryD["appid"], $DeliveryD["apppass"]  )      )	   
   {    
	PLAYER_USER_LIST($DeliveryD["appid"]  );
   }
   
 }
 //=====================
  
 
  // player login 
 if ( $DeliveryD["pp"] == 4200   
     &&  isset( $DeliveryD["appid"]) && isset( $DeliveryD["apppass"])	 
     &&  isset( $DeliveryD["user"]) &&  isset( $DeliveryD["userpass"])
	  
 )  
 {	 
  
   if (VerificarCredencialesAPP($DeliveryD["appid"], $DeliveryD["apppass"]  )      )	   
   {    
	PLAYER_USER_LOGIN($DeliveryD["appid"], $DeliveryD["user"], $DeliveryD["userpass"] );
   }
   
 }
 //=====================

 
 
   // player up catalog 
 if ( $DeliveryD["pp"] == 4300   
     &&  isset( $DeliveryD["appid"]) && isset( $DeliveryD["apppass"])	 
     &&  isset( $DeliveryD["user"]) &&  isset( $DeliveryD["userpass"])
	 &&  isset( $DeliveryD["cat_code"]) &&  isset( $DeliveryD["data"])
	 
	  
 )  
 {	 
  
   if (VerificarCredencialesAPP($DeliveryD["appid"], $DeliveryD["apppass"]  )      &&
       VerificarCredencialesUSER($DeliveryD["appid"], $DeliveryD["user"], $DeliveryD["userpass"])    ) 	   
   {    
	PLAYER_USER_CATALOG_UPLOAD($DeliveryD["appid"], $DeliveryD["user"], $DeliveryD["cat_code"],
					$DeliveryD["data"] );
	
	 
   }
   
 }
 //=====================

 
 
 
   // player DWN catalog 
 if ( $DeliveryD["pp"] == 4400   
     &&  isset( $DeliveryD["appid"]) && isset( $DeliveryD["apppass"])	 
     &&  isset( $DeliveryD["user"]) &&  isset( $DeliveryD["userpass"])
	 &&  isset( $DeliveryD["cat_code"])  
	 
	  
 )  
 {	 
  
   if (VerificarCredencialesAPP($DeliveryD["appid"], $DeliveryD["apppass"]  )      &&
       VerificarCredencialesUSER($DeliveryD["appid"], $DeliveryD["user"], $DeliveryD["userpass"])    ) 	   
   {    
	PLAYER_USER_CATALOG_GET($DeliveryD["appid"], $DeliveryD["user"], $DeliveryD["cat_code"]	  );
	
	 
   }
   
 }
 //=====================

 
 
}//if isset pp

 
?>