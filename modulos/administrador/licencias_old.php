<?php @include('./layout.php')  ?>


<div id="idContenedor">

    <div class="row mt-4">

<!--        <div class="col-lg-4 col-md-6 mb-4 mb-lg-0">-->
<!--          <div class="card h-100 ">-->
<!--            <div class="card-body pt-0">-->

                <div class="" id="mnuDescPagos"></div>

<!--            </div>-->
<!--          </div>-->
<!--        </div>-->

    </div>


<!--       <div id="btn_carga_sms" title="Comprar créditos SMS">-->
<!--           <table>-->
<!--                 <tr>-->
<!--                     <td><img src="img/sms.png">&nbsp;</td>-->
<!--                     <td><label id="nCredit">-</label></td>-->
<!--                     <td>&nbsp;&nbsp;</td>-->
<!--                     <td>&nbsp;&nbsp;</td>-->
<!--                     <td>&nbsp;Comprar Créditos SMS&nbsp;</td>-->
<!--                 </tr>-->
<!--           </table>-->
<!--       </div>-->

<button id="btn_carga_sms" class="btn bg-gradient-primary" >
  Comprar Créditos SMS
</button>


</div>




<input type="hidden" id="ids_registros" value="">



<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Cargar comprobante de pago</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div id="divContenCargDoc" class="modal-body"></div>
      <div class="modal-footer">
        <button id="btn_registrar_pago" type="button" class="btn btn-success ">REGISTRAR PAGO</button>
        <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>




<div class="modal fade" id="myModal_viz" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Consultar comprobante de pago</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div id="divVizCompPag" class="modal-body"></div>
      <div class="modal-footer">
        <button id="btn_registrar_pago" type="button" class="btn btn-primary disabled">REGISTRAR PAGO</button>
        <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="myModal_pagComp" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Comprobante recibido</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <table>
              <tr>
                  <td>&nbsp;&nbsp;&nbsp;</td>
                  <td><img src="img/ok.ico" style="width: 5em"></td>
                  <td>&nbsp;&nbsp;&nbsp;</td>
                  <td><h3 style="font-size: 1.3em">Estimado cliente, hemos recibido su comprobante correctamente.</h3></td>
              </tr>
          </table>
      </div>
      <div class="modal-footer">
        <button id="btn_registrar_pago" type="button" class="btn btn-primary disabled">REGISTRAR PAGO</button>
        <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="myModal_CredSMS" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Comprar créditos SMS</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <article id="divSucCredSMS"></article>
      </div>
      <div class="modal-footer">
        <button id="btn_registrar_pago" type="button" class="btn btn-primary disabled">REGISTRAR PAGO</button>
        <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>

<?php @include('./layout2.php')  ?>
