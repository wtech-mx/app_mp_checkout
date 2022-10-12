<?php ini_set("session.gc_maxlifetime", 28800);ini_set("session.cookie_lifetime",28800); session_start();        
      include_once("php/encabezado.php");
      $_SESSION["pagLic"]="1";
      include_once("php/menu.php"); 

      //Verifica si existe adeudo de licencia
      $ban_adeuda_licencia=false;
      if(isset($_SESSION["msg_blk"])){ if( $_SESSION["msg_blk"] != "" ){ $ban_adeuda_licencia=true; }}

     //Valida Permisos
      if(!isset($_SESSION["handel"]) || is_priv('optViLicenc','boolean') ){
           echo '<script type="text/javascript"> document.location.href="login.php"; </script>';
           exit(0);
      }


?>

<script type="text/javascript" src="js/dropzone.js?v=1473248119"></script>
<link type="text/css" href="css/dropzone.css?v=1473248119" rel="stylesheet" >

<style type="text/css">
         .contenedor{
            border:2px solid #848484;
            padding: 10px;
            margin: 10px;
            box-shadow: 2px 2px 5px #999;
            width: 292px;
            color: #1C1C1C;
            background-color: #FBF2EF;
            float: left;
            height: 220px;
            overflow-y: auto;
            text-decoration: none;
         }
         .contenedor:hover{
            cursor: pointer;
            text-decoration: none;
         }
         .contenedor h1,.contenedor h3{
            margin: 0px;
            padding: 0px;
         }
         .contenedor h1{
            font-size: 1.3em;    
            color: #084B8A;        
         }
         .contenedor h4{
            font-size: 1.3em; 
            font-weight: bold;           
         }
         .contenedor h3{
            font-size: 0.8em; 
            color: #045FB4;           
         }  
         .lblTik{
            font-weight: bold;
            text-align: right;  
            color: #585858 !important;          
         }

         /*Pie de página*/
         #cmdPie{
              background-color: #FAFAFA;
              position: fixed;
              bottom: 0;
              width: 100%;
              height: 67px;
              border-top: 2px solid #848484;   
              text-align: center;        
         }
         .cmd_btn_pie{
             display: inline-block;
             height: 54px;
             border-radius: 5px;
             padding: 7px;
             background-color: #BBD6E4; 
             margin: 5px;
             box-shadow: 2px 2px 5px black;
             color: #0B0B3B;
             opacity: 0.9;
             font-weight: bold;
         }
         .cmd_btn_pie img{
             width: 25px;
         }
         .cmd_btn_pie:hover{
            cursor: pointer;
            opacity: 1;
         }

         /*Cargar comprobante de pago*/
         .selPendiente{
            background-color: #F5D0A9;
            border: 2px solid black;
         }
         .btnDisabled{
             opacity: 0.2 !important;
         }
         #seccionDetalles{
             border: 1px solid #D8D8D8;
             display: block;
             overflow:auto; 
             width: 100%;
             height: 7em;
             max-height: 7em;
         }
         #seccionDetalles tr td{
             font-size: 0.65em;
             padding: 4px;
             border-left: 1px solid #D8D8D8;
             border-bottom: 1px solid #F2F2F2;
         }
         #seccionDetalles tr th{
             background-color: #F2F2F2;
             color: #848484;
             border-left: 1px solid #D8D8D8;
             text-align: center;
             padding: 4px;
         }
         #seccionDetalles tr:nth-child(odd),#detallesPago tr:nth-child(odd){
             background-color: #FAFAFA;
         }
         .zonaDrop,.dropzone{
             padding: 10px;
         }
         .dropzone{
            border: 3px dotted red;
         }  
         #lienzoPdf{
            width: 100%;
         }
         /*----- Créditos SMS -----*/
         #btn_carga_sms{
            display: inline-block;
            background-color: #58FA58;
            padding: 7px;
            padding-bottom: 3px;
            box-shadow: 4px 4px #888888;
            opacity: 0.85;
         }
         #btn_carga_sms:hover{
            cursor: pointer;
            opacity: 1;
         }
         #nCredit{
            font-size: 1.5em;
            font-weight: bold;
         }
         #tablaCompraSMS{
            width: 90%;
            margin: 10px;
         }
         #tablaCompraSMS tr td{
            text-align: center;
            padding: 7px;
            border-bottom: 1px solid #D8D8D8;
         }
         .cred_sms{
            width: 95%;
            padding: 5px;
            color: #08298A;
            font-size: 1.1em;
            min-width: 7em
         }
         #tablaCompraSMS tr th{
            text-align: center;
            padding: 10px;
            background-color: #F2F2F2; 
         }
         .tablDetSMS{
            margin-top: 0.5em;
         }
         .tablDetSMS tr td{
            text-decoration: none;
            color: #084B8A;
         }
         .cancelProgSMS{
            color: red;
            margin-bottom: 0px;
            opacity: 0.8;
         }
         .cancelProgSMS:hover{
            cursor: pointer;
            text-decoration: underline;
            opacity: 1;
         }
         
         .contenedor:link,.contenedor:visited,.contenedor:hover,.contenedor:active{
            text-decoration: none;
         }


</style>

<script type="text/javascript">
    
    var auxClic=false;
    var veriPagoAll=false;
    var costoSMS=0.70;


    /*=============================================================================================================================*/

    function VerPagos(id_empresa_base){
        var params={};            
        params.index="1";
        params.id_empresa_base=id_empresa_base;  
        preload(true); 
        $('#mnuDescPagos').load("php/cmd_comandos_pagos.php", params,function(resp){
            preload(false);
            $(".contenedor").addClass("selPendiente");
            habilitBtnCarga();

            //Verifica si ha completado todos los pagos
            if(veriPagoAll){ veriPagoCompleto(); } veriPagoAll=false;

            //Lee Cantida de creditos SMS
            funcGetCredSMS();
        }); 
    }

    //Habilita boton de cargar comprobante
    function habilitBtnCarga(){
            var contPend=0;
            $(".selPendiente").each(function(){ contPend++; });
            if(contPend >=1){ 
                $("#btn_cargar_comp").removeClass("btnDisabled");
            } else { 
                $("#btn_cargar_comp").addClass("btnDisabled");
            }        
    }

    //Verifica si todos los pagos estan completos
    function veriPagoCompleto(){
        var cont=0; 
        $(".contenedor").each(function(){ cont++; });
        if(cont==0){
            var params={};            
            params.index="3"; 
            params.id_empresa_base=$("#id_empresa_base").val();            
            $('#divAux').load("php/cmd_comandos_pagos.php", params,function(resp){ location.reload(true); });            
        }
    }

    //Averigua la cantidad de créditos SMS
    function funcGetCredSMS(){
        var params={};            
        params.index="7";
        $('#divAux').load("php/cmd_comandos_pagos.php", params,function(resp){
            if( parseInt(resp)==0 ){ $("#nCredit").css("color","red"); } else { $("#nCredit").css("color","black"); } 
            $("#nCredit").html(resp);
        });        
    } 

    //Cancelar cobro programado de creditos SMS
    function cancelProgSMS(idCobro){

        if(!confirm("Pulse 'Aceptar' para cancelar la compra SMS.")) return;
        var params={};            
        params.index="8";
        params.idCobro=idCobro;
        params.id_empresa_base=$("#id_empresa_base").val();
        preload(true); 
        $('#divAux').load("php/cmd_comandos_pagos.php", params,function(resp){
            if( resp.trim()=="1" ){
               VerPagos($("#id_empresa_base").val());
               alertify.success("La compra de créditos SMS fue cancelada.");     
            } else {
                preload(false); 
                alert("No fue posible cancelar la compra.");
            }
        });  
    }


    //Verifica si el archivo se cargo correctamente
    function veriUploadFile(){               
            var params={};            
            params.index="9"; 
            preload(true);
            $('#divAux').load("php/cmd_comandos_pagos.php", params,function(resp){
                preload(false);
                if(resp.trim()=="1"){
                    $("#btn_registrar_pago").removeClass("disabled");
                } else {
                    $("#btn_registrar_pago").addClass("disabled");
                    alert(resp);
                }
            });               
    }

    //Función para registrar el pago
    function acceptPago(){

            if($("#ids_registros").val()==""){
                alert("No se recibieron los ID para pago.");
                return;
            }

            var typeMens='0';

            $("[data-tipPago]").each(function(){
                if($(this).attr("data-tipPago")=="mensual"){ typeMens='1'; }
            });

            var params={};            
            params.index="10"; 
            params.ids_registros=$("#ids_registros").val(); 
            params.importe_total=$("#TotalImportComprobante").val(); 
            params.id_empresa_base=$("#id_empresa_base").val(); 
            params.creditos=$("#creditos").val();  
            params.costoSMS=costoSMS; 
            params.typeMens=typeMens;
                
            if(params.id_empresa_base==""){
                alert("No es posible procesar el comprobante por que no selecciono una empresa.");
                return;                
            }

            preload(true);
            $("#btn_registrar_pago").addClass("disabled");
            $('#divAux').load("php/cmd_comandos_pagos.php", params,function(resp){
                preload(false);
                if(resp.trim()=="1"){                       
                   $('#myModal').modal('hide');
                   alertify.success("El pago se registro correctamente.");
                   veriPagoAll=true;
                   VerPagos($("#id_empresa_base").val());
                } else {
                   $("#btn_registrar_pago").removeClass("disabled");
                   alert(resp);
                }
            });                               
    } 

    //Muestra Instrucciones para pago
    function vizInstrucciones(ban_iva){
        var params={};            
        params.index="4";
        params.ban_iva=ban_iva;  
        preload(true); 
        $('#divInstruccionesPago').load("php/cmd_comandos_pagos.php", params,function(resp){
            preload(false);
            $('#myModal_instruc').modal('show');
        });
    } 



    //Muestra Listado  de sucursales para compra de creditos sms
    function vizSucCredSMS(){
        var params={};            
        params.index="5";
        params.id_empresa_base=$("#id_empresa_base").val();
        $("#tituloCompraSMS").html("Comprar créditos SMS");
        preload(true); 
        $('#divSucCredSMS').load("php/cmd_comandos_pagos.php", params,function(resp){
            preload(false);
            $('#myModal_CredSMS').modal('show');
        });
    } 



    //Agrega registro para pago SMS
    function funcAddPagoSMS(){
        var params={};            
        params.index="6";
        params.id_empresa_base=$("#id_empresa_base").val();

        //Obtiene cantidades en creditos comprados
        var cadAcum="";
        var totCompra=0.0;
        var comentario="";
        var cantidadSMS=0;
        $(".cred_sms").each(function(){
             if(parseInt($(this).val()) > 0){ 
                 cadAcum+= $(this).attr("data-handel") + "/" + $(this).val() + "|"; 
                 totCompra+=parseInt($(this).val()) * costoSMS;
                 comentario+= $(this).attr("data-nombreSuc") + "/" + $(this).val() + "|";
                 cantidadSMS+=parseInt($(this).val());
             }
        });

        params.cadAcum=cadAcum;
        params.totCompra=totCompra;
        params.costoSMS=costoSMS;
        params.comentario=comentario;
        params.cantidadSMS=cantidadSMS;

        $('#myModal_CredSMS').modal('hide');
        preload(true); 
        $('#divAux').load("php/cmd_comandos_pagos.php", params,function(resp){            
            if(resp.trim()=="1"){
               VerPagos($("#id_empresa_base").val());
               alertify.success("El registro de compra SMS fue agregado.");            
            } else {
               preload(false); 
               alertify.error("No fue posible agregar el registro de compra SMS.");  
            }
        });        
    }   


    $(document).ready(function(){
         $("#id_empresa_base").change(function(){ VerPagos( $("#id_empresa_base").val() ); });
         VerPagos( $("#id_empresa_base").val() );

         //Selecciona menu
         $("#mnu_licencias").addClass("selectMenu");

         //Selecciona contenedor de pago
         $("body").on("click",".contenedor",function(e){
            e.preventDefault();

            if(auxClic==false){
                if( $(this).attr("data-status")=="Pendiente" || $(this).attr("data-status")=="Pago Incorrecto" ){
                    if( $(this).hasClass("selPendiente") ){
                        $(this).removeClass("selPendiente");
                    } else {                              
                        $(this).addClass("selPendiente");
                    }
                }

                habilitBtnCarga();
            }
            auxClic=false;

         });

        //Selecciona para cargar comprobante
        $("#btn_cargar_comp").click(function(e){
            e.preventDefault();

            if(!$(this).hasClass("btnDisabled")){
                preload(true);

                var ids="";
                $(".selPendiente").each(function(){ ids+= $(this).attr("data-id") + "|"; });
                $("#ids_registros").val(ids);

                var params={};            
                params.index="2"; 
                params.ids=$("#ids_registros").val(); 
                $('#divContenCargDoc').load("php/cmd_comandos_pagos.php", params,function(resp){                               
                    preload(false); 
                    $('#myModal').modal('show');
                    $("#btn_registrar_pago").addClass("disabled");
                    
                    //-------- Carga dinámica de comprobante de pago --------------

                    var myDropzone = new Dropzone("#formSub", { 
                    url: "php/upload_comprobante_pago.php",
                    dictDefaultMessage: "Clic aquí para cargar el comprobante",
                    uploadMultiple: false,
                    accept: function(file, done) {
                            if (file.type != "image/jpeg" && file.type != "application/pdf" && file.type != "image/png" && file.type != "image/jpg" && file.type != "image/bmp"){
                                  done("Error! Tipo de archivo no aceptado.");
                            }
                            else { done(); }
                        }
                    });  

                    myDropzone.on("sending",function(file,xhr,data){
                        data.append("ids_registros",$("#ids_registros").val());
                    });

                    myDropzone.on("success",function(file, response,done){ 
                        if(response != "1"){ alert(response); myDropzone.removeAllFiles(); } else {
                            veriUploadFile();
                        }
                    });


                });                
            }                      
        }); 


        //Boton Registrar pago
        $("#btn_registrar_pago").click(function(){
            if(!$(this).hasClass("disabled")){ 
                if(!confirm("¿Esta seguro que la información proporcionada es correcta? \n\n Su pago será enviado a validación, en caso de error en el registro su cuenta se vera temporalmente afectada. \n\nPulse 'Aceptar' para registrar el pago")) return;
                acceptPago(); 
            }
        });      

        //Visualiza Comprobante de pago
        $("body").on("click",".viewComp",function(e){
            e.preventDefault();
            auxClic=true;
            var params={};            
            params.index="14";
            params.id_control_cobros=$(this).attr("data-id");
            preload(true);
            $('#divVizCompPag').load("../configuracion/recursos/php/cmd_comandos_pagos.php", params,function(resp){
                preload(false);
                $('#myModal_viz').modal('show');
                if( $("#tipoFile").val()==".pdf" ){
                    $("#lienzoPdf").css("height","300px");
                }
            });   
        });

        //Boton Instrucciones
        $("#btn_instrucciones").click(function(e){
            e.preventDefault(); 
            if(!$(this).hasClass("btnDisabled")){ 
                vizInstrucciones($("#ban_iva").val());
            }
        }); 

        //Boton comprar creditos SMS        
        $("#btn_carga_sms").click(function(e){
            e.preventDefault(); 
            vizSucCredSMS();
        });

        $("body").on("change",".cred_sms",function(){
              var sumaCred=0;
              $(".cred_sms").each(function(){ if( $(this).val() != "" ){ sumaCred+=parseInt($(this).val()); } });
              if(sumaCred==0){
                 $("#tituloCompraSMS").html("Comprar créditos SMS");
              } else {
                 $("#tituloCompraSMS").html("Comprar " + sumaCred + " créditos SMS = <font color='#08298A'><b>$" + format(sumaCred * costoSMS) + "</b></font>" );
              }
              
        }); 

        //Botón Agregar créditos
        $("#btnAgregarCreditos").click(function(){

              //Valida que haya seleccionado al menos un credito
              var selecOnl=false;
              $(".cred_sms").each(function(){if($(this).val() != ""){ selecOnl=true; }});  
              if(selecOnl==false){
                 alert("La cantidad no puede ser cero 0");
                 return;                 
              }

              funcAddPagoSMS();
        }); 

        $("body").on("click",".cancelProgSMS",function(e){
             e.preventDefault();
             auxClic=true;
             cancelProgSMS( $(this).attr("data-id") );   
        });         


        //---------- Mensaje de pago completo ------------
        <?php
              if(isset($_SESSION["pagoCompleto"])){
                  unset($_SESSION["pagoCompleto"]);                  
                  echo "$('#myModal_pagComp').modal('show');";
              }              
        ?>  

    });     
 		
</script>

<?php 
   // MENSAJE DE VENCIMIENTO DE PAGO
   if($ban_adeuda_licencia){
      echo "<section id='msgLicencia'>".utf8_decode($_SESSION["msg_blk"])."</section>";
   }    
?>

<div id="idContenedor">
   <center>
       <div id="btn_carga_sms" title="Comprar créditos SMS">
           <table>
                 <tr>
                     <td><img src="img/sms.png">&nbsp;</td>
                     <td><label id="nCredit">-</label></td>
                     <td>&nbsp;&nbsp;</td>
                     <td>&nbsp;&nbsp;</td>
                     <td>&nbsp;Comprar Créditos SMS&nbsp;</td>                     
                 </tr>
           </table>              
       </div>
       <div style="clear: both;"></div>
       <div id="mnuDescPagos"></div> 
   </center>  
</div>

<section id="cmdPie">
    <div id="btn_cargar_comp" class="cmd_btn_pie btnDisabled" style="width: 60%">
         <img src="img/subir_archivo.png"><br>
         <label>Cargar Comprobante</label>
    </div>
    <div id="btn_instrucciones" class="cmd_btn_pie" style="width: 30%">
         <img src="img/informacion.png"><br>
         <label>Cuenta Bancaria</label>
    </div>    
</section>


<input type="hidden" id="ids_registros" value="">

<!-- Modal Cargar Comprobante de Pago -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Cargar comprobante de pago</h4>
      </div>
      <div id="divContenCargDoc" class="modal-body">        
      </div>
      <div class="modal-footer">
        <button id="btn_registrar_pago" type="button" class="btn btn-primary disabled">REGISTRAR PAGO</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
      </div>
    </div>

  </div>
</div>

<!-- Modal Visualizar Comprobante de Pago -->
<div id="myModal_viz" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Consultar comprobante de pago</h4>
      </div>
      <div id="divVizCompPag" class="modal-body">        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
      </div>
    </div>

  </div>
</div>

<!-- Modal Visualizar Instrucciones para pago -->
<div id="myModal_instruc" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Instrucciones para pago</h4>
      </div>
      <div id="divInstruccionesPago" class="modal-body">        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
      </div>
    </div>

  </div>
</div>

<!-- Modal Pago completo -->
<div id="myModal_pagComp" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Comprobante recibido</h4>
      </div>
      <table>
          <tr>
              <td>&nbsp;&nbsp;&nbsp;</td>
              <td><img src="img/ok.ico" style="width: 5em"></td>
              <td>&nbsp;&nbsp;&nbsp;</td>
              <td><h3 style="font-size: 1.3em">Estimado cliente, hemos recibido su comprobante correctamente.</h3></td>
          </tr>
      </table>      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
      </div>
    </div>

  </div>
</div>

<!-- Modal Creditos SMS -->
<div id="myModal_CredSMS" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="tituloCompraSMS">Comprar créditos SMS</h4>
      </div>
      <article id="divSucCredSMS"></article>      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        <button id="btnAgregarCreditos" type="button" class="btn btn-default"><b>AGREGAR</b></button>        
      </div>
    </div>

  </div>
</div>    

    
    

<?php include_once("php/piepagina.php"); ?>