<?php  
  
require "setup.php" ;

 if (!isset( $_GET['pass'] ) )   exit();  



$clave =     $_GET['pass'];

if (  $clave != '123445ssd'    )     exit();  
   
   
   

function FIX_DB(  )
{     
   SQLITEexecSQL('VACUUM ',
              array( )
              );  //mantenimiento
   
   echo 'Mantenimiento OK';
    
      
   exit();
        
}

FIX_DB(  );


  
?>