<?php  
  
 


 function BOARD_SCORE_UPLOAD($appid, $boardcode, $user, $score  )
{
     

    $stmt = SQLITEexecSQL('INSERT INTO board(appid,boardcode,user,score) 
     				VALUES(:appid,:boardcode,:user,:score)', 
            array(':appid' => $appid , ':boardcode' => $boardcode,  ':user' => $user,  ':score' => $score 
              )   );
    
    if ( $stmt->rowCount() > 0)     
     echo  json_encode(array('rest' => 1 ) ); 
    else
     echo  json_encode(array('rest' => 0 ) ); 
      
      
   exit();
        
}




function BOARD_SCORE_LIST($appid , $boardcode, $fechadesde, $fechahasta, $resultcount )
{
	$cadenaGroup = '';  //fix resultados repetidos
	if (isset($_POST["notrepeat"])  )  $cadenaGroup = ' GROUP BY user ';
	
	
    $stmt = SQLITEexecSQL('SELECT DISTINCT user,score, scoredate FROM  board 
    			WHERE appid = :appid AND boardcode = :boardcode
    			AND scoredate BETWEEN :fechadesde AND :fechahasta
				'.$cadenaGroup.'
                      ORDER BY score DESC, scoredate DESC					  
                      LIMIT :resultcount',
                       
            array(':appid' => $appid , ':boardcode' => $boardcode, 
                  ':fechadesde' => $fechadesde , ':fechahasta' => $fechahasta , ':resultcount' => $resultcount    )   );
 
    
 $arr = $stmt->fetchAll(PDO::FETCH_ASSOC);
 
 
 $registros = json_encode(array('rest' => 1 , 'list' => $arr)   );
 
 if (count($arr) > 0)
   echo  $registros; 
 else
   echo  json_encode(array('rest' => 2  )  );     //vacio
      
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

 
 //subir puntaje 
 if ( $DeliveryD["pp"] == 2000   
     && isset( $DeliveryD["appid"]) && isset( $DeliveryD["apppass"])
     && isset( $DeliveryD["user"])  && isset( $DeliveryD["userpass"])
	 && isset( $DeliveryD["boardcode"]) && isset( $DeliveryD["score"] )
 )  
 {	 
  
   if (VerificarCredencialesAPP($DeliveryD["appid"], $DeliveryD["apppass"]  )   &&
	   VerificarCredencialesUSER($DeliveryD["appid"], $DeliveryD["user"], $DeliveryD["userpass"]) )	   
   {    
	BOARD_SCORE_UPLOAD($DeliveryD["appid"], $DeliveryD["boardcode"], $DeliveryD["user"], $DeliveryD["score"] );
   }
   
 }
 //=====================
 
 
  //descargar puntaje 
 if ( $DeliveryD["pp"] == 2100   
     && isset( $DeliveryD["appid"]) && isset( $DeliveryD["apppass"])
     &&  isset( $DeliveryD["boardcode"]) &&  isset( $DeliveryD["date1"])
	 &&  isset( $DeliveryD["date2"])    &&  isset( $DeliveryD["count"] )
 )  
 {	 
  
   if (VerificarCredencialesAPP($DeliveryD["appid"], $DeliveryD["apppass"]  )      )	   
   {    
	BOARD_SCORE_LIST($DeliveryD["appid"], $DeliveryD["boardcode"], 
	$DeliveryD["date1"], $DeliveryD["date2"], $DeliveryD["count"] );
   }
   
 }
 //=====================
 
 
 
}//if isset pp

 
  
?>