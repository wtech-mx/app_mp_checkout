function format(numero){   
    var number = numero.toString(10);
    var posComa = number.indexOf(",");
    var posPunto = number.indexOf("."); 
    if(posComa > -1 &&  posPunto==-1){ number = number.replace(",", "."); }

    if(number=="" || isNaN(number)){ number="0"; }                        
    var num=number + "";
    var vec=num.split(".");  
    var x=vec.length;   
    if(x==1){ban=1; var dec=".00"; } else {ban=0; var dec=""; }  
    var contador=1;
    longi=num.length-1;                                
    var retorno="";
    while( longi >= 0 ){
        car=num.substr(longi, 1);
        if(ban==1){
            if( (contador % 3)==0 && longi > 0 ){
                retorno="," + car + retorno;
            } else {
                retorno= car + retorno;
            }                                         
            contador=contador+1;                                       
        }
        if(car=="."){ban=1; dec=(num.substr(longi, 3));}                                
        longi=longi-1;                                                               
    }                                
    if(dec.length==2){dec=dec+"0";}

    //Corrige situacion de numeros negativos
    if(retorno.substr(0,2)=="-,"){ retorno="-" + retorno.substr(2, retorno.length ); }

    return retorno + dec;
}

function num(numero){
    var number = numero.toString(10);  
    var posComa = number.indexOf(",");
    var posPunto = number.indexOf("."); 
    if(posComa > -1 &&  posPunto==-1){  number = number.replace(",", "."); }
                                                  
    longi=number.length-1;
    var car="";
    var retorna="";
    while( longi >= 0 )
    {
       car=number.substr(longi, 1);
       if(car != ","){
        retorna=  car + retorna 
       }
       longi=longi-1;                              
    }
                                                  
    if(isNaN(parseFloat(retorna))){retorna=0;}                              
    return parseFloat(retorna);
}    

function noCac(){
    var fecha= new Date();
    var horas= fecha.getHours();
    var minutos = fecha.getMinutes();
    var segundos = fecha.getSeconds();
    var dia=fecha.getDate();
    var mes=fecha.getMonth();
    var anio=fecha.getFullYear();                              
    return mes + "" + segundos + "" + horas + "" + minutos + "" + anio + "" + dia; 
}

function preload(trueOfalse){
	if(trueOfalse){
		$("#preloader_01").css("display","inline-block");
		$("#preloader_02").css("display","inline-block");
	} else {
		$("#preloader_01").css("display","none");
		$("#preloader_02").css("display","none");
	}
}

//Abre un corte en especifico
function ActualizaHandel(){
    if( $("#handel").length==1 ){
        var params={};            
        params.index="0";
        params.handel=$("#handel").val();
        $('#divAux').load("php/cmd_comandos.php", params); 
    }
} 

function AcomodaObjs(){
    var altoPaint=$("#altoPagina").height();
    $("#idContenedor").css("min-height", (altoPaint+7) + "px");
}

$(document).ready(function(){

	$("#handel").change(function(){  ActualizaHandel(); }); 
    $("#btnRefresh").click(function(){ $("#handel").change(); $("#id_empresa_base").change(); });
    ActualizaHandel();    

    AcomodaObjs();

});  