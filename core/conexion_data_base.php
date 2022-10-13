<?php
// se declara una clase para hacer la conexion con la base de datos

class Conexion  
{
    var $con;
    var $server;
    var $user;
    var $pass;
    var $base;
    var $manejador;
    var $data_source;
    function __construct()
    {

        $this->manejador="MySQL";

        switch ($this->manejador) {
          case 'SQL Server':
                        
                        $this->data_source='ODBC_SQL_SERVER';
                        $this->user='';
                        $this->pass='';

                        $conect=odbc_connect($this->data_source,$this->user,$this->pass);
                        if ($conect){
                            $this->con=$conect;
                        }

            break;
          case 'MySQL':

                    //En local
                    $this->server="localhost";             
                    $this->user="root";                   
                    $this->pass="";             
                    $this->base="sistema_erp";                                                    
                    
                    $conect= mysqli_connect($this->server,$this->user,$this->pass,$this->base);
                    if ($conect){ $this->con=$conect; } else { echo "No Hubo Conexion con la Base de Datos"; }           
   
            break;          
        }


    }

    function getConexion() 
    { return $this->con; }

    function Close()  
    { 
        switch ($this->manejador){
          case 'SQL Server':                        
                        odbc_close($this->con);
            break;
          case 'MySQL':
                        mysqli_close($this->con);         
  
            break;          
        }

    }   

}

class sQuery   
{
    var $coneccion;
    var $consulta;
    var $resultados;
    var $ConSQL;

    protected $cont;
    protected $banAtu;
    protected $affect;
    protected $nColum;    

    function __construct()
    { 
        $this->coneccion= new Conexion(); 
    }

    function executeQuery($cons,$actualizaSession=true,$charSpecial=false)
    {

        //-------Refresca Sesion ----------- 
        if($actualizaSession){
            if( isset($_SESSION["ultimoAcceso"])){
               $_SESSION["ultimoAcceso"]=date("Y-n-j H:i:s");       
            }
        }            

        $cons=utf8_decode($cons);
        
        if($charSpecial==false){                        
            $cons= str_replace('"',"",$cons);    
            $cons = str_replace(array("º", "¨","~","¨","´","`","ª","¬","\"","·","Ç","^"),'',$cons);
        }

            $this->consulta= mysqli_query($this->coneccion->getConexion(),$cons);

        return $this->consulta;
    }   
    function getUsuario()
    { return $this->coneccion->user; }

    function getDB()
    { return $this->coneccion->base; }

    function getContra()
    { return $this->coneccion->pass; }

    function getServidor()
    { return $this->coneccion->server; }

    function getResults()   // retorna la consulta en forma de result.
    { return $this->consulta; }
    
    function Close()        // cierra la conexion
    {$this->coneccion->Close();}    
    
    function Clean() // libera la consulta
    { mysqli_free_result($this->consulta); }
    
    function getAffect() // devuelve las cantidad de filas afectadas
    { 
      
            switch ($this->coneccion->manejador){
              case 'SQL Server':                        
                             return odbc_num_rows($this->consulta); 
                break;
              case 'MySQL':
                            return mysqli_affected_rows($this->coneccion->getConexion());           
                break;          
            } 

    }

    function getNumColumn() // devuelve las cantidad de filas afectadas
    {       

            switch ($this->coneccion->manejador){
              case 'SQL Server':                        
                             return odbc_num_fields($this->coneccion->getConexion()); 
                break;
              case 'MySQL':
                            return mysqli_num_fields($this->consulta);            
                break;          
            } 

    }
}