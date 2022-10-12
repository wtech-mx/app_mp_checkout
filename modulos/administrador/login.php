<?php ini_set("session.gc_maxlifetime", 28800);ini_set("session.cookie_lifetime",28800); session_start();
     
      #----------------CONTROL DE PROFUNDIDAD----------------
      $PROF="../../";

      unset($_SESSION['handel']);
      session_destroy();

?>
<!doctype html>
<head>
      <meta http-equiv="Expires" content="0">
      <meta http-equiv="Last-Modified" content="0">
      <meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
      <meta HTTP-EQUIV="Expires" CONTENT="-1">   
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
      <meta name="viewport" content="width=device-width,initial-scale=1"/>
      <html lang="es">
      <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
      <script type="text/javascript" src="js/autenticacion.js?v=1.0.7"></script>
      <link type="text/css" href="css/estilos_sys.css" rel="stylesheet" >
      <link type="text/css" href="css/estilos.css?v=1.0.0" rel="stylesheet" >      
</head>
<body>

<div id="imgAutentic">
    
    <center>
       <img id="logoSs" src="img/site_logo.png?v=1.0.1">
       <div style="clear: both;"></div>
       <label id="textIngresar">Administrador.</label>
    </center>

    <br>
    
    <div id="imgAutUser" class="imgAuth"><img id="logoSs" src="img/002-man-user.png"></div>    
    <input type="text" id="nombreUser" placeholder="Usuario"  value="">
    <div style="clear: both;"></div>    
    <div id="imgAutPass" class="imgAuth"><img id="logoSs" src="img/001-lock.png"></div>
    <input type="password" placeholder="Contrase&ntilde;a" id="contraUser" value="">

    <div style="clear: both; height: 1em;"></div>
    <a href="#" class="btn_comando" id="btnIngresar"> <img id="imgIngresar" src="img/sign-out-option.png"> <label>Ingresar</label></a>
    <a href="../../../index.html" class="btn_comando" id="btnCancelar" ><img src="img/open-exit-door.png"> <label>Cancelar</label></a>

</div>  


<div id="msgSist"></div>

</body>