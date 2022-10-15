            <?php
              include_once("../../core/funciones_privilegios.php");

              //Verifica si existe adeudo de licencia
              $ban_adeuda_licencia=false;
              if(isset($_SESSION["msg_blk"])){ if( $_SESSION["msg_blk"] != "" ){ $ban_adeuda_licencia=true; }}              

            ?>

<?php
      #----------------CONTROL DE PROFUNDIDAD----------------
      $PROF="../../";

      include_once($PROF."core/data_base.php"); 

      $proChangeSuc=" disabled ";

      //Obtiene handels de sucursales disponibles para cambio 
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
            $proChangeSuc="";
        } else {
             $auxx="'".$_SESSION["handel_select"]."'";
        }

        //Determina si el nombre del objeto es [handel] o [id_empresa_base]
        if(isset($_SESSION["pagLic"])){ $nombreObj="id_empresa_base"; } else { $nombreObj="handel"; }
?>            

<center>
<select style="text-align: left;" id="<?php echo $nombreObj; ?>" <?php echo $proChangeSuc; ?> >
                    <?php
                         $KOD=false;
                         if($auxx != ""){
                             if(isset($_SESSION["pagLic"])){

                                 ###  CONSULTA POR ID_EMPRESA_BASE ###
                                 $retu="<option disabled>";
                                 $coneccion=new sQuery();
                                 $coneccion->executeQuery("select id,nombre_empresa from tempresas_base where activa='SI' and id in(SELECT id_empresa_base FROM tempresas WHERE handel in(".$auxx.") and activa='Si')");
                                 if( $coneccion->getAffect() > 0 ){
                                     while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {

                                        //IDENTIFICA KING OF DIAMOND
                                        $viz=true;
                                        if($KOD && $datos_text["nombre_empresa"]=="RAZO"){ $viz=false; }
                                        if($datos_text["nombre_empresa"]=="King of Diamond"){ $KOD=true; }

                                        if($viz){
                                            $StySel="";
                                            if((int)$datos_text["id"]==(int)$_SESSION["id_empresa_base"]){ $StySel="selected"; }
                                            $retu.='<option '.$StySel.' value="'.$datos_text['id'].'">&nbsp;&#187;&nbsp;'.utf8_encode($datos_text['nombre_empresa']).'</option>';
                                        }
                                     }
                                 }
                                 $coneccion->Close();
                                 $retu.="<option disabled>";
                                 echo $retu;

                             } else {

                                 $disabledEB=" disabled ";
                                 if(isset($incluEB)){ $disabledEB=""; }

                                 ###  CONSULTA POR HANDEL (SUCURSAL) ###
                                 $retu="";
                                 $empresBas="";
                                 $indc=0;
                                 $coneccion=new sQuery();
                                 $coneccion->executeQuery("select t1.handel,t1.id_empresa_base,t1.nombreSucursal_Sel,t2.nombre_empresa from tempresas t1,tempresas_base t2 where t1.id_empresa_base=t2.id and t1.handel in(".$auxx.") and t1.activa='Si' and t2.activa='SI' order by t2.nombre_empresa asc,t1.nombreSucursal_Sel asc");
                                 if( $coneccion->getAffect() > 0 ){
                                     while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {

                                          //IDENTIFICA KING OF DIAMOND
                                          if($KOD && $datos_text["nombre_empresa"]=="RAZO"){ $datos_text["nombre_empresa"]="King of Diamond"; }
                                          if($datos_text["nombre_empresa"]=="King of Diamond"){ $KOD=true; }

                                          if($empresBas != $datos_text["nombre_empresa"]){
                                                if($empresBas != ""){ $retu.='<br>'; }
                                                $retu.='<option disabled></option><option '.$disabledEB.' value="-'.$datos_text['id_empresa_base'].'" style="font-weight: bold;">'.utf8_encode($datos_text['nombre_empresa']).'</option>';
                                                $empresBas=$datos_text["nombre_empresa"];
                                                $indc=0;
                                          }
                                          #----------------
                                          $indc++; $StySel="";
                                          if((int)$datos_text["handel"]==(int)$_SESSION["handel_select"]){ $StySel="selected"; }
                                          $retu.='<option '.$StySel.' value="'.$datos_text['handel'].'">&nbsp;&nbsp;&nbsp;&#187;&nbsp;'.utf8_encode($datos_text['nombreSucursal_Sel']).'</option>';

                                     }
                                 }
                                 $coneccion->Close();
                                 echo $retu;
                             }
                         }

                         //Bandera para identificar si el menú fue llamado desde licencias.php
                         if(isset($_SESSION["pagLic"])){ unset($_SESSION["pagLic"]); }
                    ?>
    </select>
</center>    