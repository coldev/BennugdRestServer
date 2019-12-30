/*
   ARRAY - Example
	 
	
*/



 import "BennuWebServices"


 



type Items2D   //paquete personalizado         
	int x;	
	int y;   
	int cod_item; 
end
 

type Mapa2D   //paquete personalizado         
	int x;	
	int y; 
    string nombre;	
	Items2D itemsMapa[50][50]; 
	Items2D itemsMapa2[50][50]; 
	
end






private
   
    //binario 
	Mapa2D mimapa;
	Mapa2D pointer mapatemp;
   
    
	//arreglos
	int arreglo_enteros, item_entero;
	
	int arreglo_float, item_float;
	
	int arreglo_string, item_string;
	
	int arreglo_binario, item_binario;
	
	
	
begin
	Set_mode(800,600,32);
	set_fps(60,0);	
	
	
	
	
	//ARRAYS enteros... 
	
	arreglo_enteros = json_array_new();
	
	item_entero= json_integer(777);	
	json_array_append(arreglo_enteros, item_entero); //inserta un entero
	
	item_entero= json_integer(222);	
	json_array_append(arreglo_enteros, item_entero);//inserta un entero
		
    item_entero= json_array_get(arreglo_enteros, 0);//obtiene el primer elemento del array 
		
	write(0,5,50,0,"el arreglo de enteros contiene  " 
	   +itoa(json_array_size(arreglo_enteros)) +" elementos .. " +
	  " el primer elemento es " + itoa( json_int_get(item_entero) )
	  );
	   
  
  
  
  
 	 
 	//ARRAYS floats... 
	
	arreglo_float = json_array_new();
	
	item_float= json_float(77.79);	
	json_array_append(arreglo_float, item_float); //inserta un float
	
	item_float= json_float(22.2);	
	json_array_append(arreglo_float, item_float);//inserta un float
		   
    item_float= json_array_get(arreglo_float, 0);//obtiene el primer elemento del array 
		
	write(0,5,60,0,"el arreglo de floats contiene  " 
	   +itoa(json_array_size(arreglo_float)) +" elementos .. " +
	  " el primer elemento es " + ftoa( json_float_get(item_float) )
	  );  
	  
	  
	json_array_remove(arreglo_float, 1); //borra segundo
	
	write(0,5,70,0,"Quedan elementos despues de borrar el item segundo : "+
	     itoa(json_array_size(arreglo_float)) );  

	json_array_clear(arreglo_float); //borra todos
		 
		 
	write(0,5,80,0,"Quedan elementos despues de borrar todos : "+
	     itoa(json_array_size(arreglo_float)) );  
		 
	
	
	



	//ARRAYS string... 
	
	arreglo_string = json_array_new();
	
	item_string= json_string("UNO");	
	json_array_append(arreglo_string, item_string); //inserta un str
	
	item_string= json_string("DOS");	
	json_array_append(arreglo_string, item_string);//inserta un str
	
	item_string= json_string("TRES");
	json_array_insert(arreglo_string,0 ,item_string);//inserta un str en la primera pos 
	
		
    item_string= json_array_get(arreglo_string, 0);//obtiene el primer elemento del array 
		
	write(0,5,90,0,"el arreglo de strings contiene  " 
	   +itoa(json_array_size(arreglo_string)) +" elementos .. " +
	  " el primer elemento es " +   json_string_get(item_string) 
	  );
	

	
	
	
	
	
	//ARRAYS de datos binarios... 
	
	arreglo_binario = json_array_new();
	
	mimapa.x = 50;
	mimapa.y=  90;
	
	item_binario= json_binary(&mimapa, sizeof(mimapa)   );	
	json_array_append(arreglo_binario, item_binario); //inserta un bin


	mimapa.x = 390;
	mimapa.y=  100;
	
	item_binario= json_binary(mimapa, sizeof(mimapa)   );	
	json_array_append(arreglo_binario, item_binario); //inserta un bin


	mimapa.x = 220;
	mimapa.y=  10;
	
	item_binario= json_binary(mimapa, sizeof(mimapa)   );	
	json_array_append(arreglo_binario, item_binario); //inserta un bin

	

	mimapa.x = 3;
	mimapa.y=  1;
	
	item_binario= json_binary(mimapa, sizeof(mimapa)   );	
	json_array_set(arreglo_binario,1, item_binario); //modifica un bin en la 2da pos
	

	mimapa.x = 222;
	mimapa.y=  111;
	
	item_binario= json_binary(mimapa, sizeof(mimapa)   );		
	json_array_insert(arreglo_binario,0 ,item_binario);//inserta un bin en la primera pos 

	
 		
    item_binario= json_array_get(arreglo_binario, 0);//obtiene el primer elemento del array 
	
    mapatemp=  json_binary_get(item_binario);
	  
	
	write(0,5,100,0,"el arreglo de binarios contiene  " 
	   +itoa(json_array_size(arreglo_binario)) +" elementos .. " +
	   " el primer elemento es x "+ itoa(mapatemp.x) +
	   " y "+ itoa(mapatemp.y)
	
	  );

	
	
	loop
		frame;
	end
end










function json_binary( pointer data, int tamano_data)
private 
   string base64_binaries_cod;
   int item_string;
   
begin 
    base64_binaries_cod= base64_encode(data, tamano_data);
	
	item_string= json_string(base64_binaries_cod);
	
	return (item_string);    
end


 
 
 
 
function json_binary_get( int item_binario )
private 
   string base64_binaries_cod;
    
   int longitud_retorno;
   
    pointer retorno;
   
begin 
    base64_binaries_cod= json_string_get(item_binario);    

   retorno= base64_decode(base64_binaries_cod, &longitud_retorno);		 
	
	return (retorno);    
end 
	