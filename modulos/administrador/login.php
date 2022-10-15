<?php ini_set("session.gc_maxlifetime", 28800);ini_set("session.cookie_lifetime",28800); session_start();

      #----------------CONTROL DE PROFUNDIDAD----------------
      $PROF="../../";

      unset($_SESSION['handel']);
      session_destroy();

?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="assets/img/favicon.png">
  <title>
    Argon Dashboard 2 PRO by Creative Tim
  </title>
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
  <!-- Nucleo Icons -->
  <link href="assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <link href="assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- CSS Files -->
  <link id="pagestyle" href="assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />

</head>

<body class="">

  <main class="main-content main-content-bg mt-0">
    <div class="page-header min-vh-100" style="background-image: url('https://raw.githubusercontent.com/creativetimofficial/public-assets/master/argon-dashboard-pro/assets/img/signin-basic.jpg');">
      <span class="mask bg-gradient-dark opacity-6"></span>
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-4 col-md-7">
            <div class="card border-0 mb-0">
              <div class="card-header bg-transparent">
                  <p class="text-center">
                      <img src="./img/logo-kuali.png" alt="" style="width: 150px">
                  </p>

                <h5 class="text-dark text-center mt-2 mb-3">Inisiar sesion</h5>

              </div>
              <div class="card-body px-lg-5 pt-0">
                <div class="text-center text-muted mb-4">
                  <small>Ingresa con tus credenciales</small>
                </div>

                  <div class="mb-3">
                    <input type="text" id="nombreUser" class="form-control" placeholder="Email" aria-label="Email" value="">
                  </div>
                  <div class="mb-3">
                    <input type="password" class="form-control" placeholder="Password" aria-label="Password" id="contraUser" value="">
                  </div>

                  <div class="text-center">
                    <button type="button" class="btn btn-primary w-100 my-4 mb-2" id="btnIngresar">Ingresar</button>
                  </div>


              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>

  <!--   Core JS Files   -->
  <script src="assets/js/core/popper.min.js"></script>
  <script src="assets/js/core/bootstrap.min.js"></script>
  <script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="assets/js/plugins/smooth-scrollbar.min.js"></script>

  <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
  <script type="text/javascript" src="js/autenticacion.js?v=1.0.7"></script>

  <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="assets/js/argon-dashboard.min.js?v=2.0.4"></script>
</body>

</html>