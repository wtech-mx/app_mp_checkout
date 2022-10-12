<?php

          // Devuelve 'inline-block' si el id se encuentra dentro de los privilegios
          // generales del sistema. 
		  function is_priv($aguja,$mod="css",$ids_con_priv=""){
		       if($mod=="css"){ $res="none"; }       
		       if($mod=="boolean"){ $res=false; } 
		       if( $ids_con_priv=="" && isset($_SESSION["ids_con_privilegio"]) ){ $ids_con_priv = $_SESSION["ids_con_privilegio"]; }

		       if( $ids_con_priv != "" ){
		           $vec=explode("|", $ids_con_priv );
		           if(in_array($aguja,$vec) ){
		                if($mod=="css"){ $res="inline-block"; }       
		                if($mod=="boolean"){ $res=true; }                 
		           }
		       } 
		       return $res;
		  }

		  //Aplica la función 'is_priv' pero en estilo booleano
		  function ban_priv($aguja=''){ return is_priv($aguja,'boolean'); }

		  //Devuelve el tiempo transcurrido desde la ultima venta 
		  function time_uv(){
                $minutos_validate=2;
                $retur="0";
                if(isset($_SESSION["ultVta"]) && isset($_SESSION["ultUsr"]) && is_priv('optValidDup')=="inline-block" ){
                     if(!isset($_POST['id_personal']) || (isset($_POST['id_personal']) && (int)$_SESSION["ultUsr"]==(int)$_POST['id_personal'])){
                        $trans=strtotime(date("Y-n-j H:i:s"))-strtotime($_SESSION["ultVta"]);
                        if( $trans < ($minutos_validate * 58) ){
                            $retur = number_format(((($minutos_validate * 58) - $trans) * 60)/58,0,".","");
                        }
                     } 
                }
                return $retur;		  	
		  }
?>