<?php session_start();

define('KB', 1024);
define('MB', 1048576);
define('GB', 1073741824);
define('TB', 1099511627776);

			$rutaTmp="tmp/" . ( isset($_GET['dest']) ? $_GET['dest'] : 'comprobante' );
			$nombreFile="pago_".session_id();

			//Verifica si la carpeta temporal existe
			if(!file_exists($rutaTmp)){ mkdir($rutaTmp, 0777, true); }

			//Borra todos los tipos de archivos permitidos
			if(file_exists($rutaTmp."/".$nombreFile.".png")){ unlink($rutaTmp."/".$nombreFile.".png"); }
			if(file_exists($rutaTmp."/".$nombreFile.".pdf")){ unlink($rutaTmp."/".$nombreFile.".pdf"); }
			if(file_exists($rutaTmp."/".$nombreFile.".jpeg")){ unlink($rutaTmp."/".$nombreFile.".jpeg"); }
			if(file_exists($rutaTmp."/".$nombreFile.".jpg")){ unlink($rutaTmp."/".$nombreFile.".jpg"); }


//if they DID upload a file...
if($_FILES['file']['name']){

	//if no errors...
	if(!$_FILES['file']['error']){
			//Averigua extencion de archivo
		    $vecAux= explode(".", $_FILES['file']['name']);
		    $ext=strtolower($vecAux[ count($vecAux)-1 ]);

		    if($_FILES['file']['size'] > 11*MB ){
		    	echo "El archivo no debe exceder de 3 MB";
		    	exit(0);
		    }
		    		
			//Carga archivo
		    move_uploaded_file($_FILES['file']['tmp_name'], $rutaTmp."/".$nombreFile.".".$ext);

			echo "1";

	} else {
		echo 'Error al subir el archivo:  Asegurese que el archivo no exceda a 1.5MB';
	}
}



?>