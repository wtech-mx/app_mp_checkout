<?php @include('./layout.php')  ?>


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

<?php @include('./layout2.php')  ?>
