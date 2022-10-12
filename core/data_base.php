<?php


  // Devuelve 'inline-block' si el id se encuentra dentro de los privilegios
  // generales del sistema.   
  include_once("funciones_privilegios.php");

  function cerosIzq($valor,$cant){
       $retu=$valor;
       if($valor != ""){
           for($e=strlen($valor);$e <=$cant;$e++ ){ $retu="0".$retu; }
       }
       return $retu;
  }

  #---- Visualiza Objetos en el formulario -----
  function val($type,$obj,$ref,$type2="text"){
                if(isset($obj)){
                   if( strtolower($type)=="input"){  
                    if($type2=="text"){
                        return " value='".$obj."' "; 
                    }elseif ($type2=="float" || $type2=="double") {
                        if( (float)$obj==0 ){
                           return " value='' ";
                        } else {
                           return " value='".number_format((float)$obj,2,".",",")."' ";
                        }   
                    }
                  }
                   if( strtolower($type)=="select"){ 
                     if($obj==$ref){ return " selected "; }  
                     if($ref=="1" && $obj=="SI"){ return " selected "; }
                     if($ref=="0" && $obj=="NO"){ return " selected "; }
                   }
                   if( strtolower($type)=="textarea"){ return trim($obj); }
                   if( strtolower($type)=="checkbox"){ if($obj=="1" || $obj=="SI"){ return " checked ";} }
                   
                } else {
                    if( strtolower($type)=="checkbox"){ if($ref=="1" || $obj=="SI"){ return " checked ";} }

                    return "";
                }
  }

//---Añade la validación para que acepte solo numeros ---
function AddValidaNumero($id_objeto,$tipo="#",$area="body",$retu = false){
    $comand = '<script> $(document).ready(function(){ $("'.$area.'").on("focusout","'.$tipo.$id_objeto.'",function(){ var idObj=$(this).attr("id"); if(isNaN(num($("#" + idObj).val()))==true){ $("#" + idObj).val("0.00"); } else { var numero=num($("#" + idObj).val()); $("#" + idObj).val(format(numero)); } }); $("'.$area.'").on("focusin","'.$tipo.$id_objeto.'",function(){ var idObj=$(this).attr("id"); var numero=num($("#" + idObj).val()); if(isNaN(numero)==true){ $("#" + idObj).val("0"); } else { $("#" + idObj).val(numero); } this.select(); }); }); </script>';          
    if($retu){ return $comand; } else { echo $comand; }
}


//---Añade la validación para que acepte solo numeros ---
function AddValidaNumero2($id_objeto){
    echo ' 
      <script>
           $(document).ready(function(){
              $("#'.$id_objeto.'").focusout(function(){
                  if(isNaN(num($("#'.$id_objeto.'").val()))==true){ $("#'.$id_objeto.'").val("0.00");  } else { var numero=num($("#'.$id_objeto.'").val()); $("#'.$id_objeto.'").val(format(numero)); }
              });  
              $("#'.$id_objeto.'").focusin(function(){
                  var numero=num($("#'.$id_objeto.'").val());
                  if(isNaN(numero)==true){ $("#'.$id_objeto.'").val("0");  } else { $("#'.$id_objeto.'").val(numero); }
                  this.select();
              });               
           });
      </script>';          
}

/*Obtiene la IP del visitante*/
function getRealIP(){ 
   if( $_SERVER['HTTP_X_FORWARDED_FOR'] != '' )
   {
      $client_ip = 
         ( !empty($_SERVER['REMOTE_ADDR']) ) ? 
            $_SERVER['REMOTE_ADDR'] 
            : 
            ( ( !empty($_ENV['REMOTE_ADDR']) ) ? 
               $_ENV['REMOTE_ADDR'] 
               : 
               "unknown" );
      $entries = preg_split('/[, ]/', $_SERVER['HTTP_X_FORWARDED_FOR']);
 
      reset($entries);
      while (list(, $entry) = each($entries)) 
      {
         $entry = trim($entry);
         if ( preg_match("/^([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)/", $entry, $ip_list) )
         {
            // http://www.faqs.org/rfcs/rfc1918.html
            $private_ip = array(
                  '/^0\./', 
                  '/^127\.0\.0\.1/', 
                  '/^192\.168\..*/', 
                  '/^172\.((1[6-9])|(2[0-9])|(3[0-1]))\..*/', 
                  '/^10\..*/');
 
            $found_ip = preg_replace($private_ip, $client_ip, $ip_list[1]);
 
            if ($client_ip != $found_ip)
            {
               $client_ip = $found_ip;
               break;
            }
         }
      }
   } else{
      $client_ip = 
         ( !empty($_SERVER['REMOTE_ADDR']) ) ? 
            $_SERVER['REMOTE_ADDR'] 
            : 
            ( ( !empty($_ENV['REMOTE_ADDR']) ) ? 
               $_ENV['REMOTE_ADDR'] 
               : 
               "unknown" );
   }
 
   return $client_ip;
}

function intStrMes($intmes){
    switch ((int)$intmes) {
      case 1: return "Enero"; break;
      case 2: return "Febrero"; break;
      case 3: return "Marzo"; break;
      case 4: return "Abril"; break;
      case 5: return "Mayo"; break;
      case 6: return "Junio"; break;
      case 7: return "Julio"; break;
      case 8: return "Agosto"; break;
      case 9: return "Septiembre"; break;
      case 10: return "Octubre"; break;
      case 11: return "Noviembre"; break;
      case 12: return "Diciembre"; break;      
      default: return $intmes; break;
    }
}

class Grid{

      public $color_fondo_encabezado;
      public $posi_campo_id;

      protected $HtmlEncabezado;    
      protected $styleColumnas=array();  
      protected $listFormat=array();  
      protected $listIds=array(); 
      protected $indiceColumnas;
      protected $html_corp;
      protected $cont;
      protected $varHead;
      protected $ColorFilaPar;
      protected $ColorFilaInpar;    
      protected $ColorFondoEncabezado;
      protected $ColorTextoEncabezado;
      protected $idTabla;
      protected $repitHead;
      protected $ListAtributos;
      protected $Attribs;
      protected $NombreObjeto;
      protected $CaptionCampoOrderBy;

      function Grid($NombreObjeto="Grid1"){
          $this->HtmlEncabezado='';
          $this->color_fondo_encabezado='#F2F2F2';
          $this->posi_campo_id=0;
          $this->indiceColumnas=-1;
          $this->html_corp='';
          $this->cont=0;
          $this->varHead='';
          $this->ColorFilaPar='#F2F2F2';
          $this->ColorFilaInpar='white';    
          $this->ColorFondoEncabezado="#999999";
          $this->ColorTextoEncabezado="#333333";
          $this->idTabla="";
          $this->repitHead=0;
          $this->ListAtributos="";
          $this->Attribs=false;
          $this->NombreObjeto=$NombreObjeto;
          $this->CaptionCampoOrderBy="";

      }
      function setAttrib($trueoFalse){
          $this->Attribs=$trueoFalse;
      }
      function setRepitHead($periocidad){
          $this->repitHead=$periocidad;
      }
      function setIdGrid($NuevoNombre){
          $this->idTabla=$NuevoNombre;
      }
      function setColorFilaPar($nuevoColor){
          $this->ColorFilaPar=$nuevoColor;
      }
      function setColorFilaInpar($nuevoColor){
          $this->ColorFilaInpar=$nuevoColor; 
      }      

      function setColorFondoEncabezado($nuevoColor){
          $this->ColorFondoEncabezado=$nuevoColor;
      }
      function setColorTextoEncabezado($nuevoColor){
          $this->ColorTextoEncabezado=$nuevoColor; 
      } 

      //Resalta el encabezado por el que se ordenan
      function setOrderBy($campoOrderby){
          $this->CaptionCampoOrderBy=$campoOrderby;
      }

      function addColumna($caption,$style,$format="text"){

          # $format = { "text","money" }

          $this->indiceColumnas+=1;

          if($format != "attr"){
             $order="";
             if($this->CaptionCampoOrderBy==$caption){ $order=' class="SeleccionOrder" '; }
             $this->HtmlEncabezado.='<th data-caption="'.$caption.'" '.$order.' style="background-color:'.$this->ColorFondoEncabezado.'; color:'.$this->ColorTextoEncabezado.';">'.$caption.'</th>';
          }

          $this->styleColumnas[$this->indiceColumnas]=$style;   //Guarda estilo de la columna
          $this->listFormat[$this->indiceColumnas]=$format;
          $this->listIds[$this->indiceColumnas]=str_replace(" ", "", $caption);
      }


      function addDetalleCuerpo($datos_text=array(),$echo_content=true){
               $this->cont+=1;

               #Calculo del color de fondo
               if( ($this->cont % 2)==0 ){ $colorf= $this->ColorFilaPar; } else { $colorf= $this->ColorFilaInpar; }                   

               #Obtiene lista de Atributos               
               $listAtt="";
               if($this->Attribs){
                 for($i=0;$i<=$this->indiceColumnas;$i++){                                        
                    $listAtt.="data-".$this->listIds[$i].'="'.str_replace('"', "'", $datos_text[ $i ]).'" ';
                 } 
               } 

               #Obtiene lista de Campos tipo atributo que iran en todos los td               
               $listCampHidd="";
               for($i=0;$i<=$this->indiceColumnas;$i++){
                    if($this->listFormat[$i] == "attr"){
                       $listCampHidd.= " ".$this->listIds[ $i ].'='.'"'.$datos_text[ $i ].'"';
                    }
               }

               $this->html_corp='<tr '.$listAtt.' data-bakcolor="'.$colorf.'" style="background-color:'.$colorf.';">';
               for($i=0;$i<=$this->indiceColumnas;$i++){
                    
                    //A las celdas donde van comandos no se aplican atributos
                    $setAtt=$listCampHidd;
                    if($this->listFormat[$i] == "cmd"){ $setAtt=""; }

                    if($this->listFormat[$i] == "money" ){ 
                      $this->styleColumnas[$i]="text-align:right; color:#0404B4;"; 
                      if((float)$datos_text[$i] > 0){ $datos_text[ $i ]=number_format($datos_text[$i],2,".",",")."&nbsp;&nbsp;&nbsp;"; } else { $datos_text[ $i ]="-&nbsp;&nbsp;&nbsp;"; }
                    }

                    if($this->listFormat[$i] != "attr"){                       
                       $this->html_corp.='<td '.$setAtt.' style="'.$this->styleColumnas[$i].'" >'.$datos_text[ $i ].'</td>';
                    }
               }

               $this->html_corp.='</tr>';

               if($echo_content){ echo $this->html_corp; } else { return $this->html_corp; }

      }

      function Show($matriz=array(),$echo_content=true){

          $retu="";

          #Encabezado
          $this->varHead='<thead><tr style="background-color:'.$this->color_fondo_encabezado.'; cursor:normal;">'.$this->HtmlEncabezado.'</tr></thead>';

          if( $this->idTabla=="" ){
              $retu.= '<table class="tablaLista '.$this->NombreObjeto.'">'.$this->varHead.'<tbody>';
          } else {
              $retu.= '<table id="'.$this->idTabla.'" class="tablaLista '.$this->NombreObjeto.'">'.$this->varHead.'<tbody>';
          }    

          $datos_text=array();

          #Cuerpo

          $this->cont=0;
          for($i=0;$i< count($matriz);$i++){
                for($col=0;$col<=$this->indiceColumnas;$col++){                    
                    if(isset($matriz[$i][$col])){
                       $datos_text[$col]=$matriz[$i][$col];
                    }
                }   

               /*Repite encabezado*/   
               if( $this->repitHead > 0 && $i >0 && (int)($i % $this->repitHead)==0 ) {
                  $retu.= $this->varHead;
               }           

               if(isset($matriz[$i][0])){
                  $retu.= $this->addDetalleCuerpo($datos_text,false);
               }                  
          }        
        
          #Cierre
          $retu.= '</tbody></table>';

          if($echo_content){ echo $retu; } else { return $retu; }
  
      }
  }  


  class GridData{

      public $color_fondo_encabezado;
      public $posi_campo_id;

      protected $orderBy;
      protected $HtmlEncabezado;    
      protected $styleColumnas=array();  
      protected $listNames=array();  
      protected $listFormat=array();  
      protected $listCondition=array();  
      protected $sumTotales=array(array(),array());
      protected $indSumCol;
      protected $indiceColumnas;
      protected $campoId;
      protected $repitHead;
      protected $html_corp;
      protected $cont;
      protected $varHead;
      protected $ColorFilaPar;
      protected $ColorFilaInpar;    
      protected $ColorFondoEncabezado;
      protected $ColorTextoEncabezado;
      protected $handel;
      protected $encoding;
      protected $nomensaNone;
      protected $search=array();
      protected $replace=array();
      protected $ban_replace;
      public $campo_check;
      protected $title_check;
      protected $ColClasificacion;
      protected $varAux;
      protected $NombreObjeto;
      protected $ColsAtribute;
      protected $codeHtmlObj;
      protected $eqTimeDuration;

      function GridData($NombreObjeto="GridData1"){
          $this->codeHtmlObj="";
          $this->indSumCol=-1;
          $this->campo_check=false;
          $this->title_check="";
          $this->orderBy='';
          $this->HtmlEncabezado='';
          $this->color_fondo_encabezado='#F2F2F2';
          $this->posi_campo_id=0;
          $this->indiceColumnas=-1;
          $this->campoId="id";
          $this->repitHead=-1;
          $this->html_corp='';
          $this->cont=0;
          $this->varHead='';
          $this->ColorFilaPar='#F2F2F2';
          $this->ColorFilaInpar='white';    
          $this->ColorFondoEncabezado="#999999";
          $this->ColorTextoEncabezado="#333333";
          $this->handel="0";
          $this->encoding=false;
          $this->nomensaNone=true;
          $this->ban_replace=false;
          $this->ColClasificacion="";
          $this->varAux='';
          $this->NombreObjeto=$NombreObjeto;
          $this->ColsAtribute=true;          

          //Genera Valores de tiempo para
          $this->eqTimeDuration=array();

          if( (int)$_SESSION["handel"] <=0 ){ $_SESSION["minutos_incremento"]=60; }

          $ind=1;
          $hora=0;
          $banEnt=false;
          while( $hora < 24 ){
              $minuto=(int)$_SESSION["minutos_incremento"];
              while ( $minuto <= 60) {
                    if($minuto <=9 ){ $strMinuto="0".$minuto; } else { $strMinuto=$minuto; }                                                                                                        
                    if( $minuto==60 ){ $hora++; $strMinuto="00"; $banEnt=true; }
                    if($hora <=9 ){ $strHora="0".$hora; } else { $strHora=$hora; } 
                    if($hora==0){ $lbl="m"; } else { $lbl="h"; }

                    if($strMinuto=="00" && $ind > 1 && (int)$_SESSION["minutos_incremento"] < 60 ){ $agStyl=' style="color:red;" '; } else { $agStyl=''; }                                                    

                    $this->eqTimeDuration[(int)$ind]=$strHora.":".$strMinuto.' '.$lbl;

                    $ind++;
                    $minuto=$minuto + (int)$_SESSION["minutos_incremento"];
             }

             if($banEnt==false){$hora++;}
             $banEnt=false;
          }          
      }


      function sumTotales($vectorColums){
          $this->indSumCol=count($vectorColums);
          for($i=0;$i<count($vectorColums);$i++){
               if( trim($vectorColums[$i]) != "" ){
                 $this->sumTotales[$i][0]=$vectorColums[$i];
                 $this->sumTotales[$i][1]="0";
               }   
          }
      }
      function setColsAtrib($trueoFalse){
           $this->ColsAtribute=$trueoFalse;
      }      
      function setClasificacion($campoClasificacion){
           $this->ColClasificacion=$campoClasificacion;
      }
      function setCheck($titulo){
           $this->campo_check=true;
           $this->title_check=$titulo;
      }        
      function setReplace($search,$replace){
           $this->search[]=$search;
           $this->replace[]=$replace;
           $this->ban_replace=true;
      } 
      function setShowHead($trueoFalse){
           $this->nomensaNone=$trueoFalse;
      }
      function setEncoding($trueoFalse){
           $this->encoding=$trueoFalse;
      }
      function setCampoHandel($campohandel){
          $this->handel=$campohandel;
      }

      function setOrderBy($campoOrderby){
          $this->orderBy=$campoOrderby;
      }

      function setCampoId($campoId){
          $this->campoId=$campoId;
      }

      function setRepitHead($periocidad){
          $this->repitHead=$periocidad;
      }

      function setColorFilaPar($nuevoColor){
          $this->ColorFilaPar=$nuevoColor;
      }
      function setColorFilaInpar($nuevoColor){
          $this->ColorFilaInpar=$nuevoColor; 
      }      

      function setColorFondoEncabezado($nuevoColor){
          $this->ColorFondoEncabezado=$nuevoColor;
      }
      function setColorTextoEncabezado($nuevoColor){
          $this->ColorTextoEncabezado=$nuevoColor; 
      } 

      function addColumna($name,$caption,$style,$format="text",$condicion=""){

          # $format = { "text","money" }

          $this->indiceColumnas+=1;

          $order=''; 
          if($this->orderBy==$name){ $order=' class="SeleccionOrder" '; }
          $hidden="";
          if($format=="oculto"){ $hidden="display:none;"; }
          $this->HtmlEncabezado.='<th '.$order.' style="background-color:'.$this->ColorFondoEncabezado.'; color:'.$this->ColorTextoEncabezado.';'.$hidden.'" data-handel="'.$this->handel.'" data-order="'.$name.'">'.$caption.'</th>';

          $this->styleColumnas[$this->indiceColumnas]=$style.$hidden;   //Guarda estilo de la columna
          $this->listNames[$this->indiceColumnas]=$name;
          $this->listFormat[$this->indiceColumnas]=$format;
          $this->listCondition[$this->indiceColumnas]=$condicion;
      }


      function addDetalleCuerpo($datos_text){
               $this->cont+=1;

               #Calculo del color de fondo
               if( ($this->cont % 2)==0 ){ $colorf= $this->ColorFilaPar; } else { $colorf= $this->ColorFilaInpar; }                   

               //Obtiene listado de atributos
               $ListAtributos="";
               if($this->ColsAtribute){
                   for($i=0;$i<=$this->indiceColumnas;$i++){
                       $ListAtributos.=' data-'.$this->listNames[$i].'="'.utf8_encode($datos_text[ $this->listNames[$i] ]).'"';
                   }
               }

               
               //Coloca clasificacion
               if($this->varAux=="" && $this->ColClasificacion != "" ){
                  if( $datos_text[ $this->ColClasificacion ]=="" ){
                      $this->varAux="<center>--- SIN CLASIFICACI&Oacute;N ---</center>";
                  } else {
                      $this->varAux=$datos_text[ $this->ColClasificacion ];
                  }    

                  if($this->encoding){ $textTit=utf8_encode($this->varAux); } else { $textTit=$this->varAux; }                        

                  $tmp= "</tbody><thead><tr style='background-color:white; color:#1C1C1C;'><th colspan='".($this->indiceColumnas + 2)."'><center><h3>".$textTit."</h3></center></th></tr></thead>".$this->varHead."<tbody>";
                  $this->codeHtmlObj.=$tmp;
                  echo $tmp;
               }
               if($this->ColClasificacion != "" &&  $datos_text[ $this->ColClasificacion ] != "" ){
                   if( $this->varAux != $datos_text[ $this->ColClasificacion ] ){
                        $this->varAux= $datos_text[ $this->ColClasificacion ];
                        if($this->encoding){ $textTit=utf8_encode($this->varAux); } else { $textTit=$this->varAux; }
                        $tmp= "</tbody><thead><tr style='background-color:white; color:#1C1C1C;'><th colspan='".($this->indiceColumnas + 2)."'><center><h3>".$textTit."</h3></center></th></tr></thead>".$this->varHead."<tbody>";
                        $this->codeHtmlObj.=$tmp;
                        echo $tmp;                        
                   }
               }


               $this->html_corp='<tr data-handel="'.$this->handel.'" data-id="'.$datos_text[ $this->campoId ].'" data-bakcolor="'.$colorf.'" style="background-color:'.$colorf.';">';
               for($i=0;$i<=$this->indiceColumnas;$i++){

                    /*Condiciona un dato dependiendo del valor de otra columna*/
                    if(trim($this->listCondition[$i]) != ""){
                        $vecCond=explode("|", $this->listCondition[$i]);
                        if( count($vecCond)==2 ){
                          if( $vecCond[1]=="==numeric" && is_numeric($datos_text[ $vecCond[0] ])==false ){ 
                            if( $this->listFormat[$i]=="money" ){ $datos_text[ $this->listNames[$i] ]="0.00"; } else { $datos_text[ $this->listNames[$i] ]=""; } 
                          }
                          if( $vecCond[1]=="!=numeric" && is_numeric($datos_text[ $vecCond[0] ])==true ){ 
                            if( $this->listFormat[$i]=="money" ){ $datos_text[ $this->listNames[$i] ]="0.00"; } else { $datos_text[ $this->listNames[$i] ]=""; } 
                          }
                          if( $vecCond[1]=="==null" && trim($datos_text[ $vecCond[0] ])=="" ){ 
                            if( $this->listFormat[$i]=="money" ){ $datos_text[ $this->listNames[$i] ]="0.00"; } else { $datos_text[ $this->listNames[$i] ]=""; } 
                          }                          
                          if( $vecCond[1]=="!=null" && trim($datos_text[ $vecCond[0] ]) != "" ){ 
                            if( $this->listFormat[$i]=="money" ){ $datos_text[ $this->listNames[$i] ]="0.00"; } else { $datos_text[ $this->listNames[$i] ]=""; } 
                          }                                                    
                        }
                    }

                    #Codifica signos especiales
                    if($this->encoding){
                       $datos_text[ $this->listNames[$i] ]= utf8_encode($datos_text[ $this->listNames[$i] ]);
                    } else {
                       $datos_text[ $this->listNames[$i] ]= $datos_text[ $this->listNames[$i] ];
                    }   
                    
                    #Formato de duración de tiempo                    
                    if( $this->listFormat[$i]=="time_duration" ){ $datos_text[ $this->listNames[$i] ]= $this->eqTimeDuration[ $datos_text[$this->listNames[$i]] ]; }

                    #Establece formato folio con ceros a la izquierda
                    if( $this->listFormat[$i]=="folio" ){ $datos_text[ $this->listNames[$i] ]= cerosIzq($datos_text[ $this->listNames[$i] ],4); }

                    #Establece formato de texto
                    if( $this->listFormat[$i]=="money" ){ $datos_text[ $this->listNames[$i] ]= number_format((float)$datos_text[ $this->listNames[$i] ],2,".",","); }

                    #Establece formato color
                    if( $this->listFormat[$i]=="color" ){ $datos_text[ $this->listNames[$i] ]= "<div style='background-color:".$datos_text[ $this->listNames[$i] ]."; width:1.5em; height:1.5em; display:inline-block;'></div>"; }

                    #Establece formato de fecha
                    if( $this->listFormat[$i]=="date" && $datos_text[ $this->listNames[$i] ] != "" ){ 
                        if( $datos_text[ $this->listNames[$i] ]=="0000-00-00" || $datos_text[ $this->listNames[$i] ]=="00-00-0000"){
                            $datos_text[ $this->listNames[$i] ]="-";
                        } else {
                            $datos_text[ $this->listNames[$i] ] = date('d-m-Y', strtotime($datos_text[ $this->listNames[$i] ])); 
                        }  
                    }

                    #Establece formato de fecha y hora
                    if( $this->listFormat[$i]=="datetime" ){ 
                        if($datos_text[ $this->listNames[$i] ]=="0000-00-00 00:00:00"){
                            $datos_text[ $this->listNames[$i] ]="-";
                        } else {
                            $datos_text[ $this->listNames[$i] ] = date('d-m-Y H:i', strtotime($datos_text[ $this->listNames[$i] ])); 
                        }  
                    }

                    #Establece formato de fecha e cumpleaño
                    if( $this->listFormat[$i]=="fcumple" && strlen($datos_text[ $this->listNames[$i] ])==5 ){ 
                            $fech=$datos_text[ $this->listNames[$i] ];
                            $datos_text[ $this->listNames[$i] ]= substr($fech, 0,2)." de ".intStrMes(substr($fech, 3,2));
                    }
                     // -- Remplazar texto --  
                     if($this->ban_replace){
                          for($j=0;$j < count($this->search);$j++ ){
                              if( $this->search[$j]== $datos_text[ $this->listNames[$i] ]){ 
                                $datos_text[ $this->listNames[$i] ]=$this->replace[$j];  
                              }
                          }
                     }

                    /*Suma columnas especificadas*/ 
                    for($col=0; $col <= $this->indSumCol-1; $col++){
                         if( $this->sumTotales[$col][0] == $this->listNames[$i]){
                             $this->sumTotales[$col][1]= (float)$this->sumTotales[$col][1] + (float)str_replace(array(",","'"), array("",""),$datos_text[$this->listNames[$i]]);
                         }
                    }

                    $this->html_corp.='<td col-name="'.$this->listNames[$i].'" style="'.$this->styleColumnas[$i].'" '.$ListAtributos.' data-reg="'.$datos_text[ $this->campoId ].'">'.$datos_text[ $this->listNames[$i] ].'</td>';
               }

               if($this->campo_check){
                   $this->html_corp.='<th style="text-alight:center">
                      <center><input type="checkbox" data-handel="'.$this->handel.'" data-id="'.$datos_text[ $this->campoId ].'" id="check_'.$datos_text[ $this->campoId ].'"></center>
                   </th>';
               }

               /*controlador para cancelaciones*/
               $this->html_corp.='<th data-handel="'.$this->handel.'" data-id="'.$datos_text[ $this->campoId ].'" id="cancel_'.$datos_text[ $this->campoId ].'" title="Cancelar Registro"></th></tr>';

               $tmp= $this->html_corp;
               $this->codeHtmlObj.=$tmp;
               echo $tmp;                                       

               //Repite encabezado
               if($this->repitHead > 0 && $this->ColClasificacion==""){
                  if( ($this->cont % $this->repitHead)==0 ){
                     $tmp= "</tbody>".$this->varHead."<tbody>";
                     //$this->codeHtmlObj.=$tmp;
                     echo $tmp;                                       
                  }
               }        
      }

      function getCodeHTML(){ return $this->codeHtmlObj; }

      function Show($coneccion){

          #Detecta check
          if($this->campo_check){
             $this->HtmlEncabezado.='<th style="background-color:'.$this->ColorFondoEncabezado.'; color:'.$this->ColorTextoEncabezado.';"><center>'.$this->title_check.'</center></th>';
          }   

          #Encabezado
          $this->varHead='<thead><tr style="background-color:'.$this->color_fondo_encabezado.'; cursor:normal;">'.$this->HtmlEncabezado.'<th style="background-color:'.$this->ColorFondoEncabezado.'; color:'.$this->ColorTextoEncabezado.';"></th></tr></thead>';
          if($this->nomensaNone && $this->ColClasificacion==""){
              $tmp= '<table class="tablaLista '.$this->NombreObjeto.'">'.$this->varHead.'<tbody>';
              $this->codeHtmlObj.=$tmp;
              echo $tmp;                                                     
          } else {
              $tmp= '<table class="tablaLista '.$this->NombreObjeto.'"><tbody>';
              $this->codeHtmlObj.=$tmp;
              echo $tmp;                                                                   
          }

          switch ($coneccion->coneccion->manejador){
            case 'SQL Server':                        
                          #Cuerpo
                          $this->cont=0;
                          while ($datos_text = odbc_fetch_array($coneccion->getResults())) {
                              $this->addDetalleCuerpo($datos_text);
                          };        
              break;
            case 'MySQL':
                          #Cuerpo
                          $this->cont=0;
                          while ($datos_text = mysqli_fetch_array($coneccion->getResults())) {
                              if(isset($datos_text["tel1"])){ $datos_text["tel1"]=str_replace(array('(',')','-',' '), array('','','',''), $datos_text["tel1"]); }
                              if(isset($datos_text["tel1"])){ $datos_text["tel2"]=str_replace(array('(',')','-',' '), array('','','',''), $datos_text["tel2"]); }
                              $this->addDetalleCuerpo($datos_text);
                          };        
              break;          
          }

          /*Añade totales*/
          if($this->indSumCol > 0){
              $codHtml=""; 
              for($i=0;$i<=$this->indiceColumnas;$i++){                 
                  $codHtml.='<td style="'.$this->styleColumnas[$i].'">['.$this->listNames[$i].']</td>';
              }     

              $codHtml.='<th></th></tr>';

              //Reemplaza Totales
              for($col=0; $col <= $this->indSumCol-1; $col++){
                  $codHtml=str_replace( "[".$this->sumTotales[$col][0]."]" ,"<b>".number_format( $this->sumTotales[$col][1],2,".",",")."</b>" , $codHtml);
              }

              $codHtml=str_replace( "<b>0.00</b>" , "" , $codHtml);

              //Quita columnas innecesarias
              for($i=0;$i<=$this->indiceColumnas;$i++){ 
                  $codHtml=str_replace( "[".$this->listNames[$i]."]" , "" , $codHtml);
              }

              $tmp= $codHtml;
              $this->codeHtmlObj.=$tmp;
              echo $tmp;                                                                                 
          }

        
          #Cierre
          $tmp= '</tbody></table>';
          $this->codeHtmlObj.=$tmp;
          echo $tmp;                                                                                 

      }

  }  

//Convierte a url válida
 function a_url($title_article){

            //Convierte a minúscula
            $title_article = utf8_decode($title_article);
            $link_articulo = mb_strtolower($title_article, 'UTF-8');

            //Quita caracteres invalidos
            $invalidos=array('   ','  ',' ','á', 'à', 'ä', 'â', 'ª',"å","ã","Å","Ã" ,'Á', 'À', 'Â', 'Ä','é', 'è', 'ë', 'ê', 'É', 'È', 'Ê', 'Ë','í', 'ì', 'ï', 'î', 'Í', 'Ì', 'Ï', 'Î','ó', 'ò', 'ö', 'ô',"õ","ø","ÿ","Ø","Õ", 'Ó', 'Ò', 'Ö', 'Ô','ú', 'ù', 'ü', 'û', 'Ú', 'Ù', 'Û', 'Ü','ñ', 'Ñ', 'ç', 'Ç',"\\", "¨", "º", "~","#", "@", "|", "!", '"',"·", '$', '%', '&', '/','(', ')', '?', "'", "¡","¿", "[", "^", "<code>", "]","+", "}", "{", "¨", "´",">", "<", ";", ",", ":",".");
            $validos=array(' ',' ','-','a', 'a', 'a', 'a', 'a',"a","a", "A",'A' ,'A', 'A', 'A', 'A','e', 'e', 'e', 'e', 'E', 'E', 'E', 'E','i', 'i', 'i', 'i', 'I', 'I', 'I', 'I','o', 'o', 'o', 'o',"o","o","y","O","O", 'O', 'O', 'O', 'O','u', 'u', 'u', 'u', 'U', 'U', 'U', 'U','n', 'N', 'c', 'C',"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","");
            for($i=0;$i<count($invalidos);$i++){
                  $link_articulo=str_replace( $invalidos[$i], $validos[$i], $link_articulo);
            }     

            //Quita doble y triple guión
            $link_articulo=str_replace( array('--','---','----','.','…'),array('-','-','-','',''),$link_articulo );

            return $link_articulo;
}


#############################################################################
//            RETORNA EL EQUIVALENTE DE UNA IMAGEN EN base64
#############################################################################
        /*
            Ejemplo: '<img src="'.img64().'" />'            
        */

        function img64($path){
            if(!file_exists($path)) return '';
            $type = pathinfo($path, PATHINFO_EXTENSION);
            $data = file_get_contents($path);
            return 'data:image/' . $type . ';base64,' . base64_encode($data); 
        }



include_once("conexion_data_base.php"); 