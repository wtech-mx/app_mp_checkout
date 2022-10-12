-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-10-2022 a las 00:13:27
-- Versión del servidor: 10.1.30-MariaDB
-- Versión de PHP: 5.6.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_erp`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_user` (IN `usu` VARCHAR(100), IN `contra` VARCHAR(100))  READS SQL DATA
select t1.id as id_user,t1.ids_select_clasific,t1.alias,t2.*,t3.nombre as NombrePermiso,CONCAT(t3.ids_privilegios,t1.ids_con_privilegio_aux) as ids_privilegios,t3.tipo_viz,t3.moduloInicio,t3.visible,t4.nombre_empresa,t1.nombre as nombre_user,(select ids_privilegios from tpermisos where id=t1.id_permiso_2) as ids_privilegios_2 from tusuarios t1,tempresas t2,tpermisos t3, tempresas_base t4 where t1.activo='Si' and t2.activa='Si' and t1.handel=t2.handel and t3.id=t1.id_permiso and t4.id=t2.id_empresa_base and t1.alias=usu and t1.contrasenia=contra$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tcomprobantes_pago`
--

CREATE TABLE `tcomprobantes_pago` (
  `id` int(11) NOT NULL,
  `nombre_archivo` varchar(150) DEFAULT NULL,
  `ext_file` varchar(10) DEFAULT NULL COMMENT 'Extención de archivo',
  `importe_total` decimal(13,2) DEFAULT NULL,
  `fecha_carga` datetime DEFAULT NULL,
  `id_session` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tcomprobantes_pago_aux`
--

CREATE TABLE `tcomprobantes_pago_aux` (
  `id` int(11) NOT NULL,
  `id_comprobante_pago` int(11) DEFAULT NULL,
  `id_control_cobros` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tconfig_gral`
--

CREATE TABLE `tconfig_gral` (
  `id` int(11) NOT NULL,
  `handel` int(11) NOT NULL,
  `id_empresa_base` int(11) NOT NULL DEFAULT '1',
  `puesto_servicio` varchar(30) DEFAULT NULL,
  `hora_inicio` int(11) DEFAULT NULL,
  `minutos_incremento` int(11) DEFAULT NULL,
  `hora_fin` int(11) DEFAULT NULL,
  `color_libre` varchar(15) NOT NULL,
  `color_reservada` varchar(10) NOT NULL,
  `color_confirmada` varchar(10) NOT NULL,
  `color_cancelada` varchar(10) NOT NULL,
  `color_cobrado` varchar(11) NOT NULL,
  `color_fuera_tiempo` varchar(10) NOT NULL,
  `conf_personal_glob` int(11) NOT NULL DEFAULT '1',
  `conf_sistema_apartado` int(11) NOT NULL DEFAULT '1',
  `conf_otorgar_credito` int(11) NOT NULL DEFAULT '1',
  `moduloInicio` varchar(50) NOT NULL DEFAULT 'calendario',
  `rangoHora` varchar(2) NOT NULL DEFAULT 'SI',
  `rangoManual` varchar(2) NOT NULL DEFAULT 'NO',
  `tiempo_notificacion` int(11) NOT NULL DEFAULT '0',
  `Filas` varchar(1000) NOT NULL,
  `num_columnas` int(11) NOT NULL,
  `etiquet_cto` varchar(50) NOT NULL DEFAULT 'Producto o Servicio:',
  `etiquet_cant` varchar(50) NOT NULL DEFAULT 'Cantidad:',
  `serv_unico` varchar(2) NOT NULL DEFAULT '0',
  `most_disponibilidad` varchar(2) NOT NULL DEFAULT '0',
  `mod_colums` varchar(2) NOT NULL DEFAULT '1',
  `pedir_confirm` varchar(2) NOT NULL DEFAULT '0',
  `conf_filas` varchar(1000) NOT NULL,
  `vizNombreEmpresa` varchar(2) NOT NULL DEFAULT '0',
  `alReservar` varchar(2) NOT NULL DEFAULT '0',
  `asuntoAlReservar` varchar(100) NOT NULL,
  `destinatAlReservar` varchar(150) NOT NULL,
  `coAlReservar` varchar(150) NOT NULL,
  `cuerpoAlReservar` varchar(1000) NOT NULL,
  `alConfirmar` varchar(2) NOT NULL DEFAULT '0',
  `asuntoAlConfirmar` varchar(100) NOT NULL,
  `destinatAlConfirmar` varchar(150) NOT NULL,
  `coAlConfirmar` varchar(150) NOT NULL,
  `cuerpoAlConfirmar` varchar(1000) NOT NULL,
  `alCancelar` varchar(2) NOT NULL DEFAULT '0',
  `asuntoAlCancelar` varchar(100) NOT NULL,
  `destinatAlCancelar` varchar(150) NOT NULL,
  `coAlCancelar` varchar(150) NOT NULL,
  `cuerpoAlCancelar` varchar(1000) NOT NULL,
  `alCobrar` varchar(2) NOT NULL DEFAULT '0',
  `asuntoAlCobrar` varchar(100) NOT NULL,
  `destinatAlCobrar` varchar(150) NOT NULL,
  `coAlCobrar` varchar(150) NOT NULL,
  `cuerpoAlCobrar` varchar(1000) NOT NULL,
  `alCaducar` varchar(2) NOT NULL DEFAULT '0',
  `asuntoAlCaducar` varchar(100) NOT NULL,
  `destinatAlCaducar` varchar(150) NOT NULL,
  `coAlCaducar` varchar(150) NOT NULL,
  `cuerpoAlCaducar` varchar(1000) NOT NULL,
  `optFolio` varchar(15) NOT NULL DEFAULT 'folio',
  `ticketVenta` varchar(2) NOT NULL DEFAULT '0',
  `configTicketVenta` varchar(1500) NOT NULL,
  `Numero` varchar(10) NOT NULL,
  `Ciudad` varchar(35) NOT NULL,
  `CodPostal` varchar(5) NOT NULL,
  `Rfc` varchar(15) NOT NULL,
  `ticketVentaPDF` varchar(2) NOT NULL DEFAULT '0',
  `Estado` varchar(30) NOT NULL,
  `Numero_interior` varchar(35) NOT NULL,
  `Colonia` varchar(50) NOT NULL,
  `chk_reportado_tarjeta` varchar(2) NOT NULL DEFAULT '0',
  `ExportRoming` int(11) NOT NULL DEFAULT '1' COMMENT 'Cambiado para almacenar el numero de copias del ticket',
  `ModTratamientos` varchar(2) NOT NULL DEFAULT '1',
  `ChangCitaCtaCob` varchar(2) NOT NULL DEFAULT '0',
  `ChangPrecioPagCta` varchar(2) NOT NULL DEFAULT '0',
  `CaptMontosDinero` varchar(2) NOT NULL DEFAULT '0',
  `appliDescuentos` varchar(5) NOT NULL COMMENT 'Cambiada para almacenar Cantidad de columnas',
  `vizAnticipos` varchar(2) NOT NULL DEFAULT '0',
  `vizNombreTerapeuta` varchar(2) NOT NULL DEFAULT '0',
  `editCtasCobb` varchar(2) NOT NULL DEFAULT '0',
  `Notifi_Sonora` int(11) NOT NULL DEFAULT '0',
  `Minute_Notifi` int(11) NOT NULL DEFAULT '2',
  `hora_inicio_app` decimal(11,2) NOT NULL,
  `hora_fin_app` int(11) NOT NULL,
  `medioPromoOblig` int(11) NOT NULL DEFAULT '0',
  `noC` varchar(15) NOT NULL COMMENT 'Sirve para evitar el cache en las imagenes del sistema, como el encabezado.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tconfig_gral`
--

INSERT INTO `tconfig_gral` (`id`, `handel`, `id_empresa_base`, `puesto_servicio`, `hora_inicio`, `minutos_incremento`, `hora_fin`, `color_libre`, `color_reservada`, `color_confirmada`, `color_cancelada`, `color_cobrado`, `color_fuera_tiempo`, `conf_personal_glob`, `conf_sistema_apartado`, `conf_otorgar_credito`, `moduloInicio`, `rangoHora`, `rangoManual`, `tiempo_notificacion`, `Filas`, `num_columnas`, `etiquet_cto`, `etiquet_cant`, `serv_unico`, `most_disponibilidad`, `mod_colums`, `pedir_confirm`, `conf_filas`, `vizNombreEmpresa`, `alReservar`, `asuntoAlReservar`, `destinatAlReservar`, `coAlReservar`, `cuerpoAlReservar`, `alConfirmar`, `asuntoAlConfirmar`, `destinatAlConfirmar`, `coAlConfirmar`, `cuerpoAlConfirmar`, `alCancelar`, `asuntoAlCancelar`, `destinatAlCancelar`, `coAlCancelar`, `cuerpoAlCancelar`, `alCobrar`, `asuntoAlCobrar`, `destinatAlCobrar`, `coAlCobrar`, `cuerpoAlCobrar`, `alCaducar`, `asuntoAlCaducar`, `destinatAlCaducar`, `coAlCaducar`, `cuerpoAlCaducar`, `optFolio`, `ticketVenta`, `configTicketVenta`, `Numero`, `Ciudad`, `CodPostal`, `Rfc`, `ticketVentaPDF`, `Estado`, `Numero_interior`, `Colonia`, `chk_reportado_tarjeta`, `ExportRoming`, `ModTratamientos`, `ChangCitaCtaCob`, `ChangPrecioPagCta`, `CaptMontosDinero`, `appliDescuentos`, `vizAnticipos`, `vizNombreTerapeuta`, `editCtasCobb`, `Notifi_Sonora`, `Minute_Notifi`, `hora_inicio_app`, `hora_fin_app`, `medioPromoOblig`, `noC`) VALUES
(1, 1, 1, 'DEPILADORA', 9, 10, 20, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', 'Loc. 12B', 'Coatzacoalcos', '96575', 'TOCG750721C43', 'NO', 'Veracruz', '', 'Santa Rosa', '1', 1, '1', '1', '0', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(2, 2, 1, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '--', 'Coatzacoalcos', '96519', 'AGR1808306N8', 'NO', 'Veracruz', '', 'Petroquimica', '1', 1, '1', '1', '0', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(3, 3, 1, 'DEPILADORA', 9, 10, 20, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', 'Km. 12.5', 'Coatzacoalcos', '96519', 'TOCG750721C43', 'NO', 'Veracruz', '', '-', '1', 1, '1', '1', '0', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(27, 28, 22, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '-', 'Villahermosa', '00000', 'BAMA900816J21', 'NO', 'Tabasco', '', '', '1', 1, '1', '1', '0', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(30, 31, 22, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '631 PA', 'Villahermosa', '86150', 'AGR1808306N8', 'NO', 'Tabasco', 'Local 45 Periplaza S', 'Tamulte', '1', 1, '1', '1', '0', '0', '', '0', '1', '1', 0, 2, '0.00', 0, 1, ''),
(37, 38, 27, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '141', 'Mérida', '97133', 'AGR1808306N8', 'NO', 'Yucatan', 'Local 12', 'Montecristo', '1', 1, '1', '1', '0', '0', '', '0', '1', '1', 0, 2, '0.00', 0, 1, ''),
(48, 49, 33, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', 'LOC. 11', 'TLAJOMULCO', '45645', '', 'NO', 'JALISCO', '', '-', '1', 1, '1', '1', '0', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(52, 53, 36, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '523', 'Querétaro', '76230', '', 'NO', 'Querétaro', 'Local 13', 'Juriquilla', '1', 1, '1', '1', '0', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(61, 62, 39, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '38C', 'Veracruz', '94296', '', 'NO', 'Veracruz', '', '-', '1', 1, '1', '1', '0', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(65, 66, 36, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '306', 'Querétaro', '76070', '', 'NO', 'Querétaro', 'Local. 7', 'Centro', '1', 1, '1', '1', '1', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(74, 75, 27, 'DEPILADORA', 9, 10, 20, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '299', 'Mérida', '97203', '', 'NO', 'Yucatan', '', 'Centro', '1', 1, '1', '0', '0', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(79, 80, 1, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', 'Local A 7-', 'Coatzacoalcos', '96575', 'AGR1808306N8', 'NO', 'Veracruz', '', 'Santa Rosa', '1', 1, '1', '1', '0', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(90, 91, 36, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '17', 'Querétaro', '09390', '', 'NO', 'Querétaro', '', 'El Refugio', '1', 1, '1', '1', '0', '0', '', '0', '1', '0', 0, 2, '0.00', 0, 1, ''),
(102, 103, 27, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '157A', 'Mérida', '97205', 'AGR1808306N8', 'NO', 'Yucatan', '', 'García Ginerés sobre', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(104, 105, 36, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '95', 'San Juan del Rio', '76800', '', 'NO', 'Querétaro', '', 'Centro', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(106, 107, 22, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '112', 'Villahermosa', '86020', 'AGR1808306N8', 'NO', 'Tabasco', 'Local 14', '.', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(111, 112, 58, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '224-2', 'Durango', '34170', '', 'NO', 'Durango', '', 'Fracc. Camino Real', '1', 1, '1', '1', '1', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(112, 113, 59, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', ' 703', 'León', '37160', '', 'NO', 'Guanajuato', 'Local 2', 'Panorama', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(113, 114, 39, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '1232A', 'Veracruz', '91897', '', 'NO', 'Veracruz', '', '', '1', 1, '1', '1', '1', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(119, 120, 36, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '1690 ', 'Querétaro', '76900', '', 'NO', 'Querétaro', 'loc. 23', 'El pueblito corregidora', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(121, 122, 36, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '423 A', 'Querétaro', '76230', '', 'NO', 'Querétaro', '', 'Galindas', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(122, 123, 33, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 1, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '390 Plaza ', 'Zapopan', '45038', '', 'NO', 'Jalisco', 'Local 17 ', 'La estancia', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(126, 127, 27, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '278 ', 'Mérida', '97203', '', 'NO', 'Yucatan', 'Local 16', 'Fracc. Aurea Residencial', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(129, 130, 63, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '1450', 'Colima', '28017', '', 'NO', 'Colima', '', 'Residencial Santa Bárbara', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(131, 132, 22, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', 'S/N', 'Comacalco', '86357', 'CAZO890104DH5', 'NO', 'Tabasco', 'Planta Alta #16', 'San Isidro', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, ''),
(139, 140, 67, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '3525', 'Tuxtla Gutiérrez', '29059', '', 'NO', 'Chiapas', 'Local 06', 'Centro', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, '210420221410'),
(141, 142, 58, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '124 B', 'Durango', '34105', '', 'NO', 'Durango', 'Local 5', 'Centro', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, '210420221412'),
(142, 143, 58, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '120', 'Durango', '34200', '', 'NO', 'Durango', '', 'Jardines de Durango', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, '210420221413'),
(143, 144, 33, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '1', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', 'Local #15', 'Tlajomulco ', '45645', '', 'NO', 'Jalisco', '', 'San Agustín', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, '230420221653'),
(147, 148, 22, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', 'KM 3.5', 'Nacajuca', '86247', '', 'NO', 'Tabasco', 'LOCÁL 20 PLAZA EUROPA', 'Fraccionamiento Europa', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, '240820221438'),
(148, 149, 70, 'DEPILADORA', 10, 10, 19, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 1, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '1', '0', '1', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'SI', '', '105', 'Monterrey', '64100', '', 'NO', 'Nuevo León', '', 'Cumbres Elite 5to. Sector', '1', 1, '1', '1', '0', '0', '', '0', '1', 'NO', 0, 2, '0.00', 0, 1, '090820221806'),
(150, 151, 71, 'DEPILADORA', 9, 30, 20, '#FFFFFF', '#F6CECE', '#F5A9A9', '#A4A4A4', '#FA5858', '#E6E6E6', 0, 0, 1, 'calendario', 'SI', 'NO', 0, '', 0, 'Producto o Servicio:', 'Cantidad:', '0', '0', '0', '0', '', '0', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'NO', '', '', '', '', 'idVenta', 'NO', '', 'S/N', 'Querétaro', '00000', '', 'NO', 'Querétaro', '', '.', '0', 1, '0', '0', '0', '0', '', '0', '0', 'NO', 0, 2, '0.00', 0, 0, '230820221114');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tconsumos_sms`
--

CREATE TABLE `tconsumos_sms` (
  `id` int(11) NOT NULL,
  `id_empresa_base` int(11) DEFAULT NULL,
  `handel` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha_hora` datetime DEFAULT NULL,
  `cantidad_sms` int(11) DEFAULT NULL,
  `text_num_cels_sends` varchar(200) DEFAULT NULL,
  `comentario` varchar(200) NOT NULL,
  `sMessage` text COMMENT 'Contenido del Mensaje de Texto'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tcontrol_cobros`
--

CREATE TABLE `tcontrol_cobros` (
  `id` int(11) NOT NULL,
  `id_empresa_base` int(11) DEFAULT NULL,
  `handel` int(11) DEFAULT NULL,
  `folio` int(11) NOT NULL,
  `fecha_generacion` datetime DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `fecha_pago` datetime DEFAULT NULL,
  `chk_pagado` int(2) DEFAULT '0',
  `importe_pago` decimal(13,2) DEFAULT NULL,
  `is_factura` int(2) DEFAULT '0',
  `tipo_licencia` varchar(30) DEFAULT NULL,
  `comentarios` varchar(150) DEFAULT NULL,
  `comentarios_aux` varchar(250) NOT NULL,
  `comentarios_admin` varchar(200) NOT NULL,
  `razon_social` varchar(150) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Pendiente',
  `procesado` int(2) NOT NULL DEFAULT '0',
  `ban_atrasado` int(11) NOT NULL DEFAULT '0',
  `str_suc_sms` text NOT NULL COMMENT 'Almacena totales de creditos comprados para las sucursales',
  `cantidad_sms` int(11) NOT NULL,
  `ban_facturada` int(2) NOT NULL DEFAULT '0' COMMENT 'Si contiene 1 significa que ya se elaboro la factura',
  `ban_importe_modif` int(2) NOT NULL DEFAULT '0' COMMENT 'Si tiene 1 significa que fue modificado manualmente el importe',
  `folio_factura_gral` int(11) DEFAULT NULL COMMENT 'Las ventas que contienen un valor diferente de cero, son las que ya fueron incluidas en una factura, y no se deben incluir en otra'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tcontrol_cobros`
--

INSERT INTO `tcontrol_cobros` (`id`, `id_empresa_base`, `handel`, `folio`, `fecha_generacion`, `fecha_inicio`, `fecha_fin`, `fecha_pago`, `chk_pagado`, `importe_pago`, `is_factura`, `tipo_licencia`, `comentarios`, `comentarios_aux`, `comentarios_admin`, `razon_social`, `status`, `procesado`, `ban_atrasado`, `str_suc_sms`, `cantidad_sms`, `ban_facturada`, `ban_importe_modif`, `folio_factura_gral`) VALUES
(2675, 1, 2, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-05 11:59:21', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2676, 1, 80, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-05 11:59:21', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2677, 22, 132, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', NULL, 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2678, 22, 107, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', NULL, 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2679, 22, 148, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-04 18:06:58', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2680, 22, 28, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-02 21:23:46', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2681, 22, 31, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', NULL, 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2683, 27, 103, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-03 16:38:00', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2684, 27, 38, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-03 16:38:00', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2685, 27, 127, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-03 16:38:00', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2699, 33, 123, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-04 13:17:04', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2700, 33, 144, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-04 13:16:43', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2705, 36, 120, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-05 11:56:41', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2706, 36, 91, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-05 11:56:41', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2707, 36, 122, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-05 11:56:41', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2708, 36, 53, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-05 11:56:41', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2709, 36, 105, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-05 11:56:41', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2711, 39, 62, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-05 12:00:39', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2712, 39, 114, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-05 12:00:39', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2734, 58, 143, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', NULL, 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2735, 58, 142, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', NULL, 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2736, 58, 112, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', NULL, 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2737, 59, 113, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', NULL, 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2739, 63, 130, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', NULL, 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2741, 67, 140, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-02 10:26:36', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2742, 70, 149, 42, '2022-09-25 19:55:24', '2022-10-01', '2022-10-31', '2022-10-03 20:33:39', 0, '150.00', 0, 'mensual', '', '', '', NULL, 'Pendiente', 0, 0, '', 0, 0, 0, NULL),
(2746, 22, -1, 0, '2022-09-29 10:45:32', '2022-10-01', '2022-10-31', '2022-09-29 10:46:15', 0, '150.00', 0, 'SMS', 'Samarkanda/150|San luis/150|', '', '', NULL, 'Pendiente', 0, 0, '28/150|31/150|', 300, 0, 0, NULL),
(2747, 27, -1, 0, '2022-09-29 10:47:34', '2022-10-01', '2022-10-31', '2022-09-29 10:47:53', 0, '150.00', 0, 'SMS', 'Circuito colonias/150|Montecristo/150|', '', '', NULL, 'Pendiente', 0, 0, '103/150|38/150|', 300, 0, 0, NULL),
(2748, 33, -1, 0, '2022-09-29 10:48:24', '2022-10-01', '2022-10-31', '2022-09-29 10:48:45', 0, '150.00', 0, 'SMS', 'La estancia/150|', '', '', NULL, 'Pendiente', 0, 0, '123/150|', 150, 0, 0, NULL),
(2750, 59, -1, 0, '2022-09-29 10:50:18', '2022-10-01', '2022-10-31', '2022-09-29 10:50:29', 0, '150.00', 0, 'SMS', 'León /150|', '', '', NULL, 'Pendiente', 0, 0, '113/150|', 150, 0, 0, NULL),
(2751, 70, -1, 0, '2022-09-29 10:51:12', '2022-10-01', '2022-10-31', '2022-09-29 10:51:22', 0, '150.00', 0, 'SMS', 'Plaza Adriána/150|', '', '', NULL, 'Pendiente', 0, 0, '149/150|', 150, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tcreditos_sms`
--

CREATE TABLE `tcreditos_sms` (
  `id` int(11) NOT NULL,
  `id_empresa_base` int(11) DEFAULT NULL,
  `handel` int(11) DEFAULT NULL,
  `id_registro_pago` int(11) DEFAULT NULL,
  `fecha_hora` datetime DEFAULT NULL,
  `cantidad_sms` int(11) DEFAULT NULL,
  `costo_sms` decimal(13,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tempresas`
--

CREATE TABLE `tempresas` (
  `handel` int(10) NOT NULL,
  `id_empresa_base` int(11) NOT NULL DEFAULT '1',
  `tiempo_sesion` int(10) DEFAULT NULL,
  `sloganEmpresa_Sel` varchar(80) DEFAULT NULL,
  `nombreSucursal_Sel` varchar(40) DEFAULT NULL,
  `nombreEmpresa_Tick` varchar(50) NOT NULL COMMENT 'Nombre de la empresa tal como debe aparecer en el encabezado del ticket',
  `Direccion` varchar(100) DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `PrecioActivo` varchar(20) DEFAULT NULL,
  `PrecioActivo2` varchar(20) NOT NULL,
  `includeInfoFiscal` varchar(1) NOT NULL DEFAULT '0',
  `rfc_fiscal` varchar(30) NOT NULL,
  `email_fiscal` varchar(40) NOT NULL,
  `razon_social` varchar(60) NOT NULL,
  `calle_fiscal` varchar(50) NOT NULL,
  `num_exterior_fiscal` varchar(30) NOT NULL,
  `num_interior_fiscal` varchar(30) NOT NULL,
  `colonia_fiscal` varchar(20) NOT NULL,
  `localidad_fiscal` varchar(30) NOT NULL,
  `municipio_fiscal` varchar(35) NOT NULL,
  `id_estado_fiscal` int(11) NOT NULL,
  `cp_fiscal` varchar(6) NOT NULL,
  `regimen` varchar(90) NOT NULL,
  `banUssPrueba` int(2) NOT NULL DEFAULT '0',
  `ControlFolio` int(11) NOT NULL DEFAULT '1',
  `formatoControlFolio` varchar(30) NOT NULL DEFAULT '{FOLIO}',
  `plantillaEmail` text NOT NULL,
  `AsuntoMail` varchar(100) NOT NULL DEFAULT 'Su Factura {FOLIO} de {EMI_RAZON}',
  `Destinatarios` varchar(150) NOT NULL DEFAULT '{CTE_EMAIL}',
  `CopiaOculta` varchar(150) NOT NULL,
  `ban_enviar_email` int(2) NOT NULL DEFAULT '1',
  `ban_descarga_zip` int(2) NOT NULL DEFAULT '1',
  `chkApp` int(3) NOT NULL DEFAULT '0' COMMENT 'Indica si la sucursal estara disponible en la aplicación',
  `activa` varchar(2) NOT NULL DEFAULT 'Si'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tempresas`
--

INSERT INTO `tempresas` (`handel`, `id_empresa_base`, `tiempo_sesion`, `sloganEmpresa_Sel`, `nombreSucursal_Sel`, `nombreEmpresa_Tick`, `Direccion`, `Telefono`, `PrecioActivo`, `PrecioActivo2`, `includeInfoFiscal`, `rfc_fiscal`, `email_fiscal`, `razon_social`, `calle_fiscal`, `num_exterior_fiscal`, `num_interior_fiscal`, `colonia_fiscal`, `localidad_fiscal`, `municipio_fiscal`, `id_estado_fiscal`, `cp_fiscal`, `regimen`, `banUssPrueba`, `ControlFolio`, `formatoControlFolio`, `plantillaEmail`, `AsuntoMail`, `Destinatarios`, `CopiaOculta`, `ban_enviar_email`, `ban_descarga_zip`, `chkApp`, `activa`) VALUES
(1, 1, 90, 'Depilación que refleja salud', 'Lucas', '', 'Av. J Anaya Villazon', '(921) 163-8315', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 0, '', '', '', '', '', 0, 1, 0, 'No'),
(2, 1, 90, 'Depilación que refleja salud', 'Malecon', '', 'Malecon Costero', '(921) 158-8016', 'Precio Normal', 'Promo1', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 0, '', '', '', '', '', 0, 1, 1, 'Si'),
(3, 1, 90, 'Depilación que refleja salud', 'San Javier', '', 'Plaza San Javier Av. Universidad', '(921) 688-5785', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 0, '', '', '', '', '', 0, 1, 0, 'No'),
(28, 22, 90, 'Depilación que refleja salud', 'Samarkanda', '', '-', '', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(31, 22, 90, 'Depilación que refleja salud', 'San luis', '', 'Periférico Carlos Pellicer Cámara', '(993) 184-0485', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(38, 27, 90, 'Depilación que refleja salud', 'Montecristo', '', 'Calle 4 / Calle 17', '(999) 178-7296', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(49, 33, 90, 'Depilación que refleja salud', 'Plaza Galicia - cancelada', '', 'MARIANO OTERO', '', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 0, 'Si'),
(53, 36, 90, 'Depilación que refleja salud', 'Juriquilla', '', 'Clemencia Borja Taboada', '(442) 251-0121', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(62, 39, 90, 'Depilación que refleja salud.', 'Boca del Rio', '', 'Urano', '', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(66, 36, 90, 'Depilación que refleja salud', 'Cimatario', '', 'Luis vega y monrroy', '(521) 757-5423', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(75, 27, 90, 'Depilación que refleja salud', 'Montejo', '', 'Calle 41', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 0, 'No'),
(80, 1, 90, 'Depilación que refleja salud', 'Quadrum', 'Plaza Quadrum', 'Av. J. Anaya Villazon', '(921) 163-8315', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(91, 36, 90, 'Depilación que refleja salud', 'El refugio', '', 'Anillo Vial Fray Junípero Serra, plaza Kiwi Local 17 ', '(442) 248-7748', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(103, 27, 90, 'Depilación que refleja salud', 'Circuito colonias', '', '30', '(999) 461-3397', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(105, 36, 90, 'Depilación que refleja salud', 'San Juan del Rio', '', 'BLV Pablo Cabrera', '(427) 688-1036', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(107, 22, 90, 'Depilación que refleja salud', 'Framboyanes ', '', 'Ebanos', '(993) 365-7746', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(112, 58, 90, 'Depilación que refleja salud', 'Politécnico', '', 'Politécnico Nacional', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(113, 59, 90, 'Depilación que refleja salud', 'León ', '', 'Panorama', '(477) 148-2418', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(114, 39, 90, 'Depilación que refleja salud', 'Zona Norte', '', 'Cuauhtémoc', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(120, 36, 90, 'Depilación que refleja salud', 'Corregidora', '', 'Av. Paseo constituyentes ', '(442) 277-6553', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(122, 36, 90, 'Depilación que refleja salud', 'Galindas', '', 'prolongación pino Suárez ', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(123, 33, 90, 'Depilación que refleja salud', 'La estancia', '', 'Doctores, Lomas del seminario', '(333) 803-2486', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(127, 27, 90, 'Depilación que refleja salud', 'Plaza Vía', '', '3', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(130, 63, 90, 'Depilación que refleja salud', 'Plaza Laguna', '', 'Venustiano Carranza ', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(132, 22, 90, 'Depilación que refleja salud', 'Comalcalco', '', 'Ignacio López Rayón, Esq. Blvd Leandro Rovirosa Wade', '(993) 119-6301', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(140, 67, 90, 'Depilación que refleja salud', 'Tuxtla Gutiérrez', '', 'Plaza Santa Elena, Boulevard Belisario Domínguez', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(142, 58, 90, 'Depilación que refleja salud', 'La Salle', '', 'Av. La Salle', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(143, 58, 90, 'Depilación que refleja salud', 'Jardines de Durango', '', 'Magnolia', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(144, 33, 240, 'Depilación que refleja salud', 'Santa Anita', '', 'Real Santa Anita Plaza', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(148, 22, 90, 'Depilación que refleja salud', 'Plaza Europa', '', 'CARRT. VHSA-NACAJ', '(993) 317-9775', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(149, 70, 90, 'Depilación que refleja salud', 'Plaza Adriána', '', 'Av Paseo de los Leones ', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 1, 'Si'),
(151, 71, 90, 'Depilación que refleja salud', 'Bodega', '', 'Conocida', '(000) 000-0000', 'Precio Normal', 'Precio Normal', '0', '', '', '', '', '', '', '', '', '', 0, '', '', 0, 1, '{FOLIO}', '', 'Su Factura {FOLIO} de {EMI_RAZON}', '{CTE_EMAIL}', '', 1, 1, 0, 'Si');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tempresas_base`
--

CREATE TABLE `tempresas_base` (
  `id` int(11) NOT NULL,
  `nombre_empresa` varchar(80) DEFAULT NULL,
  `domicilio_empresa` varchar(150) DEFAULT NULL,
  `nombre_contacto` varchar(80) DEFAULT NULL,
  `tel1_contacto` varchar(18) DEFAULT NULL,
  `tel2_contacto` varchar(18) DEFAULT 'menuAcordeon',
  `email_contacto` varchar(40) DEFAULT NULL,
  `nota_especial` varchar(20) DEFAULT NULL,
  `creditos` text,
  `activa` varchar(3) NOT NULL,
  `ScriptCredito` text NOT NULL,
  `modulosActivos` text NOT NULL,
  `ban_comisiones` int(2) NOT NULL DEFAULT '1',
  `id_handel_base` int(11) DEFAULT NULL COMMENT 'Es la sucursal de la cual se tomaran los registros para sincronizar en el resto de sucursales',
  `id_usuario_contacto` int(11) DEFAULT NULL COMMENT 'id de usuario que sera el contacto para los pedidos de material en franquicias',
  `suc_licencias` text NOT NULL COMMENT 'Guarda el listado de las sucursales a las que se aplicará la licencia mensual',
  `importe_pago_lic` text NOT NULL,
  `is_factura_lic` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tempresas_base`
--

INSERT INTO `tempresas_base` (`id`, `nombre_empresa`, `domicilio_empresa`, `nombre_contacto`, `tel1_contacto`, `tel2_contacto`, `email_contacto`, `nota_especial`, `creditos`, `activa`, `ScriptCredito`, `modulosActivos`, `ban_comisiones`, `id_handel_base`, `id_usuario_contacto`, `suc_licencias`, `importe_pago_lic`, `is_factura_lic`) VALUES
(1, 'DEPILSEDA COATZACOALCOS', '-', 'GEMMA LILIANA DE LA TORRE CUELLAR', '', 'menuAcordeon', '', '', '[2022/01][2022/02][2022/03][2022/04][2022/05][2022/06][2022/07][2022/08][2022/09][2022/10]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, 0, '2|80|1|5|3|', '132/750|1/0|2/750|5/0|80/750|3/0|', '1/0|2/0|5/0|3/0|'),
(22, 'DEPILSEDA TABASCO', '-', 'ANA ISIS BRAVO MENDOZA', '', 'menuAcordeon', '', '', '[2022/01][2022/02][2022/03][2022/04][2022/05][2022/06][2022/07][2022/08][2022/09][2022/10]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, 0, '148|28|', '132/750|107/750|148/750|28/750|31/750|', '132/0|107/0|28/0|31/0|'),
(27, 'DEPILSEDA MÉRIDA', 'CALLE 4, COL. MONTECRISTO', 'BEATRIZ EUGENIA CORTES MEDINA', '', 'menuAcordeon', '', '', '[2021/03][2021/04][2021/05][2021/06][2021/07][2021/08][2021/09][2021/10][2021/11][2021/12][2022/01][2022/02][2022/03][2022/04][2022/05][2022/06][2022/07][2022/08][2022/09][2022/10]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, 0, '103|38|127|75|', '103/750|38/750|75/0|127/750|', ''),
(33, 'DEPILSEDA JALISCO', 'MARIANO OTERO, TLAJOMULCO ZÚÑIGA', 'LILIANA DE LA TORRE', '', 'menuAcordeon', '', '', '[2022/01][2022/02][2022/03][2022/04][2022/05][2022/06][2022/07][2022/08][2022/09][2022/10]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, 0, '123|144|64|49|', '123/750|64/0|49/0|144/750|', '123/0|64/0|49/0|'),
(36, 'DEPILSEDA QUERÉTARO', 'CONOCIDO', 'GEMMA LILIANA DE LA TORRE CUELLAR', '', 'menuAcordeon', '', '', '[2021/03][2021/04][2021/05][2021/06][2021/07][2021/08][2021/09][2021/10][2021/11][2021/12][2022/01][2022/02][2022/03][2022/04][2022/05][2022/06][2022/07][2022/08][2022/09][2022/10]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, 66, 382, '120|91|122|53|105|68|66|', '68/0|66/0|120/750|91/750|122/750|53/750|105/750|', ''),
(39, 'DEPILSEDA VERACRUZ', '-', 'GEMMA LILIANA DE LA TORRE CUELLAR', '', 'menuAcordeon', '', '', '[2021/03][2021/04][2021/05][2021/06][2021/07][2021/08][2021/09][2021/10][2021/11][2021/12][2022/01][2022/02][2022/03][2022/04][2022/05][2022/06][2022/07][2022/08][2022/09][2022/10]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, 0, '62|114|', '62/750|114/750|', ''),
(58, 'DEPILSEDA DURANGO', 'CONOCIDO', 'GEMMA LILIANA DE LA TORRE CUELLAR', '', 'menuAcordeon', '', '', '[2022/01][2022/02][2022/03][2022/04][2022/05][2022/06][2022/07][2022/08][2022/09]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, NULL, '', '143/750|142/750|112/750|', ''),
(59, 'DEPILSEDA GUANAJUATO', 'CONOCIDO', 'GEMMA LILIANA DE LA TORRE CUELLAR', '', 'menuAcordeon', '', '', '[2021/04][2021/05][2021/06][2021/07][2021/08][2021/09][2021/10][2021/11][2021/12][2022/01][2022/02][2022/03][2022/04][2022/05][2022/06][2022/07][2022/08][2022/09]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, NULL, '', '113/750|', ''),
(63, 'DEPILSEDA COLIMA', 'UNIDAD PRIVATIVA 12 PLAZA LAGUNA SHOP VENUSTIANO CARRANZA 1450, RESIDENCIAL SANTA BARBARA', 'JOSUé RODRíGUEZ CERVANTES', '', 'menuAcordeon', '', '', '[2022/01][2022/02][2022/03][2022/04][2022/05][2022/06][2022/07][2022/08][2022/09]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, NULL, '', '130/750|', ''),
(67, 'DEPILSEDA CHIAPAS', 'PLAZA SANTA ELENA, BOULEVARD BELISARIO DOMíNGUEZ', 'GEMMA LILIANA DE LA TORRE CUELLAR', '', 'menuAcordeon', '', '', '[2022/04][2022/05][2022/06][2022/07][2022/08][2022/09][2022/10]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, NULL, '140|', '140/750|', ''),
(70, 'DEPILSEDA NUEVO LEÓN', 'CONOCIDO', 'GEMMA LILIANA DE LA TORRE CUELLAR', '', 'menuAcordeon', '', '', '[2022/08][2022/09][2022/10]', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, NULL, '149|', '149/750|', ''),
(71, 'BODEGA DEPILSEDA', 'CONOCIDO', 'GEMMA LILIANA DE LA TORRE CUELLAR', '', 'menuAcordeon', '', '', 'Total', 'SI', '', 'PUNTO DE VENTA|AJUSTES GENERALES|', 1, NULL, NULL, 'all', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tmensajes_vencimiento`
--

CREATE TABLE `tmensajes_vencimiento` (
  `id` int(15) NOT NULL,
  `id_empresa_base` int(15) NOT NULL,
  `handel` int(15) NOT NULL,
  `ultima_fecha` date DEFAULT NULL,
  `intentos` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tmensajes_vencimiento`
--

INSERT INTO `tmensajes_vencimiento` (`id`, `id_empresa_base`, `handel`, `ultima_fecha`, `intentos`) VALUES
(1, 15, 21, '2017-03-08', 0),
(2, 22, 28, '2022-10-03', 0),
(3, 18, 24, '2017-03-07', 1),
(4, 1, 2, '2022-10-03', 0),
(5, 1, 3, '2019-09-02', 0),
(6, 1, 1, '2019-12-03', 0),
(7, 14, 19, '2019-06-17', 0),
(8, 16, 22, '2018-08-05', 72),
(9, 9, 14, '2022-10-04', 0),
(10, 1, 5, '2017-04-07', 0),
(11, 19, 26, '2017-04-18', 0),
(12, 21, 30, '2018-07-29', 5),
(13, 22, 31, '2022-10-05', 4),
(14, 8, 13, '2018-08-22', 2),
(15, 23, 32, '2017-07-13', 0),
(16, 25, 33, '2018-05-04', 0),
(17, 24, 34, '2017-07-17', 0),
(18, 26, 35, '2022-10-03', 0),
(19, 21, 36, '2018-07-13', 7),
(20, 21, 37, '2018-07-16', 10),
(21, 27, 38, '2022-10-03', 0),
(22, 25, 39, '2017-08-12', 0),
(23, 21, 40, '2018-07-30', 12),
(24, 26, 41, '2022-10-03', 0),
(25, 26, 42, '2022-10-03', 0),
(26, 26, 44, '2020-12-01', 0),
(27, 29, 45, '2018-05-06', 1),
(28, 30, 46, '2018-01-18', 0),
(29, 41, 47, '2020-08-05', 0),
(30, 32, 48, '2021-01-14', 7),
(31, 33, 49, '2021-09-01', 1),
(32, 34, 50, '2022-10-05', 0),
(33, 35, 51, '2021-11-09', 0),
(34, 35, 52, '2020-03-05', 0),
(35, 36, 53, '2022-10-01', 0),
(36, 37, 55, '2022-10-03', 0),
(37, 37, 56, '2020-01-06', 0),
(38, 31, 57, '2022-10-03', 0),
(39, 31, 58, '2022-10-04', 0),
(40, 37, 59, '2020-03-13', 0),
(41, 31, 60, '2018-12-12', 0),
(42, 38, 61, '2020-01-02', 1),
(43, 39, 62, '2022-10-03', 0),
(44, 40, 63, '2019-01-23', 0),
(45, 33, 64, '2020-11-02', 1),
(46, 9, 25, '2019-02-21', 0),
(47, 34, 65, '2021-04-05', 0),
(48, 36, 66, '2022-09-01', 0),
(49, 31, 67, '2022-10-04', 0),
(50, 41, 69, '2022-10-04', 0),
(51, 34, 70, '2022-10-03', 0),
(52, 42, 71, '2022-10-04', 0),
(53, 43, 73, '2022-10-04', 0),
(54, 31, 74, '2022-10-04', 0),
(55, 27, 75, '2020-08-13', 6),
(56, 44, 76, '2022-10-04', 0),
(57, 43, 77, '2022-10-04', 0),
(58, 43, 78, '2022-10-04', 0),
(59, 45, 79, '2022-10-05', 0),
(60, 1, 80, '2022-10-03', 0),
(61, 46, 81, '2020-08-28', 4),
(62, 47, 82, '2020-03-13', 0),
(63, 47, 83, '2020-03-13', 0),
(64, 48, 84, '2020-03-18', 0),
(65, 49, 85, '2022-07-21', 0),
(66, 34, 86, '2022-10-04', 4),
(67, 50, 87, '2020-08-12', 5),
(68, 31, 88, '2022-10-04', 0),
(69, 35, 89, '2021-01-07', 0),
(70, 51, 90, '2022-06-15', 0),
(71, 36, 91, '2022-10-03', 0),
(72, 52, 92, '2021-05-08', 1),
(73, 53, 93, '2021-07-26', 2),
(74, 31, 94, '2022-10-04', 0),
(75, 45, 95, '2022-10-05', 0),
(76, 31, 96, '2022-10-04', 0),
(77, 20, 29, '2020-08-25', 0),
(78, 41, 97, '2022-10-03', 0),
(79, 41, 98, '2021-01-06', 1),
(80, 45, 99, '2022-10-05', 0),
(81, 54, 100, '2022-10-05', 0),
(82, 31, 102, '2022-10-04', 0),
(83, 27, 103, '2022-04-04', 0),
(84, 36, 105, '2022-10-03', 0),
(85, 54, 101, '2022-10-04', 4),
(86, 31, 106, '2022-10-04', 0),
(87, 22, 107, '2022-10-05', 5),
(88, 55, 108, '2022-10-04', 0),
(89, 56, 109, '2021-05-07', 0),
(90, 57, 110, '2022-10-03', 0),
(91, 42, 111, '2022-10-04', 0),
(92, 39, 114, '2022-10-03', 0),
(93, 58, 112, '2022-10-04', 0),
(94, 59, 113, '2022-10-05', 4),
(95, 31, 115, '2022-10-04', 0),
(96, 44, 117, '2022-10-03', 0),
(97, 55, 118, '2022-10-05', 5),
(98, 31, 119, '2022-10-04', 0),
(99, 36, 120, '2022-10-03', 0),
(100, 36, 122, '2022-10-03', 0),
(101, 60, 121, '2021-07-29', 0),
(102, 33, 123, '2022-10-04', 0),
(103, 55, 124, '2022-10-04', 0),
(104, 61, 125, '2021-08-16', 0),
(105, 55, 126, '2022-10-04', 0),
(106, 27, 127, '2022-10-03', 0),
(107, 31, 128, '2022-10-04', 0),
(108, 62, 129, '2022-10-04', 3),
(109, 63, 130, '2022-10-05', 4),
(110, 31, 131, '2022-10-04', 0),
(111, 22, 132, '2022-10-05', 0),
(112, 64, 133, '2022-04-18', 0),
(113, 65, 136, '2022-05-06', 5),
(114, 66, 137, '2022-07-04', 0),
(115, 45, 138, '2022-10-05', 0),
(116, 45, 139, '2022-10-04', 3),
(117, 67, 140, '2022-10-02', 0),
(118, 60, 141, '2022-04-21', 0),
(119, 58, 142, '2022-10-05', 0),
(120, 58, 143, '2022-10-05', 0),
(121, 68, 145, '2022-06-01', 1),
(122, 26, 146, '2022-10-03', 0),
(123, 33, 144, '2022-10-04', 0),
(124, 69, 147, '2022-10-04', 0),
(125, 22, 148, '2022-10-04', 0),
(126, 34, 150, '2022-10-01', 0),
(127, 71, 151, '2022-09-07', 0),
(128, 70, 149, '2022-10-04', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tpagos_anuales`
--

CREATE TABLE `tpagos_anuales` (
  `id` int(15) NOT NULL,
  `id_empresa_base` int(15) NOT NULL,
  `handel` int(15) NOT NULL,
  `fecha` date DEFAULT NULL,
  `msg01` text,
  `msg02` text,
  `chk` int(2) NOT NULL,
  `comentario` varchar(200) NOT NULL COMMENT 'Proposito de ese pago programado',
  `importe_pago` decimal(13,2) NOT NULL,
  `is_factura` int(2) NOT NULL DEFAULT '0',
  `chk_control_cobro` int(2) NOT NULL DEFAULT '1' COMMENT 'Si es 1 se tomará en cuenta para el control de cobro de clientes'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tpagos_anuales`
--

INSERT INTO `tpagos_anuales` (`id`, `id_empresa_base`, `handel`, `fecha`, `msg01`, `msg02`, `chk`, `comentario`, `importe_pago`, `is_factura`, `chk_control_cobro`) VALUES
(103, 26, -1, '2017-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 1, 'PAGO ANUAL', '3000.00', 0, 1),
(104, 26, -1, '2018-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 1, 'PAGO ANUAL', '3000.00', 0, 1),
(105, 26, -1, '2019-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 1, 'PAGO ANUAL', '3000.00', 0, 1),
(106, 26, -1, '2020-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 1, 'PAGO ANUAL', '3000.00', 0, 1),
(107, 26, -1, '2021-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 1, 'PAGO ANUAL', '3000.00', 0, 1),
(108, 26, -1, '2022-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 0, 'PAGO ANUAL', '3000.00', 0, 1),
(109, 26, -1, '2023-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 0, 'PAGO ANUAL', '3000.00', 0, 1),
(110, 26, -1, '2024-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 0, 'PAGO ANUAL', '3000.00', 0, 1),
(111, 26, -1, '2025-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 0, 'PAGO ANUAL', '3000.00', 0, 1),
(112, 26, -1, '2026-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 0, 'PAGO ANUAL', '3000.00', 0, 1),
(113, 26, -1, '2027-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 0, 'PAGO ANUAL', '3000.00', 0, 1),
(114, 26, -1, '2028-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 0, 'PAGO ANUAL', '3000.00', 0, 1),
(115, 26, -1, '2029-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 0, 'PAGO ANUAL', '3000.00', 0, 1),
(116, 26, -1, '2030-12-01', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer, fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, el periodo de su pago anual vencio el dia {dia}/{mes}/{anio}, le pedimos ponerse en contacto con el departamento de facturacion para reactivar su servicio.', 0, 'PAGO ANUAL', '3000.00', 0, 1),
(117, 21, -1, '2017-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 1, 'PAGO ANUAL', '0.00', 0, 1),
(118, 21, -1, '2018-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(119, 21, -1, '2019-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(120, 21, -1, '2020-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(121, 21, -1, '2021-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(122, 21, -1, '2022-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(123, 21, -1, '2023-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(124, 21, -1, '2024-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(125, 21, -1, '2025-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(126, 21, -1, '2026-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(127, 21, -1, '2027-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(128, 21, -1, '2028-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(129, 21, -1, '2029-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(130, 21, -1, '2030-08-14', 'Estimado cliente, la vigencia de su pago anual esta proxima a vencer. Fecha de corte {dia}/{mes}/{anio}', 'Estimado cliente, la vigencia de su pago anual caduco el dia {dia}/{mes}/{anio}, para la reactivacion de su servicio pongase en contacto con el departamento de facturacion.', 0, 'PAGO ANUAL', '0.00', 0, 1),
(131, 28, -1, '2018-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 1, 'PAGO ANUAL', '0.00', 0, 1),
(132, 28, -1, '2019-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 1, 'PAGO ANUAL', '1000.00', 0, 1),
(133, 28, -1, '2020-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 1, 'PAGO ANUAL', '1000.00', 0, 1),
(134, 28, -1, '2021-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 1, 'PAGO ANUAL', '1000.00', 0, 1),
(135, 28, -1, '2022-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 0, 'PAGO ANUAL', '1000.00', 0, 1),
(136, 28, -1, '2023-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 0, 'PAGO ANUAL', '1000.00', 0, 1),
(137, 28, -1, '2024-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 0, 'PAGO ANUAL', '1000.00', 0, 1),
(138, 28, -1, '2025-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 0, 'PAGO ANUAL', '1000.00', 0, 1),
(139, 28, -1, '2026-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 0, 'PAGO ANUAL', '1000.00', 0, 1),
(140, 28, -1, '2027-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 0, 'PAGO ANUAL', '1000.00', 0, 1),
(141, 28, -1, '2028-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 0, 'PAGO ANUAL', '1000.00', 0, 1),
(142, 28, -1, '2029-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 0, 'PAGO ANUAL', '1000.00', 0, 1),
(143, 28, -1, '2030-12-01', 'Estimado usuario su pago anual esta pr&oacute;ximo a vencer. P&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 'Estimado usuario la vigencia anual del servicio ha caducado. Para dar soluci&oacute;n al problema  p&oacute;ngase en contacto con el departamento de facturaci&oacute;n.', 0, 'PAGO ANUAL', '1000.00', 0, 1),
(144, 43, -1, '2019-09-16', 'Estimado usuario, la vigencia de la suscripci&oacute;n anual est&aacute; pr&oacute;xima a vencer: Fecha de corte {fecha}. Para la renovaci&oacute;n p&oacute;ngase en contacto con el &aacute;rea de facturaci&oacute;n de sistemasyservicios.mx', 'Estimado usuario existe un pago pendiente por cubrir, p&oacute;ngase en contacto con el &aacute;rea de facturaci&oacute;n para la re-activaci&oacute;n del servicio.', 1, 'LICENCIA ANUAL', '31006.80', 1, 1),
(665, 67, 140, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '6254.00', 0, 0),
(666, 1, 2, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '10992.00', 0, 0),
(667, 1, 80, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '10061.00', 0, 0),
(668, 63, 130, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '5611.00', 0, 0),
(669, 58, 143, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '7412.00', 0, 0),
(670, 58, 142, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 1, 'REGALíAS, PUBLICIDAD Y REDES', '4528.00', 0, 0),
(671, 58, 112, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 1, 'REGALíAS, PUBLICIDAD Y REDES', '10765.00', 0, 0),
(672, 59, 113, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 1, 'REGALíAS, PUBLICIDAD Y REDES', '10890.00', 0, 0),
(673, 33, 123, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 1, 'REGALíAS, PUBLICIDAD Y REDES', '10526.00', 0, 0),
(674, 33, 144, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 1, 'PUBLICIDAD Y REDES', '1750.00', 0, 0),
(675, 27, 103, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '15412.00', 0, 0),
(676, 27, 38, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '20283.00', 0, 0),
(677, 27, 127, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '11278.00', 0, 0),
(678, 70, 149, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'PUBLICIDAD Y REDES', '1750.00', 0, 0),
(679, 36, 66, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 1, 'REGALíAS, PUBLICIDAD Y REDES', '9790.00', 0, 0),
(680, 36, 120, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '8448.00', 0, 0),
(681, 36, 91, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '9772.00', 0, 0),
(682, 36, 122, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 1, 'REGALíAS, PUBLICIDAD Y REDES', '7251.00', 0, 0),
(683, 36, 53, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 1, 'REGALíAS, PUBLICIDAD Y REDES', '10952.00', 0, 0),
(684, 36, 105, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 1, 'REGALíAS, PUBLICIDAD Y REDES', '5766.00', 0, 0),
(685, 22, 132, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '8225.00', 0, 0),
(686, 22, 107, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '14439.00', 0, 0),
(687, 22, 148, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'PUBLICIDAD Y REDES', '1750.00', 0, 0),
(688, 22, 28, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '26069.00', 0, 0),
(689, 22, 31, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '19222.00', 0, 0),
(690, 39, 62, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '13739.00', 0, 0),
(691, 39, 114, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '4965.00', 0, 0),
(692, 39, 62, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '18578.00', 0, 0),
(693, 39, 114, '2022-10-06', 'Estimado usuario, el tiempo límite para pago de REGALíAS, PUBLICIDAD Y REDES está próximo a vencer: Fecha de pago {fecha}.', 'Estimado usuario existe un pago pendiente de REGALíAS, PUBLICIDAD Y REDES por cubrir, póngase en contacto con el área de facturación para la re-activación del servicio.', 0, 'REGALíAS, PUBLICIDAD Y REDES', '6294.00', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tpermisos`
--

CREATE TABLE `tpermisos` (
  `id` int(11) NOT NULL,
  `handel` int(11) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `ids_privilegios` longtext,
  `tipo_viz` int(2) NOT NULL DEFAULT '1',
  `moduloInicio` varchar(30) NOT NULL,
  `visible` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tpermisos`
--

INSERT INTO `tpermisos` (`id`, `handel`, `nombre`, `ids_privilegios`, `tipo_viz`, `moduloInicio`, `visible`) VALUES
(5, 1, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(7, 2, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(11, 3, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|subNuevoProducto_ID|subServicio_ID|subNuevoServicio_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(58, 28, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(69, 28, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(70, 31, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(73, 31, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(88, 38, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(89, 38, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(121, 49, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(123, 49, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(137, 2, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(139, 53, 'ADMINISTRADOR', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|subNuevoProducto_ID|optEditProductos|optElimProductos|subEditCodigo_ID|vizPrecioFranq|subPrecios_ID|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subUpComprPag|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optCancelCte_ID|optTelNoOblig_ID|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optCancVta_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|subPedidosFranq|subRegistrosSis_ID|subCatAuxLog_ID|subGeneral_ID|optAjus_Fisc_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optVizContra_ID|optMultiSess_ID|optSincronSuc|subCerrarSes_ID|', 2, '', 0),
(140, 53, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(145, 2, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(162, 62, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(163, 62, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(167, 66, 'AGENDAR EN TODAS', 'mnuInicio_ID|optAppDesctos_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optTelNoOblig_ID|optUnifCte_ID|mnuConfiguracion_ID|subAbreCaja_ID|optAceptCeros_ID|optEditCte_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(168, 53, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(169, 53, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(176, 66, 'ADMINISTRADOR', 'mnu_inicio|mobAgenda|mobPuntoVenta|mobClientes|mobFlash|mobCortesCaja|mobEstadisticas|mobPedidos|opCerrarVistaRapida|mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optAdminHorar|adminNotific|subPuntoVenta_ID|optModPrec_ID|optModDesc_ID|optMasVend_ID|optVizPubEnGen2_ID|optQuienAtendi2_ID|optPrinTickEsp_ID|optElimVta|mnuCompras_ID|subProductos_ID|subNuevoProducto_ID|optEditProductos|optElimProductos|subEditCodigo_ID|vizPrecioFranq|subPrecios_ID|subVizPrecCompr|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subDeshOrd|subUpComprPag|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optExportCtes|optEditCliente|optAjustarPuntos_ID|optCancelCte_ID|optTelNoOblig_ID|optUnifCte_ID|subPromoVta_ID|subEditExp|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optOtrosGa|subRecCaja_ID|optSelSucRecCaja|optCancelRecCaja|subReportesFinancieros_ID|optSelectSucursal_RepFinanc_ID|optEditCtasCob_ID|optCancVta_ID|optChangeSuc_ID|optReacCte_ID|optRasigAtend|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|optSelectSucursal_NominaEmp|admCtosDedPerc|optBonos|opSaldaDeuda|opElimAbono|opElimDeuda|adminFinanzas|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|optSelSucInformes_ID|subDasBoard_ID|optSelSucGrap_ID|optUnifPromo|subFiscal_ID|subComisiEmp_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|optEditFcte_ID|optOmitValFcie|subPedidosFranq|subMSgVencim|subRegistrosSis_ID|subGeneral_ID|optAjus_Gen_ID|optAjus_notf_ID|optViCredSMS|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optVizContra_ID|optMultiSess_ID|opvizPanelCs_ID|opVizAll_ID|optSincronSuc|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, 'mnu_inicio', 0),
(177, 66, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(178, 66, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(182, 31, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(202, 75, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subReportesFinancieros_ID|optViwCortesCaja_ID|optFacturacion_ID|optFlash_ID|optRangoFechas_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(203, 75, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optCancelCte_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|subRegistrosSis_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(229, 80, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(230, 80, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(231, 80, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(235, 53, 'CONTABILIDAD', 'mnuReportes_ID|subFiscal_ID|mnuConfiguracion_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, 'subFiscal_ID', 0),
(264, 66, 'SOPORTE TECNICO', 'mnu_inicio|mobAgenda|mobPuntoVenta|mobClientes|mobFlash|mobCortesCaja|mobEstadisticas|mobPedidos|opCerrarVistaRapida|mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optPubGralAg|optAdminHorar|subPuntoVenta_ID|optModPrec_ID|optModDesc_ID|optMasVend_ID|optVizPubEnGen2_ID|optQuienAtendi2_ID|optPrinTickEsp_ID|mnuCompras_ID|subProductos_ID|subNuevoProducto_ID|optEditProductos|optElimProductos|subEditCodigo_ID|optSincronSuc|vizPrecioFranq|subPrecios_ID|subVizPrecCompr|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subDeshOrd|subEditOrd|subPedidosFranq|mnuInventarios_ID|subAlmacenesd_ID|optTransferirInventario_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optCancelCte_ID|optTelNoOblig_ID|optUnifCte_ID|subPromoVta_ID|subEditExp|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|subRecCaja_ID|optSelSucRecCaja|optCancelRecCaja|subReportesFinancieros_ID|optSelectSucursal_RepFinanc_ID|optEditCtasCob_ID|optCancVta_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|optSelectSucursal_NominaEmp|admCtosDedPerc|optBonos|opSaldaDeuda|opElimAbono|opElimDeuda|mnuReportes_ID|subInformes_ID|optSelSucInformes_ID|subDasBoard_ID|optSelSucGrap_ID|optUnifPromo|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optOpImporFalt_ID|optAceptCeros_ID|optEditCte_ID|subRegistrosSis_ID|subGeneral_ID|optAjus_notf_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optChangeSucursal_Usuarios_ID|optVizContra_ID|optMultiSess_ID|opvizPanelCs_ID|opVizAll_ID|subCerrarSes_ID|', 2, 'mnu_inicio', 0),
(272, 91, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(273, 91, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(274, 2, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(275, 1, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(276, 80, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(277, 3, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(279, 49, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(280, 38, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(281, 75, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(282, 53, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(283, 66, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(284, 91, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(285, 62, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(286, 28, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optAdminBlkHor_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(287, 31, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(297, 80, 'COMODIN', 'mnuInicio_ID|optAppDesctos_ID|optAdminBlkHor_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optTelNoOblig_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subReportesFinancieros_ID|optViwCortesCaja_ID|optFacturacion_ID|optFlash_ID|optRangoFechas_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(347, 103, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(348, 103, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(349, 103, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(354, 105, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optAdminBlkHor_ID|optBloqDur_ID|optPubGralAg|subPuntoVenta_ID|optVizPubEnGen2_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(355, 105, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(356, 105, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(368, 107, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optAdminBlkHor_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(369, 107, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(370, 107, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(385, 114, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optAdminBlkHor_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(386, 114, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(387, 114, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(388, 112, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optAdminBlkHor_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(389, 112, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(390, 112, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(391, 113, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optAdminBlkHor_ID|optBloqDur_ID|subPuntoVenta_ID|optVizPubEnGen2_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(392, 113, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1);
INSERT INTO `tpermisos` (`id`, `handel`, `nombre`, `ids_privilegios`, `tipo_viz`, `moduloInicio`, `visible`) VALUES
(393, 113, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(416, 120, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(417, 120, 'CONTABILIDAD', 'mnuReportes_ID|subFiscal_ID|mnuConfiguracion_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, 'subFiscal_ID', 0),
(418, 120, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(419, 120, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(420, 120, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(421, 122, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optAdminBlkHor_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(422, 122, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(423, 122, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(427, 123, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optAdminBlkHor_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(428, 123, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(429, 123, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(441, 127, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(442, 127, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(443, 127, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(454, 130, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(455, 130, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(456, 130, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(457, 114, 'COMODIN', 'mnuInicio_ID|optAppDesctos_ID|optAdminBlkHor_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(458, 66, 'CONTABILIDAD', 'mnuReportes_ID|subFiscal_ID|mnuConfiguracion_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, 'subFiscal_ID', 0),
(465, 132, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(466, 132, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(467, 132, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(468, 132, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(481, 38, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(492, 140, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(493, 140, 'CONTABILIDAD', 'mnuReportes_ID|subFiscal_ID|mnuConfiguracion_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, 'subFiscal_ID', 0),
(494, 140, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(495, 140, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(496, 140, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(502, 142, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(503, 142, 'CONTABILIDAD', 'mnuReportes_ID|subFiscal_ID|mnuConfiguracion_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, 'subFiscal_ID', 0),
(504, 142, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(505, 142, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(506, 142, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(507, 143, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(508, 143, 'CONTABILIDAD', 'mnuReportes_ID|subFiscal_ID|mnuConfiguracion_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, 'subFiscal_ID', 0),
(509, 143, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(510, 143, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(511, 143, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(512, 144, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(513, 144, 'CONTABILIDAD', 'mnuReportes_ID|subFiscal_ID|mnuConfiguracion_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, 'subFiscal_ID', 0),
(514, 144, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(515, 144, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(516, 144, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(524, 123, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(532, 148, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(533, 148, 'CONTABILIDAD', 'mnuReportes_ID|subFiscal_ID|mnuConfiguracion_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, 'subFiscal_ID', 0),
(534, 148, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(535, 148, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(536, 148, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(537, 149, 'CAJERO', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optBlkCaduci_ID|optMultiSess_ID|', 2, '', 1),
(538, 149, 'CONTABILIDAD', 'mnuReportes_ID|subFiscal_ID|mnuConfiguracion_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, 'subFiscal_ID', 0),
(539, 149, 'DEPILADORA', 'mnuInicio_ID|optAppDesctos_ID|optBloqDur_ID|mnuCompras_ID|subProductos_ID|mnuInventarios_ID|subSalInvent_ID|optNewSal_ID|optCancelSal_ID|subRecepcion_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optEditCte_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(540, 149, 'FRANQUICIATARIO', 'mnuInicio_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subPrecios_ID|subOmitePorCom_02|subBlokEditPrec|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optAjustarInventario_ID|optVizPanIn_Almacen_ID|optOmiteAuthAlmacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optAjustarPuntos_ID|optUnifCte_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|optOtrosGa|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|optCancelCC_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, '', 1),
(541, 149, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1),
(546, 151, 'BODEGA', 'mnuCompras_ID|subProveedores_ID|subNuewProv|subEditProv|subCompras_ID|BlkCancelOrd|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optBlkVtaEmp|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|subRecepcion_ID|subSemArti_ID|mnuConfiguracion_ID|subPedidosFranq|optDescInvent|optBlkCaduci_ID|optMultiSess_ID|subCerrarSes_ID|', 2, 'subPedidosFranq', 1),
(547, 130, 'GERENTE', 'mnuInicio_ID|optAgendaModFecAnt_ID|optAppDesctos_ID|optAgsinOpen_ID|optAdminBlkHor_ID|optBloqDur_ID|optAdminHorar|mnuCompras_ID|subProductos_ID|subCompras_ID|subNuevaOrden|subEditOrd|subUpComprPag|subModSurtir|mnuInventarios_ID|subAlmacenesd_ID|optVizPanIn_Almacen_ID|subSalInvent_ID|idNewSalidaAlmacen|optNewSal_ID|optCancelSal_ID|subEntInvent_ID|idNewEntradaAlmacen|optNewEnt_ID|optCancelEnt_ID|subTransferInv_ID|subRecepcion_ID|subSemArti_ID|mnuVentas_ID|subClientes_ID|subNuevoCliente_ID|optEditCliente|optUnifCte_ID|subPromoVta_ID|mnuRegistroCFDI_ID|subMovCaja_ID|MovAddRapid|optEnvRecEfect_ID|subRecCaja_ID|subReportesFinancieros_ID|optEditCtasCob_ID|optChangeSuc_ID|subCuentasxCobrar_ID|optNotCtasxCob_ID|subOpEmpleados|admCtosDedPerc|opSaldaDeuda|opElimAbono|opElimDeuda|opRepResumenP|opRepTotPrSe|mnuReportes_ID|subInformes_ID|subDasBoard_ID|optSelSucGrap_ID|subFiscal_ID|subComisiEmp_ID|mnuAdministracion_ID|optNotCtasxCob_ID|mnuConfiguracion_ID|subAbreCaja_ID|optOpCorteAnt_ID|optAceptCeros_ID|optEditCte_ID|subUsuarios_ID|subNuevoUsuario|optDel_Usuarios_ID|optEditUser|optChangeSucursal_Usuarios_ID|optBlkCaduci_ID|optMultiSess_ID|optImporBiSuc|optExporBiSuc|subCerrarSes_ID|', 2, '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tusuarios`
--

CREATE TABLE `tusuarios` (
  `id` int(11) NOT NULL,
  `id_empresa_base` int(11) DEFAULT '1',
  `handel` int(11) DEFAULT NULL,
  `nombre` varchar(15) DEFAULT NULL,
  `apaterno` varchar(25) DEFAULT NULL,
  `amaterno` varchar(25) DEFAULT NULL,
  `nombrecto` varchar(80) DEFAULT NULL,
  `tel1` varchar(25) DEFAULT NULL,
  `tel2` varchar(25) DEFAULT NULL,
  `email1` varchar(45) DEFAULT NULL,
  `email2` varchar(45) DEFAULT NULL,
  `id_permiso` int(11) DEFAULT NULL,
  `id_permiso_2` int(11) DEFAULT NULL COMMENT 'Permiso secundario',
  `contrasenia` varchar(45) DEFAULT NULL,
  `alias` varchar(45) DEFAULT NULL,
  `activo` varchar(5) NOT NULL DEFAULT 'Si',
  `orden` int(11) NOT NULL DEFAULT '1',
  `blk` varchar(50) NOT NULL,
  `ids_acceso_ip` text NOT NULL COMMENT 'Listado de indices que  referencian las IPs que pueden accesar con el usuario',
  `ids_cambio_sucursal` text NOT NULL COMMENT 'Ids disponibles para cambio de sucursal',
  `ids_con_privilegio_aux` text NOT NULL COMMENT 'Privilegios auxiliares del usuario',
  `precio_default` varchar(30) NOT NULL DEFAULT 'precio_normal',
  `id_personal_umov` int(11) NOT NULL COMMENT 'Id del personal que realizó el último movimiento',
  `ids_select_clasific` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tusuarios`
--

INSERT INTO `tusuarios` (`id`, `id_empresa_base`, `handel`, `nombre`, `apaterno`, `amaterno`, `nombrecto`, `tel1`, `tel2`, `email1`, `email2`, `id_permiso`, `id_permiso_2`, `contrasenia`, `alias`, `activo`, `orden`, `blk`, `ids_acceso_ip`, `ids_cambio_sucursal`, `ids_con_privilegio_aux`, `precio_default`, `id_personal_umov`, `ids_select_clasific`) VALUES
(-1, NULL, NULL, '-', '-', '-', 'System', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Si', 1, '', '', '', '', 'precio_normal', 0, ''),
(382, 36, 66, 'DEPILSEDA', '.', '', 'DEPILSEDA . ', '(921) 111-5382', '', 'liliana@depilseda.com', '', 176, NULL, '2022', 'test', 'Si', 1, '', '', '53|66|91|105|120|122|1|2|3|28|31|38|62|75|80|103|107|114|112|113|123|127|130|132|140|142|143|144|49|148|149|151|', '', 'precio_normal', 0, '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tcomprobantes_pago`
--
ALTER TABLE `tcomprobantes_pago`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tcomprobantes_pago_aux`
--
ALTER TABLE `tcomprobantes_pago_aux`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_comprobante_pago` (`id_comprobante_pago`),
  ADD KEY `tcomprobantes_pago_aux_ibfk_2` (`id_control_cobros`);

--
-- Indices de la tabla `tconfig_gral`
--
ALTER TABLE `tconfig_gral`
  ADD PRIMARY KEY (`id`),
  ADD KEY `handel` (`handel`),
  ADD KEY `id_empresa_base` (`id_empresa_base`);

--
-- Indices de la tabla `tconsumos_sms`
--
ALTER TABLE `tconsumos_sms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_empresa_base` (`id_empresa_base`),
  ADD KEY `handel` (`handel`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `tcontrol_cobros`
--
ALTER TABLE `tcontrol_cobros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_empresa_base` (`id_empresa_base`);

--
-- Indices de la tabla `tcreditos_sms`
--
ALTER TABLE `tcreditos_sms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_empresa_base` (`id_empresa_base`),
  ADD KEY `handel` (`handel`),
  ADD KEY `id_registro_pago` (`id_registro_pago`);

--
-- Indices de la tabla `tempresas`
--
ALTER TABLE `tempresas`
  ADD PRIMARY KEY (`handel`),
  ADD KEY `tempresas_handel` (`handel`),
  ADD KEY `tempresas_id_empresa_base` (`id_empresa_base`);

--
-- Indices de la tabla `tempresas_base`
--
ALTER TABLE `tempresas_base`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tmensajes_vencimiento`
--
ALTER TABLE `tmensajes_vencimiento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tpagos_anuales`
--
ALTER TABLE `tpagos_anuales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tpermisos`
--
ALTER TABLE `tpermisos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tpermisos_handel` (`handel`);

--
-- Indices de la tabla `tusuarios`
--
ALTER TABLE `tusuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tusuarios_id_empresa_base` (`id_empresa_base`),
  ADD KEY `tusuarios_handel` (`handel`),
  ADD KEY `tusuarios_id_permiso` (`id_permiso`),
  ADD KEY `tusuarios_ibfk_4` (`id_permiso_2`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tcomprobantes_pago`
--
ALTER TABLE `tcomprobantes_pago`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tcomprobantes_pago_aux`
--
ALTER TABLE `tcomprobantes_pago_aux`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tconfig_gral`
--
ALTER TABLE `tconfig_gral`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT de la tabla `tconsumos_sms`
--
ALTER TABLE `tconsumos_sms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tcontrol_cobros`
--
ALTER TABLE `tcontrol_cobros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2754;

--
-- AUTO_INCREMENT de la tabla `tcreditos_sms`
--
ALTER TABLE `tcreditos_sms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tempresas`
--
ALTER TABLE `tempresas`
  MODIFY `handel` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT de la tabla `tempresas_base`
--
ALTER TABLE `tempresas_base`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT de la tabla `tmensajes_vencimiento`
--
ALTER TABLE `tmensajes_vencimiento`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT de la tabla `tpagos_anuales`
--
ALTER TABLE `tpagos_anuales`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=694;

--
-- AUTO_INCREMENT de la tabla `tpermisos`
--
ALTER TABLE `tpermisos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=549;

--
-- AUTO_INCREMENT de la tabla `tusuarios`
--
ALTER TABLE `tusuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=383;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tcomprobantes_pago_aux`
--
ALTER TABLE `tcomprobantes_pago_aux`
  ADD CONSTRAINT `tcomprobantes_pago_aux_ibfk_1` FOREIGN KEY (`id_comprobante_pago`) REFERENCES `tcomprobantes_pago` (`id`),
  ADD CONSTRAINT `tcomprobantes_pago_aux_ibfk_2` FOREIGN KEY (`id_control_cobros`) REFERENCES `tcontrol_cobros` (`id`);

--
-- Filtros para la tabla `tconfig_gral`
--
ALTER TABLE `tconfig_gral`
  ADD CONSTRAINT `tconfig_gral_ibfk_1` FOREIGN KEY (`handel`) REFERENCES `tempresas` (`handel`),
  ADD CONSTRAINT `tconfig_gral_ibfk_2` FOREIGN KEY (`id_empresa_base`) REFERENCES `tempresas_base` (`id`);

--
-- Filtros para la tabla `tconsumos_sms`
--
ALTER TABLE `tconsumos_sms`
  ADD CONSTRAINT `tconsumos_sms_ibfk_1` FOREIGN KEY (`id_empresa_base`) REFERENCES `tempresas_base` (`id`),
  ADD CONSTRAINT `tconsumos_sms_ibfk_2` FOREIGN KEY (`handel`) REFERENCES `tempresas` (`handel`),
  ADD CONSTRAINT `tconsumos_sms_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `tusuarios` (`id`);

--
-- Filtros para la tabla `tcontrol_cobros`
--
ALTER TABLE `tcontrol_cobros`
  ADD CONSTRAINT `tcontrol_cobros_ibfk_1` FOREIGN KEY (`id_empresa_base`) REFERENCES `tempresas_base` (`id`);

--
-- Filtros para la tabla `tcreditos_sms`
--
ALTER TABLE `tcreditos_sms`
  ADD CONSTRAINT `tcreditos_sms_ibfk_1` FOREIGN KEY (`id_empresa_base`) REFERENCES `tempresas_base` (`id`),
  ADD CONSTRAINT `tcreditos_sms_ibfk_2` FOREIGN KEY (`handel`) REFERENCES `tempresas` (`handel`),
  ADD CONSTRAINT `tcreditos_sms_ibfk_3` FOREIGN KEY (`id_registro_pago`) REFERENCES `tcontrol_cobros` (`id`);

--
-- Filtros para la tabla `tpermisos`
--
ALTER TABLE `tpermisos`
  ADD CONSTRAINT `tpermisos_ibfk_1` FOREIGN KEY (`handel`) REFERENCES `tempresas` (`handel`);

--
-- Filtros para la tabla `tusuarios`
--
ALTER TABLE `tusuarios`
  ADD CONSTRAINT `tusuarios_ibfk_1` FOREIGN KEY (`handel`) REFERENCES `tempresas` (`handel`),
  ADD CONSTRAINT `tusuarios_ibfk_2` FOREIGN KEY (`id_empresa_base`) REFERENCES `tempresas_base` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
