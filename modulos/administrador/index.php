<?php ini_set("session.gc_maxlifetime", 28800);ini_set("session.cookie_lifetime",28800); session_start();
      if(!isset($_SESSION["handel"])) header('Location: login.php'); 
      include_once("../../core/funciones_privilegios.php");

      //Verifica si existe adeudo de licencia
      $ban_adeuda_licencia=false;
      if(isset($_SESSION["msg_blk"])){
            if( $_SESSION["msg_blk"] != "" ) $ban_adeuda_licencia=true; 
      }

      //Escoge el módulo que abrirá
      $mnu_open='licencias.php';
      if($mnu_open=='') $mnu_open='login.php';

      header('Location: ' . $mnu_open);