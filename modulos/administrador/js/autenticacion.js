      var procesoEntrar=false;
      function BlockNav(){ $("input").prop("disabled",true); } 

      function procesoEspera(){
          if(procesoEntrar){
             $("#imgIngresar").attr("src","img/ajax-loader.gif?v=1.0.0");
             $("#btnIngresar,#btnCancelar").css("opacity","0.7");
          } else {
             $("#imgIngresar").attr("src","img/sign-out-option.png");
             $("#btnIngresar,#btnCancelar").css("opacity","1");
          }
      }

      $(document).ready(function(){           

           //Verifica la compatibilidad de navegadores
           if(navigator.userAgent.toLowerCase().indexOf('edge') > -1){
              alert("El sistema no es compatible con Microsoft Edge");
               BlockNav();
           }

           if(navigator.userAgent.toLowerCase().indexOf('MSIE') > -1){
              alert("El sistema no es compatible con Microsoft Explorer");
              BlockNav();
           }                

           //Coloca Focus                
           $("#nombreUser").focus();

         //Usuario previo-consultado  
         if (typeof(Storage) !== "undefined") {
            var usrAct=localStorage.getItem("userActualSystemLog");
            if(usrAct != null && usrAct != ""){
               $("#nombreUser").val(usrAct);
               $("#contraUser").val("");                                      
               setTimeout(function(){ $("#contraUser").focus().select(); }, 50);
            } else {
               $("#nombreUser").val("");
               $("#contraUser").val("");
               $("#nombreUser").focus();                                    
            }
         } else {
               $("#nombreUser").val("");
               $("#contraUser").val("");
               $("#nombreUser").focus();
         }             

         $("#nombreUser").keyup(function(tecla){
              $("#msgSist").fadeOut();
              if(tecla.which==13){
                $("#contraUser").focus().select();
              }
         });

         $("#contraUser").keyup(function(tecla){
              $("#msgSist").fadeOut();
              if(tecla.which==27){
                $("#nombreUser").focus().select();
              }
              if(tecla.which==13){
                  if($("#btnIngresar").css("display") == "block"){
                     $("#btnIngresar").click();
                  }
              }
         });

         $("#imgAutUser").click(function(){ $("#nombreUser").focus().select(); });
         $("#imgAutPass").click(function(){ $("#contraUser").focus().select(); });


         $("#btnIngresar").click(function(event){
            event.preventDefault();

            var usuario=$("#nombreUser").val();
            var contra=$("#contraUser").val();

            usuario=usuario.trim();
            contra=contra.trim();

            if(procesoEntrar==false){

                   if(usuario==""){
                      $("#msgSist").html("<font color='#B43104'>Debe Escribir un Usuario</font>");                
                      $("#msgSist").fadeIn();                 
                      $("#nombreUser").focus();
                      exit(0);
                   }

                   if(contra==""){
                      $("#msgSist").html("<font color='#B43104'>Debe Escribir una Contrase&ntilde;a</font>");                
                      $("#msgSist").fadeIn();                 
                      $("#contraUser").focus();
                      exit(0);
                   }

                   /* Verifica que el usuario es correcto */
                   var data= new FormData();
                   data.append("usuario",$("#nombreUser").val()); 
                   data.append("contra",$("#contraUser").val()); 

                   $.ajax({
                      url: "php/validaUser.php",
                      type:"POST",
                      data:data,
                      contentType:false,
                      processData:false,
                      cache:false,
                      timeout: 60000,                 
                      error: function(objeto, quepaso, otroobj){
                         procesoEntrar=false;
                         $("#nombreUser").attr("readonly",false);
                         $("#contraUser").attr("readonly",false);                   
                         $("#msgSist").html("Ocurrio un error al verificar el usuario");                
                         $("#msgSist").fadeIn(); 
                         procesoEspera();
                      },
                      beforeSend: function(objeto){
                         procesoEntrar=true; 
                         $("#nombreUser").attr("readonly",true);
                         $("#contraUser").attr("readonly",true);
                         $("#msgSist").fadeOut();
                         procesoEspera();
                      }
                    }).done(function (msg){                 

                        procesoEntrar=false;

                        if(msg.trim()=="1"){

                           //Guarda el Usuario
                           if (typeof(Storage) !== "undefined") {
                               localStorage.setItem( "userActualSystemLog" , $("#nombreUser").val() ); 
                           } 

                           location.href= "index.php";
                        } else {  
                           $("#msgSist").html("<font color='#B43104'>" + msg + "</font>");                
                           $("#msgSist").fadeIn();
                           $("#nombreUser").focus().select();
                           $("#nombreUser").attr("readonly",false);
                           $("#contraUser").attr("readonly",false);    
                           procesoEspera();                 
                        } 

                    }); 
            }

         });

      });   