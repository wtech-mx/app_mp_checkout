<?php

  class MenuVertical{

      public $menuLateral_color_fondo;
      public $menuLateral_color_fondo_resalte;
      public $sub_menuLateral_color_fondo;
      public $sub_menuLateral_color_texto;
      public $sub_menuLateral_color_add;
      public $sub_menuLateral_color_texto_inabil;
      public $menuLateral_color_texto_inabil;
      public $menuLateral_color_texto;

      /*colores del men� r�pido*/
      public $ancho_contenedor_opciones_menu_rapido;
      public $panelComandosRapidos_color_fondo;
      public $color_texto_titulo_menu_rapido;
      public $color_texto_subtitulo_menu_rapido;
      public $color_texto_contenedor_opciones_menu_rapido;
      public $color_fondo_contenedor_opciones_menu_rapido;
      public $alto_minimo_contenedor_opciones_menu_rapido;
      public $color_texto_inabil_contenedor_opciones_menu_rapido;
      

      protected $select;
      protected $codeHtml;
      protected $rutaIcono;
      protected $IdSub;
      protected $idSubx;
      protected $indexSub;
      protected $vecPrivilegios;
      protected $banPri;
      protected $listIds;
      protected $listIds_temp;
      protected $mnuSelected;
      protected $SubMnuSelected;
      protected $rutaMenuSel;
      protected $textDefau;
      protected $Profundidad;
      protected $VisibleMenuVertical;
      protected $html_menuRapido;
      protected $html_menuRapido_temp;
      protected $cont;
      protected $ShowAll;
      protected $tipoMenu;
      protected $htmlAuxMenuRapido;
      protected $html_menuRapido_temp_aux;
      protected $htmlMnuBloque;
      
      /*Control de los modulos*/
      protected $modulos=array(array(),array());
      protected $nomModAct;
      protected $nomMod;
      protected $cantModulos;
      protected $contSubMenuVis=false;      

      function MenuVertical(){
      	
        //Colores del menu vertical
	      $this->menuLateral_color_fondo="#0B3861";
	      $this->menuLateral_color_fondo_resalte="#01A9DB";
        $this->menuLateral_color_texto="white";
	      $this->sub_menuLateral_color_fondo="#E0ECF8";
	      $this->sub_menuLateral_color_texto="#848484";
	      $this->sub_menuLateral_color_add="#FF0000"; 
	      $this->menuLateral_color_texto_inabil="#848484";
	      $this->sub_menuLateral_color_texto_inabil="#BDBDBD";

        //Colores del menu rapido
        $this->ancho_contenedor_opciones_menu_rapido="10em";
        $this->panelComandosRapidos_color_fondo="#0489B1";
        $this->color_texto_titulo_menu_rapido="white";
        $this->color_texto_subtitulo_menu_rapido="white";
        $this->color_texto_contenedor_opciones_menu_rapido="#D8D8D8";   
        $this->color_fondo_contenedor_opciones_menu_rapido="none";   
        $this->color_texto_inabil_contenedor_opciones_menu_rapido="#086A87";   
              
	      $this->select='0';
	      $this->codeHtml='';
	      $this->rutaIcono='';
	      $this->IdSub='';
	      $this->idSubx='';
	      $this->indexSub=0;
	      $this->vecPrivilegios='';
	      $this->banPri=false;
	      $this->listIds='';
        $this->listIds_temp='';
        $this->mnuSelected='';
        $this->SubMnuSelected='';
        $this->rutaMenuSel='';
        $this->textDefau='';
        $this->Profundidad='';
        $this->VisibleMenuVertical=true;
        $this->html_menuRapido='';
        $this->html_menuRapido_temp='';
        $this->cont=0;
        $this->alto_minimo_contenedor_opciones_menu_rapido="10em";
        $this->ShowAll=false;
        $this->tipoMenu="menuAcordeon";

        $this->nomModAct="";
        $this->nomMod="Principal";        
        $this->cantModulos=-1;
        $this->htmlAuxMenuRapido="";
        $this->html_menuRapido_temp_aux="";
        $this->contSubMenuVis=false;
        $this->htmlMnuBloque="";
        
      }

      function setShowAll($true_o_false){
          $this->ShowAll=$true_o_false;
      } 

      /*----------Funci�n para definir men� r�pidos-------------*/
      function addMnuBloque($idPrivilegio,$CaptionMnu,$imgMnu='',$urlMnu="#"){
         if(is_priv($idPrivilegio[0],"boolean") || $idPrivilegio[0]=="" || count($idPrivilegio)==0){

             $auxCod="";

             //Acompleta URL ruta
             if($urlMnu != ""){ $urlMnu=$this->Profundidad.$urlMnu; }

             //Selecciona Mnu bloque
             $classAdd="";
             if( isset($idPrivilegio[1]) ){ $privMark=$idPrivilegio[1]; } else { $privMark=$idPrivilegio[0]; }             

             if($privMark != ""){
                 if( $this->mnuSelected != "" && $this->mnuSelected==$privMark ){ $classAdd=" MnuSelOp "; }
                 if( $this->SubMnuSelected != "" && $this->SubMnuSelected==$privMark ){ $classAdd=" MnuSelOp "; }
             }              

             //Desabilita hiperv�nculo
             if($urlMnu=="#"){ $auxCod=' onclick="return false;" '; }

             //Anexa c�digo HTML de men�
             $this->htmlMnuBloque.='<a class="mnuOpRapido '.$privMark.$classAdd.'" '.$auxCod.' title="'.$CaptionMnu.'" href="'.$urlMnu.'">
                                   <img src="'.$this->Profundidad.'../crm/img/bloque/'.$imgMnu.'">
                                   <div style="clear:both;"></div>
                                   '.$CaptionMnu.'
                                   </a>';
         }                           
      }

      /*----------Funcion para clasificar por modulos-----------*/ 
      function setModulo($NuevoNombre){
          $this->nomMod=$NuevoNombre;
      }
      function getMods(){
           return $this->modulos;
      }

      function getNumMods(){
           return $this->cantModulos;
      }

      /*Funcion para actualizar el nombre del modulo*/
      function actNombreMod($nuevoId,$url,$Caption){
          if($this->nomModAct=="" || $this->nomModAct != $this->nomMod){ 
              $this->nomModAct=$this->nomMod; 
              $this->cantModulos+=1;
          } 

          if(trim($this->nomModAct) != ""){
              #$this->modulos[$this->cantModulos]['nombre']= $this->nomModAct;
              #$this->modulos[$this->cantModulos]['ids'].= $nuevoId."|";        
              #$this->modulos[$this->cantModulos]['url'].= $url."|"; 
              #$this->modulos[$this->cantModulos]['caption'].= $Caption."|";
          }
      }
      /*-------------------------------------------------------*/      
        
      function setVisible($true_o_false){
          $this->VisibleMenuVertical=$true_o_false;
      }

      function setProfundidad($NuevaProfundidad){
           $this->Profundidad=$NuevaProfundidad;
      }

      function setPrivilegios($ListaIds){
      	if( trim($ListaIds) != "" ){
     			$this->vecPrivilegios=explode("|", $ListaIds);	
     			$this->banPri=true;
      	}

      }

      function setSelect($mnuSelected,$SubMnuSelected,$textDefault){
        //$this->select="1";
        $this->mnuSelected=$mnuSelected;
        $this->SubMnuSelected=$SubMnuSelected;
        $this->textDefau=$textDefault;

      }
      function setIcon($NuevaRuta){
			$this->rutaIcono=$NuevaRuta;
      }

      function setSubMenuId($nuevoId){
      	  $this->IdSub='data-submnu="'.$nuevoId.'"';
      	  $this->idSubx=$nuevoId;
      }

      /*Retorna el vector con los modulos ya clasificados*/

      function setTipoMenu($nuevoSelTipo){
            $this->tipoMenu=$nuevoSelTipo;
      }

      function addMenu($nuevoId,$Caption,$CodigoSubmenu,$url_menu="#"){

          //Detecta que no tiene submenus
          if($this->contSubMenuVis==false){ $CodigoSubmenu=""; }        

          switch ($this->tipoMenu) {
            case 'menuAcordeon':
                  $classMenu_01="mnuLat01";
                  $classSubMenu_01="sub_mnuLat01";
                  $mnusVisibles="funcion";
                  $colorTextoMnuPrinc=$this->menuLateral_color_texto;
                  $colorFondoSubmnu=$this->sub_menuLateral_color_fondo;
              break;
            case 'menuFijo':
                  $classMenu_01="mnuLat02";
                  $classSubMenu_01="sub_mnuLat02";
                  $mnusVisibles="Si";
                  $Caption_02=$Caption;
                  $Caption="<b>".strtoupper($Caption)."</b>";
                  $colorTextoMnuPrinc="black";
                  $this->rutaIcono="";
                  $colorFondoSubmnu="white";
              break;              
          }

          /*Control del nombre del Modulo*/
          $this->actNombreMod($nuevoId,$url_menu,$Caption);

          $display="inline-block";
          if($this->VisibleMenuVertical==false ){$display="none";}

          if($this->VisibleMenuVertical || $this->ShowAll){

                  $ag="";
                  if( trim($this->listIds_temp) != "" ){ $ag="|"; }
                  $this->listIds.="|".$nuevoId."|".$Caption.$ag.$this->listIds_temp;
                  $this->listIds_temp="";

        		      $priv=true;
              	  if($this->banPri){
              	  	 $priv=false;
                     for($i=0;$i<count($this->vecPrivilegios);$i++){
                     	 if( $this->vecPrivilegios[$i]==$nuevoId ){ $priv=true; }
                     }
              	  }

                  if($CodigoSubmenu != "" && $priv){
                  	if( $this->IdSub=="" ){
        		      	$this->IdSub='data-submnu="SubMenu_'.$this->indexSub.'"';
        		      	$this->idSubx="SubMenu_".$this->indexSub;
                  	}
                  }	

                  if($this->mnuSelected==$nuevoId && $this->mnuSelected != "" ){ 
                      $this->select='1'; 
                      if( $CodigoSubmenu == "" ){
                         $this->rutaMenuSel= '<img src="'.$this->Profundidad.'recursos/css/img/sigue.png"> <a href="#" id="'.$nuevoId.'" style="color:'.$colorTextoMnuPrinc.'">'.$Caption."</a>".$this->rutaMenuSel;
                      } else {
                         $this->rutaMenuSel='<img src="'.$this->Profundidad.'recursos/css/img/sigue.png"> <div style="color:'.$colorTextoMnuPrinc.'">'.$Caption."</div>".$this->rutaMenuSel;
                      }
                  }

                  if($priv){ $colorf=$colorTextoMnuPrinc; $opeciti="1"; } else { $opeciti="0.4"; $colorf=$this->menuLateral_color_texto_inabil; }

                  if($url_menu=="#"){  
                      if($CodigoSubmenu != ""){                    
                          $this->codeHtml.='<div id="'.$nuevoId.'" class="'.$classMenu_01.'" style="color:'.$colorf.'; display:'.$display.';" data-select="'.$this->select.'" '.$this->IdSub.'>';
                          if( $this->rutaIcono != "" ){
                              $this->codeHtml.='<img style="opacity:'.$opeciti.';" src="'.$this->rutaIcono.'">';
                          }     
                          $this->codeHtml.='<div class="nombreSmnu"><font color="'.$colorf.'">'.$Caption.'</font></div>';
                          $this->codeHtml.='</div>';
                      }                      
                  } else {
                      $this->codeHtml.='<a href="'.$url_menu.'" id="'.$nuevoId.'" class="'.$classMenu_01.'" style="color:'.$colorf.'; display:'.$display.';" data-select="'.$this->select.'" '.$this->IdSub.'>';
                      if( $this->rutaIcono != "" ){
                          $this->codeHtml.='<img style="opacity:'.$opeciti.';" src="'.$this->rutaIcono.'">';
                      }     
                      $this->codeHtml.='<div class="nombreSmnu"><font color="'.$colorf.'">'.$Caption.'</font></div>';
                      $this->codeHtml.='</a>';                                            
                  }


                  if($CodigoSubmenu != ""){
                    $disp="none";
                    if($this->select=='1' || $mnusVisibles=="Si"){ $disp="inline-block"; }

                  	$this->codeHtml.='<div class="'.$classSubMenu_01.'" id="'.$this->idSubx.'" style="background-color:'.$colorFondoSubmnu.'; display:'.$disp.';">';
        			      $this->codeHtml.=$CodigoSubmenu;
                  	$this->codeHtml.='</div>';

                    //Codigo del menu Rapido
                    if( strlen($this->html_menuRapido_temp) > 0 && $priv ){

                        switch ($this->tipoMenu) {
                          case 'menuAcordeon':
                               $this->html_menuRapido.='
                               <div class="seccion_menuUp" style="width:'.$this->ancho_contenedor_opciones_menu_rapido.'; color:'.$this->color_texto_contenedor_opciones_menu_rapido.'; background-color:'.$this->color_fondo_contenedor_opciones_menu_rapido.';min-height:'.$this->alto_minimo_contenedor_opciones_menu_rapido.';">            
                                 <div style="color:'.$this->color_texto_subtitulo_menu_rapido.';">'.$Caption.'</div>
                                 <div style="clear:both;height:0.3em;"></div>
                                 '.$this->html_menuRapido_temp.'
                               </div>'; 
                            break;
                          case 'menuFijo':
                               $this->html_menuRapido.="<li><a href='#'>".$Caption_02."&nbsp; <label style='font-size:9px'>&#9660;</label></a><ul>".$this->html_menuRapido_temp."</ul></li>";
                            break;              
                        }

                        $this->cont=$this->cont+1;

                    }     

                  	$this->indexSub+=1;
                  }

                  $this->select='0';
                  $this->rutaIcono='';
                  $this->IdSub='';
                  $this->idSubx='';     
                  $this->VisibleMenuVertical=true;
                  $this->html_menuRapido_temp='';
          } 

          $this->contSubMenuVis=false;        

      }

      function addSubMenu($nuevoId,$nuevoIdMas,$Caption,$visible,$url){
          
          switch ($this->tipoMenu) {
            case 'menuAcordeon':
                  $vinieta="&#187";
                  $coloTextoSubMenu=$this->sub_menuLateral_color_texto;
                  $claseSeleccion="Seleccion";
                  $addMas=true;
              break;
            case 'menuFijo':
                  $vinieta="&nbsp;&nbsp;&nbsp; &nbsp";
                  $coloTextoSubMenu="#084B8A";
                  $claseSeleccion="Seleccion02";
                  $addMas=false;
              break;              
          }

          //Lee Privilegio  
          $priv=true;
          $privMas=true;
          if($this->banPri){
             $priv=false;
             $privMas=false;
              for($i=0;$i<count($this->vecPrivilegios);$i++){
                 if( $this->vecPrivilegios[$i]==$nuevoId ){ $priv=true; }
                 if( $this->vecPrivilegios[$i]==$nuevoIdMas ){ $privMas=true; }
               }
          }


          $menuRapido=true;
          $display="inline-block";
          if(substr($Caption, 0,1) == " "){ 
            $menuRapido=false; $display="none"; 
          } else {
            //Indica que si tiene submenus
            if($priv){ $this->contSubMenuVis=true; }
          }

          $this->actNombreMod($nuevoId,$url,$Caption);

      	  $this->listIds_temp.="&".$nuevoId."&".$Caption;


	      	if($priv){ 
	      		$id=$nuevoId;
            $id2=$nuevoIdMas;
	      		$color=$coloTextoSubMenu;
	      	} else {
	      		$id='';
            $id2='';
	      		$color=$this->sub_menuLateral_color_texto_inabil;	 
            $display="none";
	      	}

            $clasAdd="";
            if( ($this->SubMnuSelected==$nuevoId && $nuevoId != "") || ($this->SubMnuSelected==$nuevoIdMas && $nuevoIdMas != "" ) ){ 
              $clasAdd=$claseSeleccion;

              if($nuevoIdMas=="" || $this->SubMnuSelected!=$nuevoIdMas ){
                 $this->rutaMenuSel='<img src="'.$this->Profundidad.'recursos/css/img/sigue.png"><div>'.$Caption."</div>".$this->rutaMenuSel;
              } else {                
                $this->rutaMenuSel='<img src="'.$this->Profundidad.'recursos/css/img/sigue.png"> <div>Agregar '.$Caption.'</div>'.$this->rutaMenuSel;
                $this->rutaMenuSel='<img src="'.$this->Profundidad.'recursos/css/img/sigue.png"> <a href="#" id="'.$nuevoId.'">'.$Caption."</a>".$this->rutaMenuSel;
              } 

            } 

      	    $code='';
            $code.='<div style="display:'.$display.';" class="itemSub '.$clasAdd.'">';
            $code.='<div class="nombreSub '.$id.'"><font color="black">'.$vinieta.';</font>&nbsp;<a style="color:'.$color.'" href="'.$this->Profundidad.$url.'">'.$Caption.'</a></div>';
            if($nuevoIdMas != ""){
                $this->actNombreMod($nuevoIdMas,$url,"&Alta ".$Caption);
            	  $this->listIds_temp.="&".$nuevoIdMas."&Alta ".$Caption;
                if($privMas && $addMas){
                   $code.='<div class="nuevoSub '.$id2.'" title="Agregar Nuevo" style="color:'.$this->sub_menuLateral_color_add.'">+</div>';
                }
            }
            $code.='</div>';

            //C�digo del men� rapido
            if($menuRapido){           

              switch ($this->tipoMenu) {
                case 'menuAcordeon':
                       if($priv){
                          $this->html_menuRapido_temp.='<p class="linkPanel '.$nuevoId.'"><a style="color:'.$this->color_texto_contenedor_opciones_menu_rapido.'" href="'.$this->Profundidad.$url.'">'.$Caption.'</a></p>';
                       } 
                       if($nuevoIdMas != "" && $privMas){                 
                          $this->html_menuRapido_temp.='<p class="'.$nuevoIdMas.'">Alta '.$Caption.'</p>';
                       } 
                  break;
                case 'menuFijo':
                       if($priv){
                          $this->html_menuRapido_temp.='<li><a href="'.$this->Profundidad.$url.'">'.$Caption.'</a></li>';
                       } 
                       if($nuevoIdMas != "" && $privMas){                 
                          $this->html_menuRapido_temp.='<li><a href="#" class="'.$nuevoIdMas.'">Alta '.$Caption.'</a></li>';
                       } 
                  break;              
              }
            }

            return $code;      	
      }	

      //A�ade Una Opcion al menu r�pido
      function addItemAuxMenuRapido($nuevoId,$Caption){
              switch ($this->tipoMenu) {
                case 'menuAcordeon':
                      $this->html_menuRapido_temp_aux.='<p class="linkPanel '.$nuevoId.'"><a style="color:'.$this->color_texto_contenedor_opciones_menu_rapido.'" href="#">'.$Caption.'</a></p>';
                  break;
                case 'menuFijo':
                      $this->html_menuRapido_temp_aux.='<li><a class="'.$nuevoId.'" href="#">'.$Caption.'</a></li>';
                  break;              
              }        
      }

      function addItemMenuRapido($Caption){
              switch ($this->tipoMenu) {
                case 'menuAcordeon':
                    $this->htmlAuxMenuRapido.='
                        <div class="seccion_menuUp" style="width:'.$this->ancho_contenedor_opciones_menu_rapido.'; color:'.$this->color_texto_contenedor_opciones_menu_rapido.'; background-color:'.$this->color_fondo_contenedor_opciones_menu_rapido.';min-height:'.$this->alto_minimo_contenedor_opciones_menu_rapido.';">            
                            <div style="color:'.$this->color_texto_subtitulo_menu_rapido.';">'.$Caption.'</div>
                            <div style="clear:both;height:0.3em;"></div>
                            '.$this->html_menuRapido_temp_aux.'
                        </div>'; 
                break;
                case 'menuFijo':
                    $this->htmlAuxMenuRapido.="<li><a href='#'>".$Caption."&nbsp; <label style='font-size:9px'>&#9660;</label></a><ul>".$this->html_menuRapido_temp_aux."</ul></li>";
                break;              
              }

              $this->html_menuRapido_temp_aux="";                
      }

      function getListIds(){
      	return $this->listIds."|";
      }

      function getRutaMenuSel(){
          if( $this->textDefau == "" ){             
             return $this->rutaMenuSel;
          } else {
             return $this->textDefau;
          }                 
      }

      function ShowMenuRapido($Caption){

        //=========== Oculta elementos del men� ===========
        $setSimplifi="";
        if(isset($_GET["setSimplifi"])){
            $setSimplifi="display:none;";
            $this->html_menuRapido="";
            $this->htmlAuxMenuRapido="";
        }
        //=================================================

          $Caption=str_replace("�", "&ntilde;", $Caption);

          switch ($this->tipoMenu) {
            case 'menuAcordeon':

                      echo '
                      <div id="menuUp" data-clic="0" style="background-color:'.$this->menuLateral_color_fondo_resalte.'; '.$setSimplifi.'"></div>  
                      <div id="picoPanelComendosRapidos" style="border-bottom: 30px solid '.$this->panelComandosRapidos_color_fondo.';" ></div>';

                      echo '
                      <div id="panelComandosRapidos" style="background-color:'.$this->panelComandosRapidos_color_fondo.'; color:'.$this->color_texto_titulo_menu_rapido.';'.$setSimplifi.'">
                         '.$this->htmlMnuBloque.'                                                                                                                                                    
                         <div style="clear:both; height:1em;"></div>
                      </div>';                        

              break;
            case 'menuFijo':
                      echo '
                      <div id="menuUp" data-clic="0" style="display:none"></div>  
                      <div id="picoPanelComendosRapidos" style="border-bottom: 30px solid '.$this->panelComandosRapidos_color_fondo.';" ></div>';
                      echo "<div id='controlMenu' title='' class='movDer'></div>";

                      echo '<ul id="menuFijo" style="background-color:'.$this->menuLateral_color_fondo.';"><img src="'.$this->Profundidad.'recursos/css/img/ss.png" id="logo_peque_ss">'.$this->html_menuRapido.$this->htmlAuxMenuRapido.'</ul>';
              break;              
          }   

          $this->html_menuRapido=''; 
          $this->htmlAuxMenuRapido='';    
      }

      function Show($NuevaRutaLogo){

          switch ($this->tipoMenu) {
            case 'menuAcordeon':
                 $colorFondo=$this->menuLateral_color_fondo; 
                 $classMenuLateral="menuLateral";
              break;
            case 'menuFijo':
                 $colorFondo="white";
                 $classMenuLateral="menuLateral02";
                 $NuevaRutaLogo="";
              break;              
          }


        echo '<input type="hidden" id="PROF" value="'.$this->Profundidad.'">';

      	echo '<script>';
      	echo 'var colorFondoMenu="'.$colorFondo.'";';
      	echo 'var colorResalteMenu="'.$this->menuLateral_color_fondo_resalte.'";';
        echo "</script>";

        //=========== Oculta elementos del men� ===========
        $setSimplifi="";
        if(isset($_GET["setSimplifi"])){
            $setSimplifi="display:none;";
            $this->codeHtml="";
        }
        //=================================================

      	echo '<div class="'.$classMenuLateral.'" style="background-color:'.$colorFondo.';'.$setSimplifi.'">';	

      	if($NuevaRutaLogo != ''){
            
            //Control de cache
            $noC="";            
            if(isset($_SESSION["noC"]) && $_SESSION["noC"] != ""){ $noC="?v=".$_SESSION["noC"]; }

            //Logo 2
            $log2=$this->Profundidad.'../app/datos/'.$_SESSION['handel'].'/logo2/logo2.png';
            $log2 =  file_exists($log2) ? '<img id="logo_deco_baara_head" src="'.$log2.'">' : '' ;

	          echo '<div id="logoEpresaId" class="LogoEmpresa">
	                   <img src="'.$NuevaRutaLogo.$noC.'">
	                </div>                  
                  <div id="opBarraHeadSmnu" class="hidden_element">
                     '.$log2.'
                     <div id="btnCloseSmnu" title="Cerrar">
                          <img src="'.$this->Profundidad.'../app/recursos/css/img/close_option.png?v=1.0.1">
                     </div>
                  </div>';
         } 

         echo $this->codeHtml;

         echo '</div>';         

      }


  }	
  
?>