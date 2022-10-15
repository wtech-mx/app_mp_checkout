<?php ob_start(); ini_set("session.gc_maxlifetime", 28800);ini_set("session.cookie_lifetime",28800); session_start();

$PROF='../../../';

if( !isset( $_POST['index'] ) ){ echo "No se recibieron los datos para la operación"; exit(0); }

            setlocale(LC_ALL,"es_ES@euro","es_ES","esp","es");
            date_default_timezone_set("America/Mexico_City");

            $mesA=array("","Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");

            include_once("../../../core/conexion_data_base.php");

            //Retorna color en base a nombre de status
            function StatColor($status){
                switch ($status) {
                    case 'Pendiente': return '#D8D8D8'; break;
                    case 'Comprobante Cargado': return '#FE9A2E'; break;
                    case 'Pago Incorrecto': return 'red'; break;
                    case 'Pagado': return '#04B404'; break;
                    case 'Proximo Mes': return '#FA58D0'; break;
                }
            }

            //Retorna una lista de Sucursales a las que el usuario tiene derecho a entrar
            function HandelsUser(){
                $ids_cambio_sucursal="";
                $coneccion=new sQuery();
                $coneccion->executeQuery("select ids_cambio_sucursal from tusuarios where id='".$_SESSION["ID_PERSONAL"]."'");
                if( $coneccion->getAffect() > 0 ){ while ($datos_text = mysqli_fetch_array($coneccion->getResults())) { $ids_cambio_sucursal=$datos_text["ids_cambio_sucursal"]; }}
                $coneccion->Close();

                //Procesa Ids
                if($ids_cambio_sucursal != ""){
                    $auxx="";
                    $vecAu=explode("|", $ids_cambio_sucursal);
                    for ($i=0; $i < count($vecAu) ; $i++) {
                      if( $vecAu[$i] != "" ){
                        if( $auxx != "" ){ $auxx.=","; }
                        $auxx.="'".$vecAu[$i]."'";
                      }
                    }
                } else {
                     $auxx="'".$_SESSION["handel_select"]."'";
                }

                if( $auxx != "" ){ $auxx.=",'-1'"; }

                return $auxx;
            }

            //Obtiene extención del archivo temporal del comprobante
            function optExtencion(){
                        //Verifica si el archivo del comprobante se cargo correctamente
                        $rutaTmp="tmp/comprobante";
                        $nombreFile="pago_".session_id();
                        $rtaFull=$rutaTmp."/".$nombreFile;
                        $ext="";

                        //Identifica Extencion
                        if(file_exists($rutaTmp."/".$nombreFile.".png")){ $ext=".png"; }
                        if(file_exists($rutaTmp."/".$nombreFile.".pdf")){ $ext=".pdf"; }
                        if(file_exists($rutaTmp."/".$nombreFile.".jpeg")){ $ext=".jpeg"; }
                        if(file_exists($rutaTmp."/".$nombreFile.".jpg")){ $ext=".jpg"; }

                        return $ext;
            }

            //Borra registro de pago
            function borraRegistroPago($id_registro){
                        $coneccion=new sQuery();
                        $coneccion->executeQuery("delete from tcomprobantes_pago_aux where id_comprobante_pago='".$id_registro."'");
                        $coneccion->Close();

                        $coneccion=new sQuery();
                        $coneccion->executeQuery("delete from tcomprobantes_pago where id='".$id_registro."'");
                        $coneccion->Close();
            }

                  //Activa solo licencias de sucursales independientes (Checks de sucursal)
                  //Solo se ejecuta si esta en el mes del periodo
                  function ActivaLicenciasA($creditos="",$id_empresa_base=""){

                        if( (int)$id_empresa_base > 0 ){
                            $suc_licencias="";
                            $vecHandels=array();
                            $coneccion=new sQuery();
                            $coneccion->executeQuery("SELECT id_empresa_base,handel,fecha_inicio FROM `tcontrol_cobros` WHERE status in('Comprobante Cargado','Pagado','Proximo Mes') and procesado='0' and tipo_licencia='mensual' and id_empresa_base='".$id_empresa_base."'");
                            if( $coneccion->getAffect() > 0 ){
                                while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {
                                  if(!in_array($datos_text["handel"], $vecHandels)) {
                                      $suc_licencias.= $datos_text["handel"]."|";
                                      $vecHandels[]=$datos_text["handel"];
                                  }
                                }
                            }
                            $coneccion->Close();

                            //Activa/Desactiva creditos de sucursales
                            if($creditos=="[".date("Y")."/".date("m")."]"){
                                $suc_licencias_aux=$suc_licencias;

                                //Activa sucursales que no se les cobra licencia
                                $importe_pago_lic="";
                                $que=new sQuery();
                                $que->executeQuery("select importe_pago_lic from tempresas_base where id='".$id_empresa_base."'");
                                if($que->getAffect() > 0){ while($datos_text = mysqli_fetch_array($que->getResults())){ $importe_pago_lic=$datos_text["importe_pago_lic"]; }}
                                $que->Close();
                                if($importe_pago_lic != ""){
                                    $vecIm=explode("|", $importe_pago_lic);
                                    if( count($vecIm) > 1 ){
                                         for ($i=0; $i < count($vecIm) ; $i++) {
                                             if( $vecIm[$i] != "" ){
                                                 $aux2=explode("/", $vecIm[$i]);
                                                 if(count($aux2)==2 && (float)$aux2[1]==0 ){
                                                    if(!in_array($aux2[0], $vecHandels)) {
                                                        $suc_licencias_aux.= $aux2[0]."|";
                                                        $vecHandels[]=$aux2[0];
                                                    }
                                                 }
                                             }
                                         }
                                    }
                                }

                                //Aplica permiso por sucursal.
                                $coneccion=new sQuery();
                                $coneccion->executeQuery("update tempresas_base set suc_licencias='".$suc_licencias_aux."' where id='".$id_empresa_base."'");
                                $coneccion->Close();
                            }

                            //Si no existen sucursales seleccionadas / Cancela licencia del mes
                            if($suc_licencias==""){
                                //Lee creditos actuales
                                $str_creditos="";
                                $coneccion=new sQuery();
                                $coneccion->executeQuery("select creditos from tempresas_base where id='".$id_empresa_base."'");
                                if( $coneccion->getAffect() > 0 ){while ($datos_text = mysqli_fetch_array($coneccion->getResults())){ $str_creditos=$datos_text["creditos"]; }}
                                $coneccion->Close();

                                if($str_creditos != ""){
                                    $vecA=explode($creditos, $str_creditos);
                                    $creAux="";
                                    for ($i=0; $i <=count($vecA) ; $i++){ if($vecA[$i] != ""){ $creAux.=$vecA[$i]; } }
                                    $coneccion=new sQuery();
                                    $coneccion->executeQuery("update tempresas_base set creditos='".$creAux."' where id='".$id_empresa_base."'");
                                    $coneccion->Close();
                                }

                            }
                        }
                  }

                  function DesactivaAnualesAtrasados($id_empresa_base){
                      if( (int)$id_empresa_base > 0 ){
                          //Desactiva Licencia
                          $coneccion=new sQuery();
                          $coneccion->executeQuery("SELECT id_empresa_base,handel,fecha_fin,importe_pago,is_factura FROM `tcontrol_cobros` WHERE status in('Pendiente','Pago Incorrecto') and procesado='0' and tipo_licencia='anual' and ban_atrasado='1' and id_empresa_base='".$id_empresa_base."'");
                          if( $coneccion->getAffect() > 0 ){
                              while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {
                                $actualiza=new sQuery();
                                $actualiza->executeQuery("update tpagos_anuales set chk='0' where id_empresa_base='".$datos_text["id_empresa_base"]."' and handel='".$datos_text["handel"]."' and fecha='".$datos_text["fecha_fin"]."' and importe_pago='".$datos_text["importe_pago"]."' and is_factura='".$datos_text["is_factura"]."'");
                                $actualiza->Close();
                              }
                          }
                          $coneccion->Close();
                      }
                  }

                  //Función para activar las licencias cargadas
                  function ActivaLicencias($creditos="",$id_empresa_base=""){

                        if( (int)$id_empresa_base > 0 ){

                            //-------------- ACTIVA CREDITOS PARA EL MES ---------------

                                if( $creditos != "" ){
                                    $coneccion=new sQuery();
                                    $coneccion->executeQuery("update tempresas_base set creditos=concat(creditos,'".$creditos."') where id='".$id_empresa_base."' and not creditos like '%".$creditos."%'");
                                    $coneccion->Close();
                                }

                            //-------------- LICENCIAS ANUALES ---------------

                                //Activa Licencia
                                $coneccion=new sQuery();
                                $coneccion->executeQuery("SELECT id_empresa_base,handel,fecha_fin,importe_pago,is_factura FROM `tcontrol_cobros` WHERE status in('Comprobante Cargado','Pagado','Proximo Mes') and procesado='0' and tipo_licencia='anual' and id_empresa_base='".$id_empresa_base."'");
                                if( $coneccion->getAffect() > 0 ){
                                    while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {
                                        $actualiza=new sQuery();
                                        $actualiza->executeQuery("update tpagos_anuales set chk='1' where id_empresa_base='".$datos_text["id_empresa_base"]."' and handel='".$datos_text["handel"]."' and fecha='".$datos_text["fecha_fin"]."' and importe_pago='".$datos_text["importe_pago"]."' and is_factura='".$datos_text["is_factura"]."'");
                                        $actualiza->Close();
                                    }
                                }
                                $coneccion->Close();

                                //Desactiva Licencia
                                $coneccion=new sQuery();
                                $coneccion->executeQuery("SELECT id_empresa_base,handel,fecha_fin,importe_pago,is_factura FROM `tcontrol_cobros` WHERE status in('Pendiente','Pago Incorrecto') and procesado='0' and tipo_licencia='anual' and id_empresa_base='".$id_empresa_base."'");
                                if( $coneccion->getAffect() > 0 ){
                                    while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {
                                        $actualiza=new sQuery();
                                        $actualiza->executeQuery("update tpagos_anuales set chk='0' where id_empresa_base='".$datos_text["id_empresa_base"]."' and handel='".$datos_text["handel"]."' and fecha='".$datos_text["fecha_fin"]."' and importe_pago='".$datos_text["importe_pago"]."' and is_factura='".$datos_text["is_factura"]."'");
                                        $actualiza->Close();
                                    }
                                }
                                $coneccion->Close();

                            //-------------- HABILITA SUCURSALES INDIVIDUALES --------

                                ActivaLicenciasA($creditos,$id_empresa_base);


                        }


                  }
switch ($_POST['index']) {
   case 1:  //--------- RETORNA LISTADO DE PAGOS PENDIENTES POR LA SUCURSAL ----------

                  $retu="";
                  $stat="";
                  $creditos="";
                  $strPeriodoActual="";
                  $ban_iva="0";
                  $str_periodo='';

                  $stat=" and t1.status in('Pendiente','Pago Incorrecto') and t1.id_empresa_base='".$_POST["id_empresa_base"]."' and t1.handel in(".HandelsUser().") ";

                  $coneccion=new sQuery();
                  $coneccion->executeQuery("SELECT t1.id,t2.nombre_empresa,(select nombreSucursal_Sel from tempresas where handel=t1.handel) as nombreSucursal_Sel,t1.handel,t1.fecha_inicio,t1.fecha_fin,t1.tipo_licencia,t1.is_factura,t1.importe_pago,t1.status,t1.comentarios,t1.ban_atrasado,t1.id_empresa_base,t1.cantidad_sms FROM tcontrol_cobros t1,tempresas_base t2 WHERE t1.id_empresa_base=t2.id and t1.procesado='0' ".$stat." order by t1.id_empresa_base asc,t1.ban_atrasado asc,t1.status asc,t1.tipo_licencia asc");

                  if( $coneccion->getAffect() > 0 ){
                      while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {

                        $fechaP="";

                        $retu.='<a id="cuadro_'.$datos_text["id"].'" href="#" data-id_empresa_base="'.$datos_text["id_empresa_base"].'" data-id="'.$datos_text["id"].'" data-status="'.$datos_text["status"].'" class="contenedor">';

                        //Inicio
                        $dia_ini=date("d",strtotime($datos_text["fecha_inicio"]));
                        $mes_ini=date("m",strtotime($datos_text["fecha_inicio"]));
                        $anio_ini=date("Y",strtotime($datos_text["fecha_inicio"]));
                        //Fin
                        $dia_fin=date("d",strtotime($datos_text["fecha_fin"]));
                        $mes_fin=date("m",strtotime($datos_text["fecha_fin"]));
                        $anio_fin=date("Y",strtotime($datos_text["fecha_fin"]));

                        if($mes_fin==$mes_ini && $anio_ini==$anio_fin){
                           $periodo=$dia_ini.' a '.$dia_fin.' de '.$mesA[ (int)$mes_ini ].' de '.$anio_fin;
                        } else {
                           $periodo=date("d/m/Y",strtotime($datos_text["fecha_inicio"])).' a '.date("d/m/Y",strtotime($datos_text["fecha_fin"]));
                        }

                        //Link para consultar el comprobante cargado
                        $viewComprobante="<a href='#' data-id='".$datos_text["id"]."' class='viewComp' style='color:red'>Existe un error en el comprobante de pago.</a>";

                        //Identifica inicio del periodo
                        switch ($datos_text["tipo_licencia"]) {
                             case 'mensual':
                                  $creditos="[".date("Y",strtotime($datos_text["fecha_inicio"]))."/".date("m",strtotime($datos_text["fecha_inicio"]))."]";
                                  $str_periodo=$mesA[ (int)$mes_ini ].' de '.$anio_fin;

                                  $retu.='<b><h1>Licencia '.utf8_encode($datos_text["nombreSucursal_Sel"]).'</h1></b>';
                                  $retu.='<h3>'.$periodo.'</h3>';

                                  if($datos_text["status"]=="Pago Incorrecto"){
                                     $datos_text["comentarios"].=$viewComprobante;
                                  }

                               break;
                             case 'anual':
                                  $fechaP='<label style="color:blue; font-size:0.8em">'.date("d-m-Y",strtotime($datos_text["fecha_fin"]))."</label>";

                                  $retu.='<b><h1>Licencia Anual '.utf8_encode($datos_text["nombreSucursal_Sel"]).'</h1></b>';
                                  //$retu.='<h3>'.$periodo.'</h3>';

                                  if($datos_text["status"]=="Pago Incorrecto"){
                                     $datos_text["comentarios"].=$viewComprobante;
                                  }

                               break;
                             case 'SMS':
                                  $retu.='<b><h1><img src="img/sms.png"> Comprar créditos SMS</h1></b>';
                                  $retu.='<label data-id="'.$datos_text["id"].'" class="cancelProgSMS">Cancelar compra</label>';
                                  if($datos_text["comentarios"] != ""){
                                      $aux="";
                                      $totalCred=0;
                                      $vecAux=explode("|", $datos_text["comentarios"]);
                                      for ($i=0; $i < count($vecAux) ; $i++) {
                                          if( $vecAux[$i] != "" ){
                                              $vec2=explode("/", $vecAux[$i]);
                                              $aux.='<tr><td>'.$vec2[0].'</td><td style="text-align:right;">'.$vec2[1].'</td></tr>';
                                              $totalCred+=(int)$vec2[1];
                                          }
                                      }
                                      if($aux != ""){
                                          $aux.='<tr><td style="text-align:right"><b>Total..:</b></td><td style="text-align:right; border-top:1px solid #08298A;"><b>'.$totalCred.'</b></td></tr>';
                                          $aux='<tr><th>&nbsp;Sucursal&nbsp;</th><th><center>&nbsp;'.utf8_decode('Créditos').'&nbsp;</center></th></tr>'.$aux;
                                          $datos_text["comentarios"]='<table class="tablDetSMS">'.$aux.'</table>';
                                      }
                                  }

                                  if($datos_text["status"]=="Pago Incorrecto"){
                                     $datos_text["comentarios"]=$viewComprobante."<br>".$datos_text["comentarios"];
                                  }
                               break;
                        }

                        //Coloca encabezado

                        $retu.='</center>';
                        $retu.='<hr>';

                        //Comentarios
                        if($datos_text["comentarios"]==""){ $datos_text["comentarios"]="<font color='#A4A4A4'>(Vacio)</font>"; }

                        $lblComentario="Comentario";
                        if($datos_text["ban_atrasado"]=="1"){ $lblComentario="<font color='red'>Atraso</font>"; }

                        //Identifica factura
                        $strIva="";
                        if($datos_text["is_factura"]=="1"){ $ban_iva="1"; $strIva="<font color='#084B8A' size='2'> iva incluido </font>"; }

                        $retu.='<center><h4>$ '.number_format($datos_text["importe_pago"],2,".",",").$strIva."</h4></center>";

                        $retu.='<hr>';

                        $retu.='<table data-tipPago="'.$datos_text["tipo_licencia"].'" style="width:100%">
                             <tr>
                                   <td class="lblTik">Tipo pago</td>
                                   <td>:&nbsp;</td>
                                   <td>'.strtoupper(utf8_encode($datos_text["tipo_licencia"]))." ".$fechaP.'</td>
                             </tr>
                             <tr>
                                   <td class="lblTik">'.$lblComentario.'</td>
                                   <td>:&nbsp;</td>
                                   <td class="comentCeld">'.utf8_encode($datos_text["comentarios"]).'</td>
                             </tr>                                                                                      
                         </table>';

                        $retu.='</a>';

                      }
                  }
                  $coneccion->Close();

                  if($retu==""){
                    echo '<hr><div class="noResultados"><font color="#298A08"><b>* No existen pagos pendientes.</b></font></div><hr>';
                  } else {
                     echo $retu;
                  }

                  echo "<div style='clear:both'></div><br><br><br><br>";

                  //Arroja valores ocultos auxiliares
                  echo '<input type="hidden" id="creditos" value="'.$creditos.'">
                        <input type="hidden" id="str_periodo" value="'.$str_periodo.'">
                        <input type="hidden" id="ban_iva" value="'.$ban_iva.'">';

      break;
    case 2:  ##################### OBTIENE CONTROLADOR PARA CARGAR DOCUMENTO ########################

                  $vec=explode("|", $_POST["ids"]);
                  $auxv="";
                  for ($i=0; $i < count($vec) ; $i++) {
                    if( $vec[$i] != "" ){
                        if( $auxv != "" ){ $auxv.=","; }
                        $auxv.="'".$vec[$i]."'";
                    }
                  }

                  $total_cuenta=0.0;
                  $numx=0;
                  $retu="";
                  $coneccion=new sQuery();
                  $coneccion->executeQuery("SELECT t1.id,t1.handel,t2.nombre_empresa,(SELECT nombreSucursal_Sel from  tempresas where handel=t1.handel) as nombreSucursal_Sel,t1.fecha_inicio,t1.fecha_fin,t1.tipo_licencia,t1.importe_pago FROM tcontrol_cobros t1,tempresas_base t2 WHERE t1.id in(".$auxv.") and t1.id_empresa_base=t2.id");
                  if( $coneccion->getAffect() > 0 ){
                      $totAll=$coneccion->getAffect();
                      while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {
                         if((int)$datos_text["handel"] > 0){ $nombreSucursal_Sel= utf8_encode($datos_text["nombreSucursal_Sel"]); } else { $nombreSucursal_Sel= "Todas"; }

                          $numx++;

                          $retu.='<tr>
                                    <td>'.$numx." de ".$totAll.'</td>
                                    <td>'.$nombreSucursal_Sel.'</td>
                                    <td>'.utf8_encode(strtoupper($datos_text["tipo_licencia"])).'</td>
                                    <td style="text-align:right; border-right: 1px solid #D8D8D8;">'.number_format($datos_text["importe_pago"],2,".",",").'</td>
                                 </tr>';

                          $total_cuenta+=number_format($datos_text["importe_pago"],2,".","");
                      }
                  }
                  $coneccion->Close();

                  $head="<tr>
                              <th style='width:10%'>#</th>
                              <th style='width:30%'>Sucursal</th>
                              <th style='width:25%'>Tipo</th>
                              <th style='text-align:right; border-right: 1px solid #D8D8D8; width:20%'>Importe</th>
                         </tr>";

                  echo "<div id='seccionDetalles'><table cellspacing='0' cellpadding='0'>".$head.$retu."</table><br><br><br></div>";

                  echo "<h2><center>$ ".number_format($total_cuenta,2,".",",")."</center></h2>";

                  echo '<div class="zonaDrop">
                          <form id="formSub" action="recursos/php/upload_comprobante_pago.php" class="dropzone" ></form>        
                        </div>';

                  echo "<input type='hidden' id='TotalImportComprobante' value='".number_format($total_cuenta,2,".","")."'>";

         break;
    case 3:  ##################### HABILITA DE NUEVO TODOS LOS MENUS ########################

            unset($_SESSION["msg_blk"]);
            $_SESSION["pagoCompleto"]="1";

            //Obtiene nombre de la epresa que cargo el comprobante
            $nombre_empresa="";
            $coneccion=new sQuery();
            $coneccion->executeQuery("select nombre_empresa from tempresas_base where id='".$_POST["id_empresa_base"]."'");
            if( $coneccion->getAffect() > 0 ){while ($datos_text = mysqli_fetch_array($coneccion->getResults())){ $nombre_empresa=utf8_encode($datos_text["nombre_empresa"]); }}
            $coneccion->Close();

            //Envia un correo de notificación, avisando del pago.
            include_once("../../../../core/email.php");

            $Destinatarios="masterdinner2013@gmail.com";
            $AsuntoMail='Comprobante de pago cargado';
            $cuerpoMail=$nombre_empresa.' ha cargado comprobante de pago.';

            $email=new emails($Destinatarios,"eluis@sistemasyservicios.mx","");
            $email->setFromName( utf8_decode($AsuntoMail) );

            //Reintenta envios de Email.
            $exito = $email->Send($_SESSION["nombreEmpresa_Sel"],$cuerpoMail);
            $intentos=1;
            while ((!$exito) && ($intentos < 5)) {
                sleep(5);
                $exito = $email->Send($_SESSION["nombreEmpresa_Sel"],$cuerpoMail);
                $intentos=$intentos+1;
            }

         break;
    case 4:  ##################### MESTRA INSTRUCCIONES PARA PAGO ########################

            switch ($_POST["ban_iva"]) {
              case '0': //En efectivo
                   /*
                   $nombre_banco="Scotiabank Inverlat";
                   $cuenta="25603811260";
                   #$tarjetaNo="4043 1300 0525 1893";
                   $clabe="044900256038112605";
                   $beneficiario="Dora Luz Montero Vírgen";
                   $RFC="MOVD830827KL1";
                   */

                   /*
                   $nombre_banco="Scotiabank";
                   $cuenta="06701231928";
                   $tarjetaNo="5579 2200 0951 2173";
                   $clabe="044900067012319286";
                   $beneficiario="Juan Miguel Salomon Villegas";
                   $RFC="SAVJ780830TV3";
                   */
                   $nombre_banco="BBVA Bancomer";
                   $cuenta="1562178729";
                   #$tarjetaNo="4152 3136 8206 3743";
                   $clabe="012460015621787299";
                   $beneficiario="Dora Luz Montero Vírgen";
                   $RFC="MOVD830827KL1";

                break;
              case '1': //Con factura
                   $nombre_banco="BBVA Bancomer";
                   $cuenta="0456181600";
                   #$tarjetaNo="4152 3134 0139 4189";
                   $clabe="012680004561816008";
                   $beneficiario="Edgar Luis Hernández García";
                   $RFC="HEGE830812D60";
                break;
            }

            //----------------------------------------------------------------------------

            echo "<h2>Estimado Cliente</h2>";

            echo "<p>A continuación se presenta la información necesaria para realizar el pago de nuestros servicios.</p>";

            echo "<h3>Datos del Banco</h3>";

            echo '
                   <table>
                       <tr>
                             <td><b>Banco</b></td>
                             <td>&nbsp;&nbsp;:</td>
                             <td>&nbsp;&nbsp;'.$nombre_banco.'</td>
                       </tr>
                       <tr>
                             <td><b>Cuenta No</b></td>
                             <td>&nbsp;&nbsp;:</td>
                             <td>&nbsp;&nbsp;'.$cuenta.'</td>
                       </tr>
                       <tr>
                             <td><b>CLABE</b></td>
                             <td>&nbsp;&nbsp;:</td>
                             <td>&nbsp;&nbsp;'.$clabe.'</td>
                       </tr>
                       <tr>
                             <td><b>Beneficiario</b></td>
                             <td>&nbsp;&nbsp;:</td>
                             <td>&nbsp;&nbsp;'.$beneficiario.'</td>
                       </tr>  
                       <tr>
                             <td><b>RFC</b></td>
                             <td>&nbsp;&nbsp;:</td>
                             <td>&nbsp;&nbsp;'.$RFC.'</td>
                       </tr>                                                                                                                 
                   </table>';

            echo "<h3>Enviar pago vía sistema</h3>";

            echo "<ol>";
            echo "<li>Despues de realizar el pago de la licencia, tenga a la mano su comprobante de depósito.</li><br>";
            echo "<li>Pulse el botón <b>“Cargar comprobante”</b>, y suba el documento que acredita el movimiento bancario;  puede ser un acuse en formato .pdf, una captura de pantalla del ticket o váucher, o una foto tomada directamente con su Smartphone.</li><br>";
            echo "<li>Pulse el botón <b>REGISTRAR PAGO</b>.</li><br>";
            echo "</ol>";

            echo "<p>Para mas información consulte el artículo <a target='_blank' href='https://sistemasyservicios.mx/web/articulos/28/activacion-de-licencias'>Activación de Licencias</a></p>";

         break;
    case 5:  ##################### RETORNA SUCURSALES PARA COMPRA DE CRÉDITOS SMS ########################


            $retu="";
            $coneccion=new sQuery();
            $coneccion->executeQuery("SELECT t1.handel,t1.nombreSucursal_Sel,((SELECT ifnull(sum(cantidad_sms),0) FROM tcreditos_sms WHERE handel=t1.handel)-(SELECT ifnull(sum(cantidad_sms),0) FROM tconsumos_sms WHERE handel=t1.handel)) as creditos_sms FROM tempresas t1 WHERE t1.id_empresa_base='".$_POST["id_empresa_base"]."' and t1.handel in(".HandelsUser().") order by t1.nombreSucursal_Sel asc");
            if( $coneccion->getAffect() > 0 ){
                while ($datos_text = mysqli_fetch_array($coneccion->getResults())){

                    if((int)$datos_text["creditos_sms"]==0){
                      $strCred='<font color="red">0</font>';
                    } else {
                      $strCred='<font color="#0B0B61">'.$datos_text["creditos_sms"].'</font>';
                    }

                    $retu.='<tr>';
                    $retu.='<td style="text-align:left;">'.utf8_encode($datos_text["nombreSucursal_Sel"]).'</td>';
                    $retu.='<td><b>'.$strCred.'</b></td>';
                    $retu.='<td><select id="cred_sms_'.$datos_text["handel"].'" data-handel="'.$datos_text["handel"].'" data-nombreSuc="'.utf8_encode($datos_text["nombreSucursal_Sel"]).'" class="cred_sms"><option selected value="">( ninguno )</option><option value="25">25 SMS</option><option value="50">50 SMS</option><option value="60">60 SMS</option><option value="70">70 SMS</option><option value="100">100 SMS</option><option value="150">150 SMS</option><option value="200">200 SMS</option><option value="300">300 SMS</option><option value="450">450 SMS</option><option value="600">600 SMS</option><option value="800">800 SMS</option><option value="1000">1000 SMS</option><option value="1500">1500 SMS</option><option value="2500">2500 SMS</option><option value="3500">3500 SMS</option><option value="5000">5000 SMS</option></select> </td>';
                    $retu.='</tr>';
                }
            }
            $coneccion->Close();

            $encab='<tr>';
            $encab.='<th>Sucursal</th>';
            $encab.='<th>Créditos Actuales</th>';
            $encab.='<th>Comprar Créditos</th>';
            $encab.='</tr>';

            if($retu == ""){ $retu.='<tr><td colspan="3"><div class="noResultados"><font color="#298A08"><b>* No existen resultados para mostrar.</b></font></div></td></tr>'; }

            echo '<center><table id="tablaCompraSMS" cellspacing="0" cellpadding="0">'.$encab.$retu.'</table></center>';

         break;
    case 6:  ##################### AGREGA REGISTRO PARA COBRO SMS ########################

            //Obtiene el periodo Correcto
            $fecha_inicio = "";
            $fecha_fin = "";

            //Si no existe al menos un periodo abierto no prosigue
            $coneccion=new sQuery();
            $coneccion->executeQuery("SELECT fecha_inicio,fecha_fin FROM `tcontrol_cobros` WHERE fecha_pago is null order by id DESC limit 1");
            if( $coneccion->getAffect() > 0 ){
                while ($datos_text = mysqli_fetch_array($coneccion->getResults())){
                    $fecha_inicio= $datos_text['fecha_inicio'];
                    $fecha_fin=$datos_text['fecha_fin'];
                }
            }
            $coneccion->Close();

            if($fecha_inicio=='' || $fecha_fin==''){

               die("No es posible registrar la compra de créditos en éste momento.");

            } else {
                //Añade registro de control de cobro
                $coneccion=new sQuery();
                $coneccion->executeQuery("insert into tcontrol_cobros(id_empresa_base,handel,fecha_generacion,importe_pago,tipo_licencia,status,str_suc_sms,comentarios,cantidad_sms,fecha_inicio,fecha_fin) values ('".$_POST["id_empresa_base"]."','-1',now(),'".$_POST["totCompra"]."','SMS','Pendiente','".$_POST["cadAcum"]."','".$_POST["comentario"]."','".$_POST["cantidadSMS"]."','".$fecha_inicio."','".$fecha_fin."')");
                if( $coneccion->getAffect() > 0 ){ echo "1"; } else { echo "No fue posible agregar la compra."; }
                $coneccion->Close();
            }

         break;
    case 7:  ##################### RETORNA CANTIDAD DE CREDITOS SMS ACTUALES ########################


            function getNCreditosSMS($handels){
                $retu=0;
                $coneccion=new sQuery();
                $coneccion->executeQuery("SELECT ifnull(sum((SELECT ifnull(sum(cantidad_sms),0) FROM tcreditos_sms WHERE handel=t1.handel)-(SELECT ifnull(sum(cantidad_sms),0) FROM tconsumos_sms WHERE handel=t1.handel)),0) as creditos_sms FROM tempresas t1 WHERE t1.handel in(".$handels.")");
                if( $coneccion->getAffect() > 0 ){while ($datos_text = mysqli_fetch_array($coneccion->getResults())){ $retu=$datos_text["creditos_sms"];}}
                $coneccion->Close();
                return (int)$retu;
            }

            $retu=getNCreditosSMS(HandelsUser());

            echo $retu;
         break;
    case 8:  ##################### CANCELA COBRO DE CREDITOS SMS ########################
            $retu=0;

            $coneccion=new sQuery();
            $coneccion->executeQuery("delete from tcomprobantes_pago_aux where id_control_cobros='".$_POST["idCobro"]."'");
            $coneccion->Close();

            $coneccion=new sQuery();
            $coneccion->executeQuery("delete from tcontrol_cobros where id_empresa_base='".$_POST["id_empresa_base"]."' and id='".$_POST["idCobro"]."'");
            if( $coneccion->getAffect() > 0 ){ $retu=1; }
            $coneccion->Close();
            echo $retu;
         break;
    case 9:  ##################### VERIFICA SI SE CARGO EL COMPROBANTE ########################


            $ext=optExtencion();

            if($ext == ""){
                echo "No se cargo el archivo del comprobante.";
            } else {
                echo "1";
            }

         break;
    case 10:  ##################### ACOMPLETA REGISTRO DE CARGA DE COMPROBANTE ########################
            $banLicPeriodo = true;

            //Obtiene Extencion y nombre de archivo
            $ext=optExtencion();
            $nombreFileTmp="tmp/comprobante/pago_".session_id().$ext;

            //Separa ids de registros de pago
            $idsRp=explode("|", $_POST["ids_registros"] );
            if( count($idsRp) <=1 ){ echo "No fue posible procesar los registros de pago."; exit(0); }

            //Inserta registro principal de cobro
            $guarda=false;
            $coneccion=new sQuery();
            $coneccion->executeQuery("insert into tcomprobantes_pago(nombre_archivo,ext_file,importe_total,fecha_carga,id_session) values ('{pendiente}','".$ext."','".$_POST["importe_total"]."',now(),'".session_id()."')");
            if( $coneccion->getAffect() > 0 ){ $guarda=true; }
            $coneccion->Close();
            if($guarda==false){ echo "No fue posible ingresar el registro del comprobante."; exit(0); }


            //Obtiene ID de registro de pago recien ingresado
            $id_registro="{error}";
            $coneccion=new sQuery();
            $coneccion->executeQuery("select id from tcomprobantes_pago where nombre_archivo='{pendiente}' and id_session='".session_id()."'");
            if( $coneccion->getAffect() == 1 ){
                $datos_text = mysqli_fetch_array($coneccion->getResults());
                $id_registro=(int)$datos_text["id"];
            }
            $coneccion->Close();
            if( $id_registro=="{error}" || (int)$id_registro <= 0 ){
                $coneccion=new sQuery();
                $coneccion->executeQuery("delete from tcomprobantes_pago where nombre_archivo='{pendiente}' and id_session='".session_id()."'");
                $coneccion->Close();
                echo "Error al cargar el registro, intente de nuevo."; exit(0);
            }
            $nuevoNombre=$id_registro.date("dmYHms").$ext;



            //Acompleta info en registro principal
            $coneccion=new sQuery();
            $coneccion->executeQuery("update tcomprobantes_pago set nombre_archivo='".$nuevoNombre."',id_session='' where id='".$id_registro."'");
            $coneccion->Close();

            //Ingresa los detalles del registro de cobranza
            $contReg=0;
            $acumIds="";
            for ($i=0; $i < count($idsRp) ; $i++) {
              if( $idsRp[$i] != "" ){

                  //Borra vinculo anterior
                  $coneccion=new sQuery();
                  $coneccion->executeQuery("delete from tcomprobantes_pago_aux where id_comprobante_pago != '".$id_registro."' and id_control_cobros='".$idsRp[$i]."'");
                  $coneccion->Close();

                  //Crea nuevo vinculo
                  $coneccion=new sQuery();
                  $coneccion->executeQuery("insert into tcomprobantes_pago_aux(id_comprobante_pago,id_control_cobros) values ('".$id_registro."','".$idsRp[$i]."')");
                  if( $coneccion->getAffect() > 0 ){ $contReg++; }
                  $coneccion->Close();

                  if($acumIds != ""){ $acumIds.=","; }
                  $acumIds.="'".$idsRp[$i]."'";
              }
            }

            if($contReg != count($idsRp)-1){
                //Borra registros recien ingresados
                borraRegistroPago($id_registro);
                echo "No fue posible ingresar los detalles del pago.";
                exit(0);
            }

            //Limpia registros de cobranza oxoletos
            $coneccion=new sQuery();
            $coneccion->executeQuery("delete from `tcomprobantes_pago` where not id in( select id_comprobante_pago from tcomprobantes_pago_aux)");
            $coneccion->Close();


            //-------------- ARCHIVA COMPROBANTE DE PAGO ----------------
            $rutaArchivo=$PROF."../app/pagos";

            //Si no existe la ruta de destino la crea
            if(!file_exists($rutaArchivo)){ mkdir($rutaArchivo, 0777, true); }

            //Si ya existe un archivo de destino lo elimina
            if(file_exists($rutaArchivo."/".$nuevoNombre)){ unlink($rutaArchivo."/".$nuevoNombre, 0777, true); }

            if (!copy($nombreFileTmp, $rutaArchivo."/".$nuevoNombre)) {
                echo "No fue posible archivar el comprobante de pago.";
                borraRegistroPago($id_registro);
                exit(0);
            } else {
                //Borra archivo temporal
                 unlink($nombreFileTmp);
            }

            //-------------- MARCA NUEVO STATUS ------------------
            $coneccion=new sQuery();
            $coneccion->executeQuery("update tcontrol_cobros set status='Comprobante Cargado',fecha_pago=now() where (status='Pendiente' or status='Pago Incorrecto') and id in(".$acumIds.")");
            $coneccion->Close();

            //-------------- REFRESCA LICENCIAS DEL PERIODO ----------------

            //Si no existen pagos tipo mensual no refresca las licencias del periodo
            if(isset($_POST['typeMens']) && $_POST['typeMens']=='0'){ $banLicPeriodo=false; }

            if($banLicPeriodo){ ActivaLicencias( $_POST["creditos"],$_POST["id_empresa_base"] ); }

            //-------------- AGREGA CREDITOS SMS----------------

            $coneccion=new sQuery();
            $coneccion->executeQuery("select id,id_empresa_base,str_suc_sms from tcontrol_cobros where tipo_licencia='SMS' and id in(".$acumIds.")");
            if( $coneccion->getAffect() > 0 ){
                while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {
                     $vecAux=explode("|", $datos_text["str_suc_sms"]);
                     if(count($vecAux) > 0){
                         for ($i=0; $i < count($vecAux) ; $i++) {
                            if( $vecAux[$i] != "" ){
                                $auxx=explode("/", $vecAux[$i]);
                                $actua=new sQuery();
                                $actua->executeQuery("insert into tcreditos_sms(id_empresa_base,handel,id_registro_pago,fecha_hora,cantidad_sms,costo_sms) value ('".$datos_text["id_empresa_base"]."','".$auxx[0]."','".$datos_text["id"]."',now(),'".$auxx[1]."','".$_POST["costoSMS"]."')");
                                $actua->Close();
                            }
                         }
                     }
                }
            }
            $coneccion->Close();


            //--------------------------------------------------

            echo "1";


         break;
   default:
         echo "Comando no reconocido ".$_POST['index'];
      break;
}
?>
