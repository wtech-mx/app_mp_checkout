<?php ini_set("session.gc_maxlifetime", 28800);ini_set("session.cookie_lifetime",28800); session_start();


      setlocale(LC_ALL,"es_ES@euro","es_ES","esp","es");  
      date_default_timezone_set("America/Mexico_City");

	  function noCac(){                              
		  return date("YmdHis");
	  }

	  function InArray($arr1,$arr2){
	  	    $ret=false;
	  		foreach($arr1 as $valor1){
	  			if($ret==false){
			  		foreach($arr2 as $valor2){ if( $valor1==$valor2 && trim($valor2) != "" ){ $ret=true; }	 }	
		  	    }
	  		}	
	  		return $ret;
	  }



      #----------------CONTROL DE PROFUNDIDAD----------------
      $PROF="../../";

      $_SESSION["tipo_viz"]=1;
      $_SESSION["msg_blk"]='';

      include_once($PROF."../core/data_base.php");
	  include_once($PROF."../core/libmenuvertical.php");    
	  $mnu=new MenuVertical();
	  include_once($PROF."../core/menuInventario.php");

	  //Obtiene configuracion de los menus y determinar información de los modulos cargados.
	  $arrMod=$mnu->getMods();     
	  $cantMod=$mnu->getNumMods(); 
	  $_SESSION["ban_acceso_autorizado"]="0";
	  $_SESSION["optFolio"]="idVenta";	
	  $_SESSION["color_Reservado"]="#F9E79F";
	  $_SESSION["color_Confirmado"]="#EDBB99";	 
	  $_SESSION["ids_select_clasific"]=""; 


        if(!isset($_POST['usuario']) || !isset($_POST['contra']) ){
		  echo "No se han recibido los datos para la autenticación"; 
		  exit(0);
		} else {

	            $usuario= $_POST['usuario']; 	
	            $contra= $_POST['contra']; 	


	            // ------ Verifica usuario en la base de datos --------

		        $coneccion=new sQuery();
		        $coneccion->executeQuery("CALL valida_user ('".$usuario."' , '".$contra."')");

		        if( $coneccion->getAffect()==1 ){

		            while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {

					    #----------------------------------------------
						#-------V A R I A B L E S   U S A D A S--------
						#----------------------------------------------

						//Seguridad
						$_SESSION["handel"]=$datos_text['handel']; 
						$_SESSION["id_empresa_base"]=$datos_text['id_empresa_base'];  
						$_SESSION["ID_PERSONAL"]=$datos_text['id_user']; 												
						$_SESSION["ids_con_privilegio"] = $datos_text['ids_privilegios'] . ( $datos_text['ids_privilegios_2'] != '' ? '|' . $datos_text['ids_privilegios_2'] : '' );
						$_SESSION["usuario_Sel"]=$datos_text['alias'];     
						$_SESSION["nombrePermiso"]=$datos_text['NombrePermiso'];
						$_SESSION["ids_select_clasific"]=$datos_text['ids_select_clasific'];									      

						//Pantalla Principal
						$_SESSION["nombreSucursal_Sel"]= utf8_encode($datos_text['nombreSucursal_Sel']);

		            };      
		            $coneccion->Close();

		            //------ Obtiene colores para reservaciones ----------
			        $coneccion=new sQuery();
			        $coneccion->executeQuery("select color_reservada,color_confirmada from tconfig_gral where handel='".$_SESSION["handel"]."'");
			        if( $coneccion->getAffect()==1 ){
			            while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {
						    $_SESSION["color_Reservado"]=$datos_text['color_reservada'];
							$_SESSION["color_Confirmado"]=$datos_text['color_confirmada'];
			            };
			        }         
			        $coneccion->Close();
			        
				    // ----- Verifica derechos de LICENCIA  ------ 
				    $suc_licencias="";
				    $con2=new sQuery();
				    $con2->executeQuery("select *,(select blk from tusuarios where id='".$_SESSION["ID_PERSONAL"]."') as blk,suc_licencias from tempresas_base where id=".$_SESSION["id_empresa_base"]);

				    $activa="NO";
				    $creditos="";
				    if( $con2->getAffect() == 1 ){
				        while ($datos_text = mysqli_fetch_array($con2->getResults())) {                                        
				            $activa=$datos_text['activa'];
				            $_SESSION["nombreEmpresa_Sel"]= utf8_encode($datos_text['nombre_empresa']); 
				            $creditos=$datos_text['creditos'];
				            $suc_licencias=$datos_text['suc_licencias'];
				        }
				    }
				    $con2->Close(); 

				    //Acceso a sucursal
				    if( $suc_licencias=="" || $suc_licencias=="all" ){ $suc_licencias=$_SESSION['handel']."|"; }
				    $vecAccSuc=explode("|", $suc_licencias);				    


				    //Si no tiene creditos no inicia sesion
				    if($creditos==""){
				    	$_SESSION["msg_blk"]="Estimado usuario, su licencia ha caducado. Para realizar la activación del sistema debe cargar su comprobante de pago.";
				       	/*echo "Estimado usuario, su licencia ha caducado. Para dar soluci&oacute;n al problema, p&oacute;ngase en contacto con el &aacute;rea de soporte."; 
				        unset($_SESSION['handel']); 
				        session_destroy(); 
				        exit(0);*/
				    }


				    //Empresa activa
				    if($activa != "SI"){  
				       	echo "El usuario '".$usuario."' no se encuentra activo. Para dar soluci&oacute;n al problema, p&oacute;ngase en contacto con el &aacute;rea de soporte."; 
				        unset($_SESSION['handel']); 
				        session_destroy(); 
				        exit(0);   
				    }	


				    // ---------------------------------------------------------------------------------------------            
				    //                              VERIFICA SI TIENE CREDITOS PARA EL MES ACTUAL            
				    // ---------------------------------------------------------------------------------------------

 					//Verifica si existe el registro de mensajes de vencimiento
 					$con2=new sQuery();
					$con2->executeQuery("select ultima_fecha,intentos from tmensajes_vencimiento where handel='".$_SESSION["handel"]."'");

					$ultima_fecha=date("Y-m-d");
					$intentos=0;
					if( $con2->getAffect() == 1 ){
					    while ($datos_text = mysqli_fetch_array($con2->getResults())) {                                        
							$ultima_fecha=$datos_text['ultima_fecha'];
							$intentos=(int)$datos_text['intentos'];							
					    }
					    $con2->Close();
					} else {
						$con2->Close();

	 					$con2=new sQuery();
						$con2->executeQuery("insert into tmensajes_vencimiento(id_empresa_base,handel,ultima_fecha,intentos) values ('".$_SESSION['id_empresa_base']."','".$_SESSION['handel']."','".$ultima_fecha."','".$intentos."')");
					    $con2->Close();
				    }

				    //Credito suficiente
				    if(((strpos($creditos, "[".date ('Y')."/".date ('m')."]")==false && strpos($creditos, "[".date ('Y')."/".date ('m')."]")."" != "0") || !in_array($_SESSION['handel'], $vecAccSuc)) && $creditos != "Total" ){

				    	if(is_priv('optBlkCaduci_ID')=="inline-block"){
				            $_SESSION["msg_blk"]="Estimado usuario, su licencia mensual ha caducado. Para realizar la activación del sistema debe cargar su comprobante de pago.";
				        }
						
				    } else {
				        if($intentos > 0){
		 				    $con2=new sQuery();
							$con2->executeQuery("update tmensajes_vencimiento set ultima_fecha=now(),intentos='0' where handel='".$_SESSION["handel"]."'");
							$con2->Close();				                		
				       	}
				    }					    

				    // ---------------------------------------------------------------------------------------------            
				    //                              VERIFICA SI TIENE OTROS ADEUDOS PENDIENTES           
				    // ---------------------------------------------------------------------------------------------

 					//Obtiene datos de la deuda mas proxima
 					$fecha_Adeudo="";
 					$msg01="";
 					$msg02="";
 					$con2=new sQuery();
					$con2->executeQuery("SELECT fecha,msg01,msg02 FROM tpagos_anuales WHERE chk='0' and ((id_empresa_base='".$_SESSION["id_empresa_base"]."' and handel='".$_SESSION["handel"]."') or (id_empresa_base='".$_SESSION["id_empresa_base"]."' and handel='-1')) order by fecha asc limit 1");

					if( $con2->getAffect() == 1 ){
					    while ($datos_text = mysqli_fetch_array($con2->getResults())) {                                        
		 					$fecha_Adeudo=$datos_text['fecha'];
		 					$msg01=$datos_text['msg01'];
		 					$msg02=$datos_text['msg02'];				
					    }
					}
					$con2->Close();

					//Si existe un adeudo, obtiene la vigencia
					if($fecha_Adeudo != ""){
                        $datetime1 = new DateTime(date("Y-m-d"));
                        $datetime2 = new DateTime($fecha_Adeudo);
                        $interval = $datetime1->diff($datetime2);
                        $diferencia= $interval->format('%R').$interval->format('%a');                                    

                        $msg01=str_replace("{anio}", date("Y",strtotime($fecha_Adeudo)), $msg01);
                        $msg02=str_replace("{anio}", date("Y",strtotime($fecha_Adeudo)), $msg02);

                        $msg01=str_replace("{mes}", date("m",strtotime($fecha_Adeudo)), $msg01);
                        $msg02=str_replace("{mes}", date("m",strtotime($fecha_Adeudo)), $msg02);

                        $msg01=str_replace("{dia}", date("d",strtotime($fecha_Adeudo)), $msg01);
                        $msg02=str_replace("{dia}", date("d",strtotime($fecha_Adeudo)), $msg02);

                        $msg01=str_replace("{fecha}", date("d-m-Y",strtotime($fecha_Adeudo)), $msg01);
                        $msg02=str_replace("{fecha}", date("d-m-Y",strtotime($fecha_Adeudo)), $msg02);

                        //Proximo a vencer
                        if( (int)$diferencia > 0 && (int)$diferencia <= 5 ){
                           	$_SESSION["msg_blk"]=$msg01;
                        }                                   
					}

					//Verifica si tiene privilegios para consultar los modulos
					if( !is_priv('subReportesFinancieros_ID','boolean') && !is_priv('subPuntoVenta_ID','boolean') && !is_priv('mnuInicio_ID','boolean') ){
						echo "El usuario '".$_POST['usuario']."' no tiene acceso a esta sección del sistema.";
						unset($_SESSION['handel']); 
						session_destroy(); 
						exit(0);  						
					}

					$_SESSION["handel_select"]=$_SESSION["handel"];
					$_SESSION["msg_blk"]=utf8_encode($_SESSION["msg_blk"]);

					echo "1";
		                          
		        } else {
		            echo "El Usuario y/o contraseña son incorrectos.";
		            $coneccion->Close();
		            exit(0);
		        }	      
				          

	    }