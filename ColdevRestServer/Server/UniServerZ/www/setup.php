<?php  
/*

   COLDEV REST SERVER (c)  COLOMBIAN DEVELOPERS
   
   ===   MIT LICENSE  ===

   
   
   
  >> John 1:12  (Jesus Christ Lord and Savior)
   
   Yet to all who did receive him, to those who believed in his name,
   he gave the right to become children of God <<<


*/  

$GLOBALS['my_pdo_connection'] = 'sqlite:db/data.db';



if (isset($_POST["user"]))  //fix user name in uppercase
  $_POST["user"] = trim(strtoupper($_POST["user"] ));







function SQLITEexecSQL($cadenaSQL , $arrayCampos)
{

  try
  {
   $db = new PDO( $GLOBALS['my_pdo_connection']   );
   $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
   
   $stmt = $db->prepare($cadenaSQL);
   $stmt->execute($arrayCampos);           
   
   return $stmt;
  }
  catch(PDOException $e)
  {
    $error_msg= 'Error : '.$e->getMessage(); 

    echo  json_encode(array('rest' => 0, 'error_msg' => $error_msg ) ); 
    exit();
  }  
    
}
 
 
 
 
 
 function Login_Insert_Record($appid , $user)
 {
    $arreglo = array(':appid' => $appid , ':user' => $user );
 
    SQLITEexecSQL('DELETE FROM player_login WHERE appid = :appid AND   user = :user  ', $arreglo);//BORRA ANTERIOR
    
    SQLITEexecSQL('INSERT INTO player_login(appid,  user ) VALUES(:appid,  :user )   ', $arreglo);        
 }
 
 
 
 
 
 function VerificarCredencialesAPP($appid, $pass)
 {
  $clave = hash('sha256', $pass);	  
	 
  $stmt = SQLITEexecSQL('SELECT * FROM  apps 
            WHERE appid = :appid AND pass = :pass ', 
            
            array(':appid' => $appid, ':pass' => $clave   )   ); 
    
  $arr = $stmt->fetchAll(PDO::FETCH_ASSOC);
  
  foreach ($arr as $titleData) 
  { 
    return true; 
  }

  echo  json_encode(array('rest' => -2 )  ); 
  exit();  
 }
 
 
 
 
 
 
 
  function VerificarCredencialesUSER($appid, $user, $pass)
 {
  $clave = hash('sha256', $pass);	 
	 
  $stmt = SQLITEexecSQL('SELECT * FROM  player 
            WHERE user = :user AND pass = :pass AND
				  appid = :appid	', 
            
            array(':appid' => $appid, ':user' => $user, ':pass' => $clave   )   ); 
    
  $arr = $stmt->fetchAll(PDO::FETCH_ASSOC);
  
  foreach ($arr as $titleData) 
  { 
    return true; 
  }

  echo  json_encode(array('rest' => -3 )  ); 
  exit();  
 }
 
 
 
 
 
 
 
 function GetRandomString($length)
 {  
    $randomBytes = openssl_random_pseudo_bytes($length);
    $characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    $charactersLength = strlen($characters);
    $result = '';
    for ($i = 0; $i < $length; $i++)
        $result .= $characters[ord($randomBytes[$i]) % $charactersLength];	 
	
	return  $result;
 }
  
 
  
?>