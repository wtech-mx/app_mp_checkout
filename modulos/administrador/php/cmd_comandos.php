<?php ob_start(); ini_set("session.gc_maxlifetime", 28800);ini_set("session.cookie_lifetime",28800); session_start();

if( !isset( $_POST['index'] ) ){ echo "No se recibieron los datos para la operación"; exit(0); }
            
            $PROF="../../../";

            setlocale(LC_ALL,"es_ES@euro","es_ES","esp","es");  
            date_default_timezone_set("America/Mexico_City");   

            include_once($PROF."../core/conexion_data_base.php");  
            include_once($PROF."../core/funciones_privilegios.php"); 


            //Valida que la sucursal seleccionada sea correcta
            if(isset($_POST["handel"])){
                include_once($PROF.'../app/recursos/php/getStrSucursales.php');
                if(!isHandelValid($_POST["handel"],false)) die('* Sucursal Incorrecta.');
            }             

switch ($_POST['index']) {
   case 0:  //--------- ACTUALIZA SELECCION DE SUCURSAL ----------  

            $_SESSION["handel_select"]=$_POST["handel"];

            echo "1";
   break;       
   case 1:  //--------- RETORNA LISTADO DE CORTES DE CAJA ----------
            include_once($PROF."../v2/.ht-model/.ht-cortes_caja.php");             
            $corte = new cortes_caja();              

            $corte->setHandel( $_POST["handel"] );
            if(isset($_SESSION["ids_select_clasific"]) && $_SESSION["ids_select_clasific"] != ""){ 
                $corte->setListClasific($_SESSION["ids_select_clasific"]); 
                $corte->setOnlySalesExist(true);  //Mostrar solo registros que contienen ventas
            } 

            //Limitar consulta consulta a registros de 1mes de antiguedad
            $corte->set1MesAntiguedad( is_priv('opt1MesAntig','boolean') );

            if( !$corte->ReadListCortes( $_POST["mostrar"]) ){
                echo "<center><h4>* No existen resultados para mostrar.</h4></center>";
            } else {
                $resp="";
                foreach ($corte->getListCortes() as $key => $datos_text) {

                    if($corte->getBanClasif()){
                       $total=$datos_text["total_ventas"];
                    } else {
                       $total=$datos_text["importe_reportado"];
                    }                    

                    $resp.="<tr class='OpenCorte' data-id='".$datos_text["id"]."'>
                      <td>".utf8_encode($datos_text["apertura"])."</td>
                      <td>".utf8_encode($datos_text["cierre"])."</td>
                      <td style='text-align:right'>$ ".number_format($total,2,".",",")."</td>";
                      if(is_priv('optViSobresDin','boolean')) $resp.="<td style='text-align:right'>$ ".number_format($datos_text["sobre"],2,".",",")."</td>";
                    $resp.="</tr>";
                }

                //Personaliza encabezados
                if($corte->getBanClasif()){ $lblHead="Venta Total"; } else { $lblHead="Fondo Final"; }

                echo "<table class='table table-striped table-hover'>
                        <thead>
                            <tr>
                                <th scope='col'>Apertura</th>
                                <th scope='col'>Cierre</th>
                                <th scope='col' style='text-align:right;'>".$lblHead."</th>
                                " . (is_priv('optViSobresDin','boolean') ? "<th scope='col' style='text-align:right;'>Sobre</th>" : '' ) . "
                            </tr>
                        </thead>
                        <tbody>".$resp."</tbody>
                      </table>";

            }

      break;     
   case 2:  //--------- RETORNA LISTADO DE CUENTAS COBRADAS ----------
            $resp=""; 
            $indce=1;

            //Consulta limitada a algunas clasificaciones de servicios o productos
            $clasF="";
            if(isset($_SESSION["ids_select_clasific"]) && $_SESSION["ids_select_clasific"] != ""){
               $vecTip=explode("|", $_SESSION["ids_select_clasific"]);
               if( count($vecTip) > 1 ){                   
                   for ($i=0; $i < count($vecTip); $i++) { 
                      if($vecTip[$i] != ""){
                         if($clasF != ""){ $clasF.=","; }
                         $clasF.="'".$vecTip[$i]."'";
                      }
                   }
                   if($clasF != ""){ $clasF=" and t7.text_clasificacion in (".$clasF.")"; }
               }
            }

            $vecTotales['efectivo']=0.0;
            $vecTotales['tarjeta']=0.0;
            $vecTotales['transferencia']=0.0;
            $vecTotales['deposito']=0.0;
            $vecTotales['credito']=0.0;
            $vecTotales['apartado']=0.0;
            $vecTotales['puntos']=0.0;

            //Regresa totales en forma de pago
            function prepFP($title_fp){
                 global $vecTotales,$datos_text;
                 $vecTotales[$title_fp]+=(float)$datos_text[$title_fp]; 
                return "<tr><td>".strtoupper(substr($title_fp, 0,2))."</td><td>&nbsp;&nbsp;:&nbsp;&nbsp;</td><td>".number_format((float)$datos_text[$title_fp],2,'.',',')."</td></tr>";
            }


            //Limitar consulta consulta a registros de 1mes de antiguedad
            if(is_priv('opt1MesAntig','boolean')) $clasF.= " and t1.fecha >= '".date('Y-m', strtotime('-1 month')) . "-01' ";

            //Listado de Formas de pago
            $fps=['efectivo','tarjeta','transferencia','deposito','credito','apartado','puntos'];


            $con=new sQuery();
            $con->executeQuery("select t1.id as id_agenda,t1.notas,t1.notas2,t1.folio as folio,concat(DATE_FORMAT(t1.fecha,'%d-%m-%Y'),'&nbsp;&nbsp;&nbsp;<b><font size=2 color=#17202A>',t1.hora,'</font></b>') as fecha,t4.nombrecto as cliente,t4.tel1,t3.alias as atendio,t2.alias as cobro,t1.efectivo as efectivo,t1.tarjeta as tarjeta,t1.transferencia as transferencia,t1.deposito as deposito,t1.credito as credito,t1.apartado as apartado,t1.puntos as puntos,t1.total as total,t5.nombreSucursal_Sel,(SELECT group_concat(tu.cantidad,' | ',pro.nombre,' | ',tu.costo  SEPARATOR ' || ') FROM tagenda_aux tu,tproductos pro WHERE tu.id_agenda=t1.id and tu.id_producto_servicio=pro.id) as desc_item,t1.propina_ta from tagenda t1, tusuarios t2,tusuarios t3,tclientes t4, tempresas t5, tcajas_abri t8,tagenda_aux t6, tproductos t7 where t1.id_autentica=t2.id and t1.id_personal=t3.id and t1.id_cliente=t4.id and t1.status='Cobrado' and t5.handel=t1.handel and t1.id_caja=t8.id and t1.handel='".$_POST["handel"]."' and t1.fecha='".date("Y/m/d",strtotime(str_replace("/", "-", $_POST["fecha"])))."' and t6.id_agenda=t1.id and t6.id_producto_servicio=t7.id".$clasF." group by t1.id order by t1.fecha asc,t1.hora asc");

            if( $con->getAffect() >= 1 ){
                while ($datos_text = mysqli_fetch_array($con->getResults())) {   

                    //Prepara comentario
                    $comentario=$datos_text["notas"];
                    if( $datos_text["notas2"] != "" ){ $comentario.=" ".$datos_text["notas2"]; }
                    if(trim($comentario) != ""){$comentario='<tr><td><label>COMENTARIO</label></td><td>:</td><td><font color="#1E8449">'.utf8_encode($comentario).'</font></td></tr>';}    

                    //Separa lista de servicios incluidos
                    $aux=explode(" || ", utf8_encode($datos_text["desc_item"]));
                    $detall="";
                    for ($i=0; $i < count($aux) ; $i++) { 
                       if($aux[$i] != ""){
                           $aux2=explode(" | ", $aux[$i]);
                           $detall.="<tr>";
                           $detall.="<td style='width:10%;'>".number_format($aux2[0],2,".",",")."</td>";
                           $detall.="<td style='width:60%;'>".( $aux2[1]=='{Descuento}' ? '<font color="red">Descuento</font>' : $aux2[1])."</td>";
                           $detall.="<td style='width:10%; text-align:right;'>".number_format($aux2[2],2,".",",")."</td>";
                           $detall.="<td style='width:20%; text-align:right;'>".number_format($aux2[0] * $aux2[2],2,".",",")."</td>";
                           $detall.="</tr>";
                       }
                    }       

                    //Sumatorias de Formas de Pago
                    $fp="";
                    foreach ($fps as $key => $etiq){ if((float)$datos_text[$etiq] > 0.0) $fp.=prepFP($etiq); }


                    /*if((float)$datos_text["tarjeta"] > 0.0){ $vecTotales['tarjeta']+=(float)$datos_text["tarjeta"]; $logoFp.='<img src="img/credit-card.png">'; if($fp != ""){ $fp.=", "; } $fp.="TA"; }
                    if((float)$datos_text["transferencia"] > 0.0){ $vecTotales['transferencia']+=(float)$datos_text["transferencia"]; $logoFp.='<img src="img/bank.png">'; if($fp != ""){ $fp.=", "; } $fp.="TR"; }
                    if((float)$datos_text["deposito"] > 0.0){ $vecTotales['deposito']+=(float)$datos_text["deposito"]; $logoFp.='<img src="img/bank.png">'; if($fp != ""){ $fp.=", "; } $fp.="DE"; }
                    if((float)$datos_text["credito"] > 0.0){ $vecTotales['credito']+=(float)$datos_text["credito"]; if($fp != ""){ $fp.=", "; } $fp.="CR"; }
                    if((float)$datos_text["apartado"] > 0.0){ $vecTotales['apartado']+=(float)$datos_text["apartado"]; if($fp != ""){ $fp.=", "; } $fp.="AP"; }
                    if((float)$datos_text["puntos"] > 0.0){ $vecTotales['puntos']+=(float)$datos_text["puntos"]; $logoFp.='<img src="img/ticket.png">'; if($fp != ""){ $fp.=", "; } $fp.="PU"; }
                    */

                    $tel1 = (strlen($datos_text["tel1"]) >= 10) ? '<br>Tel: <a href="tel: +52'.str_replace(array('(',')',' ','-'), array('','','',''), $datos_text["tel1"]).'">'.$datos_text["tel1"].'</a>' : '' ;

                    $propina_ta = (float)$datos_text["propina_ta"] > 0 ? '<tr><td><label>PROPINA</label></td><td>:</td><td>'.number_format($datos_text["propina_ta"],2,".",",").'</td></tr>' : '';

                    $resp.='<div class="opCtasCob">
                              <table style="width:100%;">
                                    <tr>
                                        <td><label>#</label></td>
                                        <td>:</td>
                                        <td><b>'.$indce." de ".$con->getAffect().'</b></td>
                                        <td class="totalCc" rowspan="6" style="width:60px; text-align:center;">
                                             <table>'.$fp.'</table>
                                        </td>                                    
                                    </tr>                     
                                    <tr>
                                        <td><label>ID</label></td>
                                        <td>:</td>
                                        <td>'.$datos_text["id_agenda"].'</td>
                                    </tr>
                                    <tr>
                                        <td><label>FECHA</label></td>
                                        <td>:</td>
                                        <td>'.$datos_text["fecha"].'</td>
                                    </tr> 
                                    <tr>
                                        <td><label>CLIENTE</label></td>
                                        <td>:</td>
                                        <td>'.utf8_encode($datos_text["cliente"]).$tel1.'</td>
                                    </tr>                                    
                                    <tr>
                                        <td><label>ATENDIO</label></td>
                                        <td>:</td>
                                        <td>'.utf8_encode($datos_text["atendio"]).'</td>
                                    </tr>
                                    <tr>
                                        <td><label>COBRO</label></td>
                                        <td>:</td>
                                        <td>'.utf8_encode($datos_text["cobro"]).'</td>
                                    </tr>                                                                           
                                    '.$propina_ta.$comentario.'                                  
                              </table><br>     
                              <table class="tabDetalles" style="width:100%"><tr><th>Cant.</th><th>Concepto</th><th style="text-align:right;">Precio</th><th style="text-align:right;">Total</th></tr>'.$detall.'</table>
                              <label class="opt-totales">$&nbsp;'.number_format($datos_text['total'],2,".",",").'</label>
                            </div>';
                            $indce++;
                }
            }
            $con->Close(); 


            if($resp != ""){
                echo "<center><br><table id='tabTotales'>";
                if((float)$vecTotales['efectivo'] > 0) echo "<tr><td>EFECTIVO:</td><td style='width:100px;'>".number_format($vecTotales['efectivo'],2,".",",")."</td></tr>";
                if((float)$vecTotales['tarjeta'] > 0) echo "<tr><td>TARJETA:</td><td>".number_format($vecTotales['tarjeta'],2,".",",")."</td></tr>";
                if((float)$vecTotales['transferencia'] > 0) echo "<tr><td>TRANSFERENCIA:</td><td>".number_format($vecTotales['transferencia'],2,".",",")."</td></tr>";
                if((float)$vecTotales['deposito'] > 0) echo "<tr><td>DEPOSITO:</td><td>".number_format($vecTotales['deposito'],2,".",",")."</td></tr>";
                if((float)$vecTotales['credito'] > 0) echo "<tr><td>CRÉDITO:</td><td>".number_format($vecTotales['credito'],2,".",",")."</td></tr>";
                if((float)$vecTotales['apartado'] > 0) echo "<tr><td>S.APARTADO:</td><td>".number_format($vecTotales['apartado'],2,".",",")."</td></tr>";
                if((float)$vecTotales['puntos'] > 0) echo "<tr><td>PUNTOS:</td><td>".number_format($vecTotales['puntos'],2,".",",")."</td></tr>";
                echo "<tr><td>TOTAL:</td>
                          <td style='border-top:1px solid black;'><b>".number_format($vecTotales['efectivo'] + $vecTotales['tarjeta']  + $vecTotales['transferencia'] + $vecTotales['deposito'] + $vecTotales['credito'] + $vecTotales['apartado'] + $vecTotales['puntos'],2,".",",")."</b></td>
                      </tr></table></center><br><br>";
                echo $resp;
                echo "<div style='clear:both; height:6em;'></div>";
            } else {
                echo "<center><h4>* No existen resultados para mostrar.</h4></center>";
            }            

      break; 
   case 3:  //--------- RETORNA LISTADO DE CITAS EN CALENDARIO ----------

            $horaSel="";
            $hs="";
            $resp=""; 
            $indce=1;
            $con=new sQuery();
            $con->executeQuery("SELECT ag.id as id_agenda,ag.status,ag.notas,ag.notas2,ag.fecha,ag.hora,tc.nombrecto as cliente,(select nombrecto from tusuarios where id=ag.id_personal) as personal, tc.tel1, (SELECT group_concat(tu.cantidad,'/',pro.nombre,'/',tu.costo SEPARATOR '|') FROM tagenda_aux tu,tproductos pro WHERE tu.id_agenda=ag.id and tu.id_producto_servicio=pro.id) as desc_item FROM tagenda ag,tclientes tc WHERE ag.handel='".$_POST["handel"]."' and ag.fecha='".date("Y/m/d",strtotime(str_replace("/", "-", $_POST["fecha"])))."' and ag.spacio >=0 and ag.status in ('Reservado') and ag.id_cliente=tc.id order by ag.hora asc, ag.spacio asc");

            if( $con->getAffect() >= 1 ){
                while ($datos_text = mysqli_fetch_array($con->getResults())) {  

                    $aux=explode(":", $datos_text["hora"]);
                    $hs=$aux[0];
                    $separaDor="";

                    if($horaSel=="" || $horaSel != $hs ){
                       $separaDor="<div class='separadorHorario'>".date("g:i a", strtotime($hs.":00:00"))."</div>"; 
                       $horaSel=$hs;
                    }
                    

                    $color_cuadro="";
                    if($datos_text["status"]=="Reservado"){ $color_cuadro='background-color:'.$_SESSION["color_Reservado"].';'; }
                    if($datos_text["status"]=="Confirmado"){ $color_cuadro='background-color:'.$_SESSION["color_Confirmado"].';'; }
                    
                    //Determina si el cliente tiene numero de telefono
                    $tel1="";
                    if($datos_text["tel1"] != ""){
                        $telLnk=str_replace(array("(",")"," ","-"), array("","","",""), $datos_text["tel1"]);
                        $tel1='<a href="tel:+52'.$telLnk.'" class="TelCte">'.utf8_encode($datos_text["tel1"]).'</a>';
                    }

                    //Incluye nombre de empleado
                    $personal="";
                    if($datos_text["personal"] != ""){
                      $personal='Atiende: <label class="nombPersonal">'.utf8_encode($datos_text["personal"]).'</label>';
                    }


                    //Obtiene detalles de los servicios
                    $aux=explode("|", utf8_encode($datos_text["desc_item"]));
                    $detall="";
                    for ($i=0; $i < count($aux) ; $i++) { 
                       if($aux[$i] != ""){
                           $aux2=explode("/", $aux[$i]);
                           $detall.="<tr>";
                           $detall.="<td style='width:10%;'>".$aux2[0]."</td>";
                           $detall.="<td style='width:50%; text-align:left;'>".$aux2[1]."</td>";
                           $detall.="<td style='width:10%; text-align:right;'>".number_format($aux2[2],2,".",",")."</td>";
                           $detall.="</tr>";
                       }
                    } 
                    if($detall != ""){
                        $detall="<hr><table class='tabDetAgenda' style='width:100%'>".$detall."</table>";
                    }

                    //Determinar si existen comentarios
                    $comentariox="";
                    if($datos_text["notas"] != ""){ $comentariox=utf8_encode($datos_text["notas"]); }
                    if($datos_text["notas2"] != ""){ if($comentariox != ""){ $comentariox.=", "; } $comentariox.= utf8_encode($datos_text["notas2"]); }
                    if($comentariox != ""){ 
                       $comentariox='<label class="comentarioAgenda">'.$comentariox.'</label>'; 
                    }

                    $resp.=$separaDor.'<div class="opAgenda" style="'.$color_cuadro.'">
                                <label class="horaCita">'.date("g:i a", strtotime($datos_text["hora"].":00")).'</label>
                                <label class="idAgenda">'.$datos_text["id_agenda"].'</label>
                                <label class="NombCte">'.utf8_encode($datos_text["cliente"]).'</label>
                                '.$tel1.'
                                '.$comentariox.'
                                '.$personal.'
                                '.$detall.'
                            </div>';
                            $indce++;
                }
            }
            $con->Close(); 

            if($resp != ""){
                echo $resp;
            } else {
                echo "<center><h4>* No existen resultados para mostrar.</h4></center>";
            } 
            echo "<div style='clear:both'></div>";           

      break;   
   case 4:  //--------- OBTIENE ID DEL ÚLTIMO CORTE ----------

      //Obtiene el id del ultimo corte de caja
         $id_ultimo_corte="";
         $coneccion=new sQuery();
         $coneccion->executeQuery("select (select id from tcajas_abri where handel='".$_POST["handel"]."' and status='Cerrada' order by id desc limit 1) as ultimo_corte,(select id from tcajas_abri where handel='".$_POST["handel"]."' and status='Abierta' order by id desc limit 1) as caja_abierta");
         if( $coneccion->getAffect()==1 ){   
                while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {
                  if( $datos_text["caja_abierta"] == "" ){ $id_ultimo_corte = $datos_text["ultimo_corte"]; }                  
                }         
         }   
         $coneccion->Close();  

         echo $id_ultimo_corte;        

      break;                                                                               
   default:
         echo "Comando no reconocido ".$_POST['index'];
      break;
}