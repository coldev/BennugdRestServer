<?php  
  
 


 function APP_CREATE($appid, $pass, $email  )
{     
  //existe app?
  
  $stmt = SQLITEexecSQL('SELECT * FROM  apps 
            WHERE appid = :appid  ', 
            
            array(':appid' => $appid   )   ); 
    
  $arr = $stmt->fetchAll(PDO::FETCH_ASSOC);
  
  foreach ($arr as $titleData) 
  { 
    echo  json_encode(array('rest' => -1 ) );
    exit(); 
  } 




    //ingresar app ---------

    $clave = hash('sha256', $pass);

    $stmt = SQLITEexecSQL('INSERT INTO apps(appid, pass, email) 
     				VALUES(:appid, :pass, :email)', 
            array(':appid' => $appid , ':pass' => $clave,  ':email' => $email 
              )   );
    
    if ( $stmt->rowCount() > 0)     
     echo  json_encode(array('rest' => 1 ) ); 
    else
     echo  json_encode(array('rest' => 0 ) ); 
      
      
   exit();
        
}









//====================================================================
//====================================================================
//====================================================================


if (isset( $_POST["pp"] ) || isset( $_GET["pp"] )  )
{
  $DeliveryD = null;  

  if (isset( $_POST["pp"] )  )   $DeliveryD = $_POST;
  if (isset( $_GET["pp"] )  )    $DeliveryD = $_GET;


 if ( $DeliveryD["pp"] == 1000 
     && isset( $DeliveryD["appid"]) && isset( $DeliveryD["pass"])
     &&  isset( $DeliveryD["email"]) 
 ) 
 {	 
    APP_CREATE($DeliveryD["appid"], $DeliveryD["pass"], $DeliveryD["email"]  );
 }
 
 
}
 
  
?>