    <!--end-aqui-va-el-main-->

    </div>
  </main>

  <div class="fixed-plugin">
    <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
      <i class="fa fa-cog py-2"> </i>
    </a>
    <div class="card shadow-lg">
      <div class="card-header pb-0 pt-3 bg-transparent ">
        <div class="float-start">
          <h5 class="mt-3 mb-0">Instrucciones para pago</h5>
          <p>Estimado Cliente</p>
        </div>
        <div class="float-end mt-4">
          <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
            <i class="fa fa-close"></i>
          </button>
        </div>
        <!-- End Toggle Button -->
      </div>
      <hr class="horizontal dark my-1">
      <div class="card-body pt-sm-3 pt-0 overflow-auto">
        <p>
            A continuación se presenta la información necesaria para realizar el pago de nuestros servicios.
        </p>
          <h4>Datos del Banco</h4>
          <p>
            <strong> Banco : </strong> BBVA Bancomer <br>
            <strong> Cuenta No : </strong> 1562178729 <br>
            <strong> CLABE : </strong> 012460015621787299 <br>
            <strong> Beneficiario : </strong> Dora Luz Montero Vírgen <br>
            <strong> RFC : </strong> MOVD830827KL1 <br>
          </p>
          <h4>Enviar pago vía sistema</h4>
          <p>
            1- Despues de realizar el pago de la licencia, tenga a la mano su comprobante de depósito. <br><br>
            2- Pulse el botón <strong>“Cargar comprobante”</strong>, y suba el documento que acredita el movimiento bancario; puede ser un acuse en formato .pdf,
              una captura de pantalla del ticket o váucher, o una foto tomada directamente con su Smartphone. <br><br>
            3- Pulse el botón REGISTRAR PAGO. <br><br>
          </p>

      </div>
    </div>
  </div>

  <!--   Core JS Files   -->
  <script src="assets/js/core/popper.min.js"></script>
  <script src="assets/js/core/bootstrap.min.js"></script>
  <script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
  <!-- Kanban scripts -->
  <script src="assets/js/plugins/dragula/dragula.min.js"></script>
  <script src="assets/js/plugins/jkanban/jkanban.js"></script>
  <script src="assets/js/plugins/chartjs.min.js"></script>

  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="assets/js/argon-dashboard.min.js?v=2.0.4"></script>

  <!-- SDK MercadoPago.js V2 -->
  <script src="https://sdk.mercadopago.com/js/v2"></script>

  <!--  botón de pago Mercado pago -->
  
  <script type="text/javascript">
    const mp = new MercadoPago('TEST-5f5b814c-b298-4b11-b3c4-af46b5e0bc05', {
        locale: 'es-MX'
    });

    mp.checkout({
        preference: {
        id: '<?php echo $preference->id ?>' // Indica el ID de la preferencia
        },
        render: {
        container: '.mercado-container',
        label: 'Pagar con mp',
        }
    });
  </script>

</body>

</html>