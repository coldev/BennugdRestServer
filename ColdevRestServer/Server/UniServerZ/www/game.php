<?php  
  
 

function GAME_CATALOG_UPLOAD($appid,   $code, $data )
{     
   SQLITEexecSQL('DELETE FROM game_catalog WHERE appid = :appid AND   code = :code ',
              array(':appid' => $appid ,    ':code' => $code)
              );  //borra el actual catalogo
   
   
    $stmt = SQLITEexecSQL('INSERT INTO game_catalog(appid, code, data) VALUES(:appid, :code, :data)', 
            array(':appid' => $appid ,   ':code' => $code , ':data' => $data )   );
    
    if ( $stmt->rowCount() > 0)     
     echo  json_encode(array('rest' => 1 ) ); 
    else
     echo  json_encode(array('rest' => 0 ) ); 
      
      
   exit();
        
}




function GAME_CATALOG_GET($appid,   $code )
{
    $stmt = SQLITEexecSQL('SELECT data FROM  game_catalog 
		WHERE appid = :appid    AND code = :code', 
            array(':appid' => $appid  , ':code' => $code   )   );
 
    
 $arr = $stmt->fetchAll(PDO::FETCH_ASSOC);
 
 
 $registros = json_encode(array('rest' => 1, 'list' => $arr)  );
 
 if (count($arr) > 0)
   echo  $registros ; 
 else
   echo  json_encode(array('rest' => 0  )  );     //vacio
      
  exit();  
}
 

 
  



  
  
  //====================================================================
//====================================================================
//====================================================================


if (isset( $_POST["pp"] )  || isset( $_GET["pp"] )  )
{

 $DeliveryD = null;  

  if (isset( $_POST["pp"] )  )   $DeliveryD = $_POST;
  if (isset( $_GET["pp"] )  )    $DeliveryD = $_GET;


 
 //subir catalogo 
 if ( $DeliveryD["pp"] == 3000   
     &&  isset( $DeliveryD["appid"]) && isset( $DeliveryD["apppass"])	 
     &&  isset( $DeliveryD["cat_code"]) &&  isset( $DeliveryD["data"])
	  
 )  
 {	 
  
   if (VerificarCredencialesAPP($DeliveryD["appid"], $DeliveryD["apppass"]  )      )	   
   {    
	GAME_CATALOG_UPLOAD($DeliveryD["appid"], $DeliveryD["cat_code"], $DeliveryD["data"] );
   }
   
 }
 //=====================
 
 
 
 
  //descargar catalogo 
 if ( $DeliveryD["pp"] == 3100   
     &&  isset( $DeliveryD["appid"]) && isset( $DeliveryD["apppass"])	 
     &&  isset( $DeliveryD["cat_code"]) 
	  
 )  
 {	 
  
   if (VerificarCredencialesAPP($DeliveryD["appid"], $DeliveryD["apppass"]  )      )	   
   {    
	GAME_CATALOG_GET($DeliveryD["appid"], $DeliveryD["cat_code"]  );
   }
   
 }
 //=====================
 
 
 
 
 
}//if isset pp   
  
?>