<?php            
            //Url vista rápida x default
            $url_vista_rapida="https://www.sistemasyservicios.mx/app/modulos/mobile-home/";    

            ##################  ABRE VISTA RÁPIDA EN CIERTAS SECCIONES  ###################
            
            if(isset($openVistaRapida["agenda"])){ $url_vista_rapida="https://www.sistemasyservicios.mx/app/modulos/mobile/"; }

            ###############################################################################

            //Variables para determinar si el submenú se hara visible
            $viz=true;
            if((int)$_SESSION["tipo_viz"]==2){ $viz=false; }              
                        
            if( !isset($_SESSION['TipoMnu']) || $_SESSION['TipoMnu'] == "" ){ $_SESSION['TipoMnu'] = "menuAcordeon"; }
            $mnu->setTipoMenu($_SESSION['TipoMnu']); 

      
            /*Establece Privilegios del Menú*/
            #$mnu->setPrivilegios($_SESSION["ids_con_privilegio"]);

            /*###################################################################*/
            /*----------------------Formación del Menu------------------------*/
            /*###################################################################*/

            $mnu->setModulo("PUNTO DE VENTA");

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnu_inicio","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/visibility.png");
                        $mnu->addMenu("mnu_inicio","Vista Rápida",                                                        
                            $mnu->addSubMenu("mobAgenda",""," Agenda",$viz,"#").
                            $mnu->addSubMenu("mobPuntoVenta",""," Punto de venta",$viz,"#").
                            $mnu->addSubMenu("mobClientes",""," Clientes",$viz,"#").
                            $mnu->addSubMenu("mobFlash",""," Flash",$viz,"#").
                            $mnu->addSubMenu("mobCortesCaja",""," Cuentas cobradas",$viz,"#").                            
                            $mnu->addSubMenu("mobEstadisticas",""," Estadísticas",$viz,"#").
                            $mnu->addSubMenu("mobPedidos",""," Pedidos",$viz,"#").
                            $mnu->addSubMenu("opCerrarVistaRapida",""," Permiso para salir de vista rápida.",$viz,"#")                            
                        ,$url_vista_rapida);

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuInicio_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/calendario_bco.png");            
                        $mnu->addMenu("mnuInicio_ID","Agenda",
                            $mnu->addSubMenu("optNotMnuOpciones",""," Ocultar menú de opciones.",$viz,"#").
                            $mnu->addSubMenu("optNotNewCitas_ID",""," No se permite agendar nuevas citas.",$viz,"#").
                            $mnu->addSubMenu("optNotEditCitas_ID",""," No se permite editar citas existentes.",$viz,"#").
                            $mnu->addSubMenu("optNotEditCols_ID",""," Bloquear ajuste de columnas.",$viz,"#").
                            $mnu->addSubMenu("optNotAdminTrat_ID",""," Bloquear panel tratamientos.",$viz,"#").
                            $mnu->addSubMenu("optNotVtaProd_ID",""," Ocultar botón venta de productos.",$viz,"#").
                            $mnu->addSubMenu("optVizCitCancel_ID",""," Mostrar citas canceladas.",$viz,"#").
                            $mnu->addSubMenu("optAgendaModFecAnt_ID",""," Agendar Fechas Pasadas.",$viz,"#").
                            $mnu->addSubMenu("optNotAgenda_ID",""," Notificar cita proxima a vencer.",$viz,"#").
                            $mnu->addSubMenu("optAppDesctos_ID",""," Aplicar descuentos.",$viz,"#").
                            $mnu->addSubMenu("optAgendProx_ID",""," Visualizar solo agenda del usuario actual.",$viz,"#").
                            $mnu->addSubMenu("optAgsinOpen_ID",""," Permitir agendar aunque la caja esta cerrada.",$viz,"#").
                            $mnu->addSubMenu("optPanelMasV_ID",""," Visualizar panel Lo Mas Vendido.",$viz,"#").
                            $mnu->addSubMenu("optAdminBlkHor_ID",""," Administrar bloqueo de horarios.",$viz,"#").                            
                            $mnu->addSubMenu("optBloqDur_ID",""," Bloquear cambio en la duracion de los servicios.",$viz,"#").
                            $mnu->addSubMenu("optOmitCell",""," Permitir num. celular vacio en agregar cliente.",$viz,"#").
                            $mnu->addSubMenu("optPubGralAg",""," Permiso para agendar a Público en General.",$viz,"#").
                            $mnu->addSubMenu("optMarkEmpCit",""," Contabilizar empleados solicitados por el cliente.",$viz,"#").
                            $mnu->addSubMenu("optMarkValFalc","","  Valor inicial false (No solicitado).",$viz,"#").
                            $mnu->addSubMenu("optAdminHorar",""," Ajustar horarios y días laborales.",$viz,"#").
                            $mnu->addSubMenu("optDragDropMob",""," Arrastrar y soltar en mobiles.",$viz,"#").
                            $mnu->addSubMenu("optOmitAuthPag",""," Omitir autenticación al pagar cuenta.",$viz,"#").
                            $mnu->addSubMenu("cancPrecDinc",""," Cancelar precios asignados dinámicamente.",$viz,"#").
                            $mnu->addSubMenu("adminNotific",""," Administrar ajustes de notificaciones locales.",$viz,"#").
                            $mnu->addSubMenu("NotificCte",""," Administrar ajustes de notificaciones al cliente.",$viz,"#").
                            $mnu->addSubMenu("optNotChanPrec",""," Bloquear cambio de precio en pagar cuenta.",$viz,"#").
                            $mnu->addSubMenu("optNotCanCitas",""," Bloquear cancelación de citas.",$viz,"#").
                            $mnu->addSubMenu("optMarkPremium",""," Etiquetar clientes premium.",$viz,"#").
                            $mnu->addSubMenu("adminCtesPrem",""," Administrar ajustes clientes premium.",$viz,"#")

                        ,"https://www.sistemasyservicios.mx/app/index.php?noC=".noCac());   


                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuAgenda","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/calendario_bco.png");            
                        $mnu->addMenu("mnuAgenda","Agenda",                                                        
                            ""
                        ,"https://www.sistemasyservicios.mx/v2/apps/agenda/");  

                        
                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("subPuntoVenta_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/pos.png");
                        $mnu->addMenu("subPuntoVenta_ID","Punto de Venta",
                            $mnu->addSubMenu("optModPrec_ID",""," Modificar precios manualmente",$viz,"#").
                            $mnu->addSubMenu("optModDesc_ID",""," Modificar descripcion manualmente",$viz,"#").
                            $mnu->addSubMenu("optEsqPrec_ID",""," Aplicar esquema de precios x cliente",$viz,"#").                            
                            $mnu->addSubMenu("optMasVend_ID",""," Mostrar panel lo mas vendido.",$viz,"#").
                            $mnu->addSubMenu("optTickResum2_ID",""," Ticket Basico",$viz,"#").                            
                            $mnu->addSubMenu("optVizPubEnGen2_ID",""," Permiso para Venta Publico en General",$viz,"#").
                            $mnu->addSubMenu("optQuienAtendi2_ID",""," Seleccionar Quien Atendio",$viz,"#").
                            $mnu->addSubMenu("optPrinTickEsp_ID",""," Imprimir ticket en espera.",$viz,"#").
                            $mnu->addSubMenu("optElimVta",""," Permiso para Cancelar Cuentas Cobradas.",$viz,"#").
                            $mnu->addSubMenu("OmitRefTA",""," Omitir referencia en forma de pago TA.",$viz,"#").
                            $mnu->addSubMenu("OmitRefTR",""," Omitir referencia en forma de pago TR.",$viz,"#").
                            $mnu->addSubMenu("OmitRefDE",""," Omitir referencia en forma de pago DE.",$viz,"#").
                            $mnu->addSubMenu("optOmitTR",""," Omitir forma de pago Transferencia.",$viz,"#").
                            $mnu->addSubMenu("optOmitDE",""," Omitir forma de pago Depósito.",$viz,"#").
                            $mnu->addSubMenu("optVtaDir",""," Activar venta simplificada.",$viz,"#").
                            $mnu->addSubMenu("optValidDup",""," Aplicar validación para duplicidad de ventas.",$viz,"#").
                            $mnu->addSubMenu("optVizAllPrec",""," Visualizar todos los precios disponibles.",$viz,"#").
                            $mnu->addSubMenu("optAutentPeg",""," Atenticar ventas a público en general.",$viz,"#").
                            $mnu->addSubMenu("optHiddComis",""," Ocultar comisiones del personal.",$viz,"#")

                        ,"https://www.sistemasyservicios.mx/app/modulos/ventas/recursos/php/puntoDeVenta.php?noC=".noCac());     

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuCompras_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/prod_serv.png");
                        $mnu->addMenu("mnuCompras_ID","Productos y servicios",
                            $mnu->addSubMenu("subProductos_ID","subNuevoProducto_ID","Catálogo General",$viz,"modulos/compras/ListaProductos.php?noC=".noCac()).                            
                            $mnu->addSubMenu("optImportProd",""," Importar catálogo de excell",$viz,"#").
                            $mnu->addSubMenu("optEditProductos",""," Editar Productos",$viz,"#").
                            $mnu->addSubMenu("optElimProductos",""," Eliminar Productos",$viz,"#").
                            $mnu->addSubMenu("subEditCodigo_ID",""," Administrar Codigos",$viz,"#").
                            $mnu->addSubMenu("subOmitePorCom_01",""," Ocultar porcentaje de comisión",$viz,"#").                            
                            $mnu->addSubMenu("vizPrecioFranq",""," Visualizar precio a franquiciatario.",$viz,"#").
                            $mnu->addSubMenu("adminSegInsum",""," Administrar seguimiento de insumos.",$viz,"#").
                            $mnu->addSubMenu("viewRegPendi",""," Visualizar insumos pendientes por verificar.",$viz,"#").
                            $mnu->addSubMenu("viewTaReg",""," Configurar tarjeta de regalo.",$viz,"#").
                            $mnu->addSubMenu("notViewServ",""," Ocultar Servicios en Listado General.",$viz,"#").
                            $mnu->addSubMenu("subPrecios_ID","","Listas de Precios",$viz,"modulos/compras/ListaPrecios.php?noC=".noCac()).
                            $mnu->addSubMenu("subOmitePorCom_02",""," Ocultar porcentaje de comisión",$viz,"#").
                            $mnu->addSubMenu("subBlokEditPrec",""," Bloquear edición de precios",$viz,"#").
                            $mnu->addSubMenu("subVizPrecCompr",""," Visualizar precios de compra",$viz,"#").
                            $mnu->addSubMenu("subProveedores_ID","subNuewProv","Proveedores",$viz,"modulos/compras/ListaProveedores.php?noC=".noCac()).
                            $mnu->addSubMenu("subEditProv",""," Editar Proveedores.",$viz,"#").
                            $mnu->addSubMenu("subCompras_ID","subNuevaOrden","Ordenes de Compra",$viz,"modulos/compras/ListaOrdenComp.php?noC=".noCac()).
                            $mnu->addSubMenu("subEditOrd",""," Editar orden de compra.",$viz,"#").
                            $mnu->addSubMenu("subDeshOrd",""," Deshacer orden de compra.",$viz,"#").                            
                            $mnu->addSubMenu("BlkCancelOrd",""," Bloquear Cancelar orden de compra (Solo status).",$viz,"#").
                            $mnu->addSubMenu("subUpComprPag",""," Cargar comprobante de pago.",$viz,"#").
                            $mnu->addSubMenu("subModSurtir",""," Modificar cantidades al Surtir almacen.",$viz,"#").                            
                            $mnu->addSubMenu("subGastos_ID","subNuevoGasto_ID","Gastos",$viz,"#").
                            $mnu->addSubMenu("subServicio_ID","subNuevoServicio_ID","Material para servicios",$viz,"modulos/produccion/ListaServicios.php?noC=".noCac())
                        );

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuInventarios_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/inventario.png");
                        $mnu->addMenu("mnuInventarios_ID","Inventarios",
                            $mnu->addSubMenu("subAlmacenesd_ID","","Almacenes",$viz,"modulos/inventarios/ListaAlmacen.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelectSucursal_Almacen_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("optAjustarInventario_ID",""," Ajustar Inventario",$viz,"#").
                            $mnu->addSubMenu("optVizPanIn_Almacen_ID",""," Panel Informativo",$viz,"#").
                            $mnu->addSubMenu("optOmiteAuthAlmacen_ID",""," Omitir Autenticacion",$viz,"#").
                            $mnu->addSubMenu("subSalInvent_ID","idNewSalidaAlmacen","Salidas de Almacen",$viz,"modulos/inventarios/ListaSalidas.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelSucSal_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("optNewSal_ID",""," Permiso para Registro",$viz,"#").
                            $mnu->addSubMenu("optCancelSal_ID",""," Permiso para cancelacion",$viz,"#").
                            $mnu->addSubMenu("optOnlyVtaEmp",""," Solo venta a empleados",$viz,"#").
                            $mnu->addSubMenu("optBlkVtaEmp",""," Bloquear venta a empleados",$viz,"#").
                            $mnu->addSubMenu("subEntInvent_ID","idNewEntradaAlmacen","Entradas a Almacen",$viz,"modulos/inventarios/ListaEntradas.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelSucEnt_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("optNewEnt_ID",""," Permiso para Registro",$viz,"#").
                            $mnu->addSubMenu("optCancelEnt_ID",""," Permiso para cancelacion",$viz,"#").
                            $mnu->addSubMenu("subTransferInv_ID","","Transferir Inventario",$viz,"modulos/inventarios/recursos/php/ListaTransferencias.php?noC=".noCac()).
                            $mnu->addSubMenu("optSendReception_ID",""," Enviar a recepción de mercancía",$viz,"#").
                            $mnu->addSubMenu("subRecepcion_ID","","Recepción de Mercancia",$viz,"modulos/inventarios/recursos/php/Recepcion.php?noC=".noCac()).
                            $mnu->addSubMenu("subSemArti_ID","","Semáforo de Artículos",$viz,"modulos/reportes/recursos/php/admSemaforo.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelSucSemafArt",""," Seleccionar Sucursal",$viz,"#")
                        );


                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuVentas_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/ventas.png");
                        $mnu->addMenu("mnuVentas_ID","Clientes",
                            $mnu->addSubMenu("subConceptosVta_ID","subNuevoConceptoVta_ID","Conceptos de Venta",$viz,"#").
                            $mnu->addSubMenu("subClientes_ID","subNuevoCliente_ID","Catálogo de clientes",$viz,"modulos/ventas/ListaClientes.php?noC=".noCac()).
                            $mnu->addSubMenu("optExportCtes",""," Exportar Catálogo de Clientes",$viz,"#").
                            $mnu->addSubMenu("optEditCliente",""," Editar Cliente",$viz,"#").
                            $mnu->addSubMenu("optAjustarPuntos_ID",""," Ajustar Puntos",$viz,"#").
                            $mnu->addSubMenu("optAjustVisitas",""," Ajustar Visitas Cliente Frecuente",$viz,"#").
                            $mnu->addSubMenu("optCancelCte_ID",""," Cancelar Cliente",$viz,"#").
                            $mnu->addSubMenu("optTelNoOblig_ID",""," Teléfono no obligatorio",$viz,"#").
                            $mnu->addSubMenu("optVizOnlyTel_ID",""," Mostrar solo registros con teléfono capturado.",$viz,"#").
                            $mnu->addSubMenu("optUnifCte_ID",""," Unificar clientes",$viz,"#").
                            $mnu->addSubMenu("optViTotHist",""," Mostrar Importes en Historial de Ventas",$viz,"#").
                            $mnu->addSubMenu("viewOtherSuc",""," Mostrar registros de otras sucursales.",$viz,"#").
                            $mnu->addSubMenu("subCotizaciones_ID","subNuevaCotizacion_ID","Cotizaciones",$viz,"#").
                            $mnu->addSubMenu("subPromoVta_ID","","Promociones",$viz,"modulos/ventas/ListaPromo.php?noC=".noCac()).
                            $mnu->addSubMenu("optMultProm",""," Permiso para aplicar mas de una promoción en la misma venta",$viz,"#").
                            $mnu->addSubMenu("optPrecEro",""," Aceptar precios en cero.",$viz,"#").
                            $mnu->addSubMenu("subEditExp","","Formato expedientes",$viz,"modulos/ventas/ListaEditExp.php?noC=".noCac())
                        );

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuRegistroCFDI_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/finanzas.png");
                        $mnu->addMenu("mnuRegistroCFDI_ID","Finanzas",
                            $mnu->addSubMenu("subMovCaja_ID","MovAddRapid","Movimientos de Caja",$viz,"modulos/finanzas/ListaMovCaja.php?noC=".noCac()).
                            $mnu->addSubMenu("optCancMovCaj_ID",""," Omitir permiso de cancelacion.",$viz,"#").
                            $mnu->addSubMenu("optEnvRecEfect_ID",""," Enviar a recepcion de efectivo.",$viz,"#").
                            $mnu->addSubMenu("optOtrosGa",""," Capturar otros movimientos.",$viz,"#").
                            $mnu->addSubMenu("subRecCaja_ID","","Recepción de Efectivo",$viz,"modulos/finanzas/ListaRecCaja.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelSucRecCaja",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("optCancelRecCaja",""," Permiso para cancelación",$viz,"#").
                            $mnu->addSubMenu("subReportesFinancieros_ID","","Reportes Financieros",$viz,"modulos/finanzas/recursos/php/admReportesFin.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelectSucursal_RepFinanc_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("optViwCortesCaja_ID",""," Ocultar Cortes de Caja",$viz,"#").
                            $mnu->addSubMenu("optFlash_ID",""," Ocultar Flash",$viz,"#").
                            $mnu->addSubMenu("optRangoFechas_ID",""," Evitar consulta de ventas por rango de fechas",$viz,"#").
                            $mnu->addSubMenu("optEditCtasCob_ID",""," Editar cuentas cobradas.",$viz,"#").
                            $mnu->addSubMenu("optCancVta_ID",""," Cancelar cuentas cobradas.",$viz,"#").
                            $mnu->addSubMenu("optOnlyVTur_ID",""," Mostrar solo clientes del usuario actual.",$viz,"#").
                            $mnu->addSubMenu("optChangeSuc_ID",""," Transferir cobro a otra sucursal.",$viz,"#").
                            $mnu->addSubMenu("optReacCte_ID",""," Reactivar cortes de caja.",$viz,"#").
                            $mnu->addSubMenu("optRasigAtend",""," Editar quien atendio en agenda.",$viz,"#").
                            $mnu->addSubMenu("subCuentasxCobrar_ID","","Cuentas por Cobrar",$viz,"modulos/finanzas/ListaCtasxCobrar.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelectSucursal_CuentasxCob",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("optNotCtasxCob_ID",""," Notificar Proximo a Vencer",$viz,"#").
                            $mnu->addSubMenu("optCancelCC_ID",""," Cancelar cuentas por cobrar.",$viz,"#").
                            $mnu->addSubMenu("optCancelAB",""," Cancelar abonos.",$viz,"#").
                            $mnu->addSubMenu("subCuentasxPagar_ID","","Cuentas por Pagar",$viz,"#").                
                            $mnu->addSubMenu("subPagosProveedores_ID","","Pagos a Proveedores",$viz,"#").
                            $mnu->addSubMenu("subOpEmpleados","","Empleados",$viz,"modulos/finanzas/recursos/php/opEmpleados.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelectSucursal_NominaEmp",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("admCtosDedPerc",""," Editar conceptos percepción/deducción",$viz,"#").
                            $mnu->addSubMenu("ophidePagArchiv",""," Ocultar pagos archivados",$viz,"#").
                            $mnu->addSubMenu("optBonos",""," Configurar bonos",$viz,"#").
                            $mnu->addSubMenu("opSaldaDeuda",""," Permiso para saldar adeudo",$viz,"#").
                            $mnu->addSubMenu("opElimAbono",""," Permiso para eliminar abonos parciales",$viz,"#").
                            $mnu->addSubMenu("opElimDeuda",""," Permiso para cancelar registro de adeudo",$viz,"#").
                            $mnu->addSubMenu("opEdComPend",""," Editar comisiones pendientes por pagar.",$viz,"#").
                            $mnu->addSubMenu("opEdComPagd",""," Editar comisiones pagadas.",$viz,"#").
                            $mnu->addSubMenu("opOtrPercep",""," Administrar otras percepciones.",$viz,"#").
                            $mnu->addSubMenu("adminFinanzas",""," Administrar ajustes financieros.",$viz,"#").
                            $mnu->addSubMenu("opRepResumenP",""," Opción resumen de producción.",$viz,"#").
                            $mnu->addSubMenu("opRepTotPrSe",""," Opción totales productos y servicios.",$viz,"#").
                            $mnu->addSubMenu("opLimit7Com",""," Limitar a 7 días el periodo para el cálculo de comisiones.",$viz,"#")
                        );

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuReportes_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/reportes.png");
                        $mnu->addMenu("mnuReportes_ID","Reportes",
                            $mnu->addSubMenu("subRepCompras_ID","","Compras",$viz,"#").
                            $mnu->addSubMenu("subInformes_ID","","Informes",$viz,"modulos/reportes/ListaInformes.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelSucInformes_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("subMovInvent_ID","","Movimientos de Inventario",$viz,"modulos/reportes/ListaAlmacen.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelectSucursal_MovInvent_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("subDasBoard_ID","","Estadísticas",$viz,"modulos/reportes/ListaEstadisticas.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelSucGrap_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("optUnifPromo",""," Unificar medios promocionales.",$viz,"#").
                            $mnu->addSubMenu("optMozCitas",""," Mostrar citas x empleado.",$viz,"#").
                            $mnu->addSubMenu("subRepVentas_ID","","Ventas",$viz,"#").
                            $mnu->addSubMenu("subFiscal_ID","","Factura Global del Día",$viz,"modulos/finanzas/recursos/php/Fiscales.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelSuc_fisc_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("subComisiEmp_ID","","Comisiones Personal",$viz,"modulos/ventas/recursos/php/ListaComisionesEmp.php?noC=".noCac()).
                            $mnu->addSubMenu("optOnliComUserA",""," Solo comisiones del usuario actual.",$viz,"#")
                        );



            $mnu->setModulo("LOGISTICA");              

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuCatalogos_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/catalogos.png");
                        $mnu->addMenu("mnuCatalogos_ID","Catálogos",
                            $mnu->addSubMenu("subAuxiliares_ID","","Auxiliares",$viz,"modulos/logistica/catal/ListaCatAuxiliares.php?noC=".noCac()).
                            $mnu->addSubMenu("opCOperador_ID",""," Operadores",$viz,"#").
                            $mnu->addSubMenu("opClasRegtID",""," Clasificacion de Registros",$viz,"#").
                            $mnu->addSubMenu("opClasCteID",""," Clasificacion de Clientes",$viz,"#").
                            $mnu->addSubMenu("opClasEmpID",""," Clasificacion de Empleados",$viz,"#").
                            $mnu->addSubMenu("opTipCombID",""," Tipos de Combustibles",$viz,"#").
                            $mnu->addSubMenu("opCatVerifID",""," Verificadores",$viz,"#").                            
                            $mnu->addSubMenu("opCStatViaj_ID",""," Status de Viaje",$viz,"#").
                            $mnu->addSubMenu("opCTimeProm_ID",""," Tiempos promedio (Status)",$viz,"#").
                            $mnu->addSubMenu("opCIndColor_ID",""," Indicadores de Color",$viz,"#").
                            $mnu->addSubMenu("opConcAntic_ID",""," Conceptos de Anticipo",$viz,"#").
                            $mnu->addSubMenu("opCCtoGasto_ID",""," Conceptos de Gasto",$viz,"#").
                            $mnu->addSubMenu("opCVehiculo_ID",""," Vehiculos",$viz,"#").
                            $mnu->addSubMenu("opActuClasReg_ID",""," Actualizar clasificacion de registros.",$viz,"#").
                            $mnu->addSubMenu("opCRemolque_ID",""," Remolques",$viz,"#").                            
                            $mnu->addSubMenu("subVehiculos_ID","","Vehiculos",$viz,"#").
                            $mnu->addSubMenu("subEqEspecial_ID","","Equipo Especial",$viz,"#").
                            $mnu->addSubMenu("subEmpleados_ID","","Empleados",$viz,"#").
                            $mnu->addSubMenu("opSelSucuEmpleados_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("subClienYsocio_ID","","Clientes",$viz,"modulos/logistica/catal/ListaClientes.php?noC=".noCac()).
                            $mnu->addSubMenu("subSociosCom_ID","","Socios Comerciales",$viz,"modulos/logistica/catal/ListaSocios.php?noC=".noCac()).
                            $mnu->addSubMenu("opAltaSoCom_ID",""," Alta Socio Comercial",$viz,"#").
                            $mnu->addSubMenu("opEditSoCom_ID",""," Editar Socio Comercial",$viz,"#").
                            $mnu->addSubMenu("opCancSoCom_ID",""," Cancelar Socio Comercial",$viz,"#").
                            $mnu->addSubMenu("opGestOpera_ID",""," Gestion de Operadores",$viz,"#").
                            $mnu->addSubMenu("opGestVehic_ID",""," Gestion de Vehiculos",$viz,"#").
                            $mnu->addSubMenu("opGestCajas_ID",""," Gestion de Cajas",$viz,"#").
                            $mnu->addSubMenu("subPlantRep_ID","","Plantilla Reportes Logistica",$viz,"modulos/logistica/catal/ListaPlantillas.php?noC=".noCac()).
                            $mnu->addSubMenu("opGestPlant_ID",""," Gestion de Plantillas",$viz,"#").
                            $mnu->addSubMenu("subRecMateriales_ID","","Recursos Materiales",$viz,"#").                            
                            $mnu->addSubMenu("subProvExt_ID","","Proveedores Externos",$viz,"#").
                            $mnu->addSubMenu("subPercDeduc_ID","","Cierre de Operacion",$viz,"modulos/logistica/catal/ListaCtosPago.php?noC=".noCac()).
                            $mnu->addSubMenu("opCatEvid_ID",""," Evidencias",$viz,"#").
                            $mnu->addSubMenu("opCatLiq_ID",""," Liquidacion",$viz,"#").
                            $mnu->addSubMenu("opCatFact_ID",""," Facturacion",$viz,"#")
                        );

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuOperacion_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/operacion.png");
                        $mnu->addMenu("mnuOperacion_ID","Operación",
                            $mnu->addSubMenu("subBitCombustible_ID","","Bitácora de Combustible",$viz,"#").
                            $mnu->addSubMenu("subBitSiniestros_ID","","Bitácora de Siniestros",$viz,"#").
                            $mnu->addSubMenu("subAsigConductores_ID","","Asignar Conductores",$viz,"#").
                            $mnu->addSubMenu("subValComb_ID","","Vales de Combustible",$viz,"modulos/logistica/oper/adminVales.php?noC=".noCac()).
                            $mnu->addSubMenu("optOnlySocCom2_ID",""," Solo Socios Comerciales",$viz,"#").
                            $mnu->addSubMenu("optNoSocCom2_ID",""," Excluir Socios Comerciales",$viz,"#").                            
                            $mnu->addSubMenu("optAltaVale_ID",""," Alta de vale",$viz,"#").
                            $mnu->addSubMenu("optCancelVale_ID",""," Cancelar vale",$viz,"#").
                            $mnu->addSubMenu("optAltaCarga_ID",""," Ingresar Cargas Externas",$viz,"#").
                            $mnu->addSubMenu("optValeOblig_ID",""," Alta de Vale Obligatoria",$viz,"#").
                            $mnu->addSubMenu("optCargaOblig_ID",""," Carga Externa Obligatoria",$viz,"#").
                            $mnu->addSubMenu("optActuComb_ID",""," Actualizar Costo de Combustibles",$viz,"#").
                            $mnu->addSubMenu("optAltaRendt_ID",""," Alta Hoja Rendimiento",$viz,"#").
                            $mnu->addSubMenu("optConsuRendt_ID",""," Consultar Historico de Rendimientos",$viz,"#").                            
                            $mnu->addSubMenu("optRendtxUnid_ID",""," Consultar Rendimiento x unidades",$viz,"#").                            
                            $mnu->addSubMenu("optRendtxOper_ID",""," Consultar Rendimiento x operador",$viz,"#").
                            $mnu->addSubMenu("optCancelRend_ID",""," Cancelar Hoja de Rendimiento",$viz,"#").
                            $mnu->addSubMenu("optDatInsite_ID",""," Datos Insite",$viz,"#").
                            $mnu->addSubMenu("optModAsigViaj_ID",""," Modificar Asignacion de Viajes",$viz,"#").
                            $mnu->addSubMenu("optDieselxParc_ID",""," Aplicar Descuento de Combustible por Parcialidades",$viz,"#").
                            $mnu->addSubMenu("subMontajeEquipo_ID","","Montaje de Equipos",$viz,"#").
                            $mnu->addSubMenu("subRepNeumatico_ID","","Reparación Neumáticos",$viz,"#")
                        );

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuAdministracion_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/administracion.png");
                        $mnu->addMenu("mnuAdministracion_ID","Administración",
                            $mnu->addSubMenu("subConfPerson_ID","","Personal",$viz,"modulos/logistica/admin/ListaPersonal.php?noC=".noCac()).
                            $mnu->addSubMenu("optPagoSemanal_ID",""," Opcion de pago semanal",$viz,"#").
                            $mnu->addSubMenu("optPagoQuincen_ID",""," Opcion de pago quincenal",$viz,"#").
                            $mnu->addSubMenu("optPagoxPorcen_ID",""," Opcion de pago por porcentaje",$viz,"#").
                            $mnu->addSubMenu("optPagoxKilome_ID",""," Opcion de pago por kilometros",$viz,"#").
                            $mnu->addSubMenu("optCargFoto_ID",""," Cargar Foto",$viz,"#").
                            $mnu->addSubMenu("optReacBaja_ID",""," Reactivar Bajas",$viz,"#").
                            $mnu->addSubMenu("optNewEmple_ID",""," Alta Nuevo Empleado",$viz,"#").
                            $mnu->addSubMenu("optEditEmpl_ID",""," Consultar Registro",$viz,"#").
                            $mnu->addSubMenu("optModEmpl_ID",""," Editar Registro",$viz,"#").
                            $mnu->addSubMenu("optModComt_ID",""," Añadir Observaciones",$viz,"#").
                            $mnu->addSubMenu("optEditPago_ID",""," Editar Tipo de Pago",$viz,"#").
                            $mnu->addSubMenu("optBajaEmpl_ID",""," Baja de Empleado",$viz,"#").
                            $mnu->addSubMenu("optVigExCond_ID",""," Notificar Vigencia Licencia de Conducir",$viz,"#").
                            $mnu->addSubMenu("optVigExMedic_ID",""," Notificar Vigencia Examen Medico",$viz,"#").
                            $mnu->addSubMenu("optBVigContr_ID",""," Notificar Vigencia Contrato",$viz,"#").
                            $mnu->addSubMenu("optAjustAdeu_ID",""," Ajustar Adeudos",$viz,"#").
                            $mnu->addSubMenu("optNewAdeudo_ID",""," Alta Nuevos Adeudos",$viz,"#").
                            $mnu->addSubMenu("optGenCredenc_ID",""," Generar Credenciales de Personal",$viz,"#").
                            $mnu->addSubMenu("optAddAdeud_ID",""," Solicitar Prestamos a Personal",$viz,"#").
                            $mnu->addSubMenu("subPresupuestoID","","Presupuesto",$viz,"#").
                            $mnu->addSubMenu("subTarifas_ID","","Tarifas y Comisiones",$viz,"modulos/logistica/admin/ListaTarifas.php?noC=".noCac()).
                            $mnu->addSubMenu("subFacturacion_ID","","Facturación",$viz,"modulos/logistica/admin/ListaFacturacion.php?noC=".noCac()).
                            $mnu->addSubMenu("optGenCFDI_ID",""," Generar CFDI",$viz,"#").
                            $mnu->addSubMenu("optArcEvidNoObl_ID",""," Archivo de Evidencias no Obligatorio",$viz,"#").
                            $mnu->addSubMenu("subComprCFDI_ID","","Comprobantes CFDI",$viz,"modulos/logistica/admin/ListaCfdi.php?noC=".noCac()).
                            $mnu->addSubMenu("subCtasxCob2_ID","","Cuentas por Cobrar",$viz,"modulos/finanzas/ListaCtasxCobrar.php?noC=".noCac()."&lkif=1").
                            $mnu->addSubMenu("optSelSuc_CuentasxCob2",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("optNotCtasxCob_ID",""," Notificar Proximo a Vencer",$viz,"#").
                            $mnu->addSubMenu("subDepreciacionVehic_ID","","Depreciación de vehiculos",$viz,"#").
                            $mnu->addSubMenu("subCtasPagar_ID","","Cuentas por Pagar",$viz,"#").
                            $mnu->addSubMenu("subAnticiposID","","Pago de Anticipos",$viz,"modulos/logistica/admin/ListaAnticipos.php?noC=".noCac()).                            
                            $mnu->addSubMenu("optAnticipNotif_ID",""," Notificar Pendientes",$viz,"#").
                            $mnu->addSubMenu("optAnticAprobPag_ID",""," Aprobar Pagos",$viz,"#").
                            $mnu->addSubMenu("optAnticEditReg_ID",""," Editar Registros",$viz,"#").
                            $mnu->addSubMenu("subPagLiquidaID","","Pago de Liquidaciones",$viz,"modulos/logistica/admin/ListaLiquidaciones.php?noC=".noCac()).                            
                            $mnu->addSubMenu("optPagoLiquidNotID",""," Notificar Pendientes",$viz,"#").
                            $mnu->addSubMenu("optAnticAprobPag2_ID",""," Aprobar Pagos",$viz,"#").
                            $mnu->addSubMenu("optAnticEditReg2_ID",""," Editar Registros",$viz,"#").
                            $mnu->addSubMenu("subPagPrestaID","","Pago de Prestamos",$viz,"modulos/logistica/admin/ListaPrestamos.php?noC=".noCac()).
                            $mnu->addSubMenu("optPagoPagoNotID",""," Notificar Pendientes",$viz,"#").
                            $mnu->addSubMenu("optAnticAprobPag3_ID",""," Aprobar Pagos",$viz,"#").
                            $mnu->addSubMenu("optAnticEditReg3_ID",""," Editar Registros",$viz,"#").
                            $mnu->addSubMenu("subCtesInfoFiscID","","Clientes / Info. Fiscal",$viz,"modulos/ventas/ListaClientes.php?noC=".noCac()."&lkif=1").
                            $mnu->addSubMenu("subEvidenciasID","","Evidencias",$viz,"modulos/logistica/admin/ListaEvidencias.php?noC=".noCac()).
                            $mnu->addSubMenu("optCheckReciID",""," Verificar CheckList de Recibido",$viz,"#").
                            $mnu->addSubMenu("subEstadisticas_ID","","Estadisticas",$viz,"modulos/logistica/admin/ListaEstadisticas.php?noC=".noCac())
                        );

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuLogistica_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/logistica.png");
                        $mnu->addMenu("mnuLogistica_ID","Logistica",                            
                            $mnu->addSubMenu("subCatRutasID","","Catálogo de Rutas",$viz,"modulos/logistica/logist/ListaCatRutas.php?noC=".noCac()).
                            $mnu->addSubMenu("subUbicaVehic_ID","","Localización Vehículos",$viz,"modulos/logistica/logist/UbicaVehiculos.php?noC=".noCac()).
                            $mnu->addSubMenu("subUbicaCajas_ID","","Localización Remolques",$viz,"modulos/logistica/logist/UbicaCajas.php?noC=".noCac()).
                            $mnu->addSubMenu("subGestViajesID","subNewViaje","Gestión de Viajes",$viz,"modulos/logistica/logist/ListaGestionViajes.php?noC=".noCac()).
                            $mnu->addSubMenu("optEditViaje_ID",""," Abrir registro de viaje",$viz,"#").
                            $mnu->addSubMenu("optEditViaj2_ID",""," Editar Registro",$viz,"#").
                            $mnu->addSubMenu("optAjustShipm_ID",""," Ajustar Shipmen",$viz,"#").
                            $mnu->addSubMenu("optAjActShipm_ID",""," Permitir actualizar Shipmen despues de liquidacion",$viz,"#").
                            $mnu->addSubMenu("optSelSocCom_ID",""," Seleccionar Socios Comerciales",$viz,"#").
                            $mnu->addSubMenu("optOnlySocCom_ID",""," Solo Socios Comerciales",$viz,"#").
                            $mnu->addSubMenu("optNoSocCom_ID",""," Excluir Socios Comerciales",$viz,"#").
                            $mnu->addSubMenu("optSegViaje_ID",""," Validar Seguimiento Origen-Destino",$viz,"#").
                            $mnu->addSubMenu("optSegCiudad_ID",""," Seguimiento a Nivel de Ciudad",$viz,"#").                            
                            $mnu->addSubMenu("optAddAnticVj_ID",""," Agregar Anticipos",$viz,"#").
                            $mnu->addSubMenu("optCanAnticAp_ID",""," Permiso para cancelar anticipos validados.",$viz,"#").
                            $mnu->addSubMenu("optAddGastViajex_ID",""," Agregar Gastos",$viz,"#").
                            $mnu->addSubMenu("optPrivEvidn_ID",""," Administrar Evidencias",$viz,"#").                            
                            $mnu->addSubMenu("optValidaUpEvid_ID",""," Marcar como validado al subir la evidencia.",$viz,"#").                            
                            $mnu->addSubMenu("optNotiFaltAnt_ID",""," Notificar de viajes que requieren anticipos.",$viz,"#").
                            $mnu->addSubMenu("subContrTraficoID","","Control de Tráfico",$viz,"modulos/logistica/logist/ListaControlTrafico.php?noC=".noCac()).
                            $mnu->addSubMenu("opCaclcUtilOpID",""," Calcular Utilidad Operativa",$viz,"#").
                            $mnu->addSubMenu("optAuthAnticip_ID",""," Requerir Autorizar Anticipos",$viz,"#").
                            $mnu->addSubMenu("optLogEditReg_ID",""," Editar Registros",$viz,"#").
                            $mnu->addSubMenu("optPermVale_ID",""," Permitir editar aun si cargaron vale diesel.",$viz,"#").
                            $mnu->addSubMenu("optLogAddAntic_ID",""," Agregar Anticipos",$viz,"#").
                            $mnu->addSubMenu("optAddGasto_ID",""," Agregar Gastos",$viz,"#").
                            $mnu->addSubMenu("optAddIncidenc_ID",""," Agregar Incidencias",$viz,"#").
                            $mnu->addSubMenu("optAddDocum_ID",""," Agregar Documentos",$viz,"#").
                            $mnu->addSubMenu("optAddComent_ID",""," Agregar Comentarios",$viz,"#").
                            $mnu->addSubMenu("optAddAccesor_ID",""," Agregar Accesorio",$viz,"#").
                            $mnu->addSubMenu("optOnliSocCom_ID",""," Solo Socios Comerciales",$viz,"#").
                            $mnu->addSubMenu("optNotSocCom_ID",""," Excluir Socios Comerciales",$viz,"#").
                            $mnu->addSubMenu("optRepTiempos_ID",""," Reportar Tiempos Promedio",$viz,"#").
                            $mnu->addSubMenu("optAddCtoAnt_ID",""," Agregar Nuevos Conceptos de Anticipo",$viz,"#").
                            $mnu->addSubMenu("optAddCtoGas_ID",""," Agregar Nuevos Conceptos de Gasto",$viz,"#").
                            $mnu->addSubMenu("subCartasPorteID","","Cartas Porte",$viz,"modulos/logistica/logist/AdminCartasP.php?noC=".noCac()).
                            $mnu->addSubMenu("optInfoEvid_ID",""," Incluir Informacion de Evidencias",$viz,"#").
                            $mnu->addSubMenu("subGestionCobranzaID","","Gestión de Cobranza",$viz,"#").
                            $mnu->addSubMenu("subRecEvidencID","","Pre-Liquidaciones",$viz,"modulos/logistica/logist/AdminEvidencias.php?noC=".noCac()).
                            $mnu->addSubMenu("optEvidDocs_ID",""," Documentación del viaje",$viz,"#").
                            $mnu->addSubMenu("optEvidGastos_ID",""," Gastos Comprobados",$viz,"#").
                            $mnu->addSubMenu("optAddAntic02_ID",""," Ingresar anticipos",$viz,"#").
                            $mnu->addSubMenu("subLiquidacionesID","","Liquidaciones",$viz,"modulos/logistica/logist/AdminLiquidaciones.php?noC=".noCac()).
                            $mnu->addSubMenu("optCerrarLiq_ID",""," Cerrar Liquidación",$viz,"#")
                        );

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuMantenimiento_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/mantenimiento.png");
                        $mnu->addMenu("mnuMantenimiento_ID","Mantenimiento",
                            $mnu->addSubMenu("subTareasManttoID","","Tareas de Mantenimiento",$viz,"#").
                            $mnu->addSubMenu("subOrdenesServID","","Crear Ordenes de Servicio",$viz,"#").
                            $mnu->addSubMenu("subReportFallasID","","Reportar Fallas",$viz,"#").
                            $mnu->addSubMenu("subCalendarioID","","Calendario",$viz,"#").
                            $mnu->addSubMenu("subHistManttoID","","Historiales Mantenimiento",$viz,"#").
                            $mnu->addSubMenu("subHistorialConsumID","","Historiales Consumos",$viz,"#")
                        );

                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuNeumaticos_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/neumaticos.png");
                        $mnu->addMenu("mnuNeumaticos_ID","Neumáticos",
                            $mnu->addSubMenu("subAlmacenID","","Almacén",$viz,"#").
                            $mnu->addSubMenu("subMontarDesmID","","Montar Desmontar",$viz,"#").
                            $mnu->addSubMenu("subMedicionesID","","Mediciones",$viz,"#").
                            $mnu->addSubMenu("subRenovacionesID","","Renovaciones",$viz,"#").
                            $mnu->addSubMenu("subCambiosPosID","","Cambios de Posición",$viz,"#").
                            $mnu->addSubMenu("subHistoriaGralID","","Historia General",$viz,"#")
                        );

            $mnu->setModulo("AJUSTES GENERALES");
                        if((int)$_SESSION["tipo_viz"]==2)
                        $mnu->setVisible(is_priv("mnuConfiguracion_ID","boolean"));
                        $mnu->setIcon($PROF."recursos/css/img/configuracion.png");
                        $mnu->addMenu("mnuConfiguracion_ID","Administración",
                            $mnu->addSubMenu("subAbreCaja_ID","","Abrir o Cerrar Caja",$viz,"modulos/configuracion/recursos/php/Caja.php?noC=".noCac()).                                
                            $mnu->addSubMenu("optOpCorteAnt_ID",""," Obtener fondo de caja de importe reportado en corte anterior.",$viz,"#").
                            $mnu->addSubMenu("optAceptCeros_ID",""," Aceptar importes en ceros.",$viz,"#").
                            $mnu->addSubMenu("optEditCte_ID",""," Editar totales del corte.",$viz,"#").
                            $mnu->addSubMenu("optEditFcte_ID",""," Editar fecha de corte.",$viz,"#").
                            $mnu->addSubMenu("optOmitValFcie",""," Omitir validación de fecha anterior de corte.",$viz,"#").
                            $mnu->addSubMenu("optSendSMSOpen",""," Permitir envío de SMS al Abrir Caja.",$viz,"#").
                            $mnu->addSubMenu("optSelcajero",""," Permitir Seleccionar Cajero.",$viz,"#").
                            $mnu->addSubMenu("subPedidosFranq","","Pedidos",$viz,"modulos/compras/ListaPedidos.php?noC=".noCac()).
                            $mnu->addSubMenu("optDescInvent",""," Descontar del Inventario los Pedidos Enviados.",$viz,"#").
                            $mnu->addSubMenu("subMSgVencim","","Cobranza franquiciatarios",$viz,"modulos/configuracion/ListaMSG.php?noC=".noCac()).                            
                            $mnu->addSubMenu("subRegistrosSis_ID","","Registros del Sistema",$viz,"modulos/configuracion/ListaRegistrosSistema.php?noC=".noCac()).
                            $mnu->addSubMenu("subDocumentos_ID","","Documentos",$viz,"#").
                            $mnu->addSubMenu("subCatAuxLog_ID","","Catálogos auxiliares",$viz,"modulos/configuracion/ListaCatAuxiliares.php?noC=".noCac()).
                            $mnu->addSubMenu("subCobranza_ID","","Cobranza",$viz,"modulos/configuracion/ListaCobranza.php?noC=".noCac()).
                            $mnu->addSubMenu("subGeneral_ID","","General",$viz,"modulos/configuracion/ListaGeneral.php?noC=".noCac()).                            
                            $mnu->addSubMenu("optAjus_Gen_ID",""," Ajustes Generales",$viz,"#").
                            $mnu->addSubMenu("optAjus_Pos_ID",""," Ajustes Punto de Venta",$viz,"#").
                            $mnu->addSubMenu("optAjus_Fisc_ID",""," Ajustes Información Fiscal",$viz,"#").
                            $mnu->addSubMenu("optAjus_Logi_ID",""," Ajustes Logística",$viz,"#").
                            $mnu->addSubMenu("optAjus_notf_ID",""," Ajustes Notificaciones SMS",$viz,"#").
                            $mnu->addSubMenu("optNotMenPend_ID",""," Ocultar notificaciones del sistema.",$viz,"#").
                            $mnu->addSubMenu("optViCredSMS",""," Visualizar Tabla de Creditos SMS.",$viz,"#").
                            $mnu->addSubMenu("optViSobresDin",""," Visualizar Tabla Sobres de Dinero x Sucursal.",$viz,"#").
                            $mnu->addSubMenu("optViComprob",""," Visualizar Comprobaciones del sistema.",$viz,"#").
                            $mnu->addSubMenu("optViLicenc",""," Ocultar gestión de licencias en Administrador.",$viz,"#").
                            $mnu->addSubMenu("opt1MesAntig",""," Limitar antiguedad de 1 mes en consulta de registros en Administrador.",$viz,"#").
                            $mnu->addSubMenu("subPermisos_ID","","Catálogos de Permisos",$viz,"modulos/configuracion/ListaPermisos.php?noC=".noCac()).
                            $mnu->addSubMenu("optSelectSucursal_Permisos_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("subUsuarios_ID","subNuevoUsuario","Usuarios",$viz,"modulos/configuracion/ListaUsuarios.php?noC=".noCac()).
                            $mnu->addSubMenu("optDel_Usuarios_ID",""," Cancelar Usuarios",$viz,"#").
                            $mnu->addSubMenu("optEditUser",""," Editar Usuarios",$viz,"#").
                            $mnu->addSubMenu("optSelectSucursal_Usuarios_ID",""," Seleccionar Sucursal",$viz,"#").
                            $mnu->addSubMenu("optChangeSucursal_Usuarios_ID",""," Transferir Usuario a Otra Sucursal",$viz,"#").
                            $mnu->addSubMenu("optVizContra_ID",""," Mostrar Password",$viz,"#").
                            $mnu->addSubMenu("optBlkCaduci_ID",""," Blokear por caducidad de licencia",$viz,"#").
                            $mnu->addSubMenu("optMultiSess_ID",""," Multiples sesiones de usuario",$viz,"#").
                            $mnu->addSubMenu("opOcultaPorcc_ID",""," Ocultar ajustes de porcentajes de comisión",$viz,"#").
                            $mnu->addSubMenu("opvizPanelCs_ID",""," Visualizar panel cambio de sucursal",$viz,"#").
                            $mnu->addSubMenu("opEditPrivil_ID",""," Editar permisos (Agregar privilegios adicionales).",$viz,"#").
                            $mnu->addSubMenu("opvizSelClasif",""," Seleccionar clasificación de servicios y productos.",$viz,"#").
                            $mnu->addSubMenu("opVizAll_ID",""," Mostrar usuarios ocultos.",$viz,"#").
                            $mnu->addSubMenu("optSincronSuc",""," Visualizar Botón Sincronizar Sucursales",$viz,"#").
                            $mnu->addSubMenu("optNotSubPoint",""," Evitar que los descuentos resten puntos promocionales.",$viz,"#").
                            $mnu->addSubMenu("optPagPtos100",""," Permitir pagar con puntos al 100%.",$viz,"#").
                            $mnu->addSubMenu("optPagTayPtos",""," Permitir pago con tarjeta y puntos.",$viz,"#").                            
                            $mnu->addSubMenu("optNotPayPtos",""," Blokear pago con puntos.",$viz,"#").
                            $mnu->addSubMenu("optImporBiSuc",""," Importar usuarios desde otra sucursal",$viz,"#").
                            $mnu->addSubMenu("optExporBiSuc",""," Exportar usuarios a otra sucursal",$viz,"#").
                            $mnu->addSubMenu("optAdminDocs",""," Administrar Documentos.",$viz,"#").
                            $mnu->addSubMenu("optCtrlAsist",""," Administrar Control de Asistencia.",$viz,"#").
                            $mnu->addSubMenu("subPlantRep2_ID","","Plantilla Reportes POS",$viz,"modulos/logistica/catal/ListaPlantillas.php?mod=pos&noC=".noCac()).
                            $mnu->addSubMenu("opGestPlant2_ID",""," Gestion de Plantillas",$viz,"#").                            
                            $mnu->addSubMenu("subCerrarSes_ID","","Cerrar Sesion",$viz,"recursos/php/cerrar.php?noC=".noCac())
                        );


/*-------------------------------------------------------------------------------------------------------*/
//                                                MENÚ BLOQUES
/*-------------------------------------------------------------------------------------------------------*/


$mnu->addMnuBloque( array("subAbreCaja_ID") ,"Abrir o cerrar caja","002-switch.png","modulos/configuracion/recursos/php/Caja.php?noC=".noCac());
$mnu->addMnuBloque( array("mnuInicio_ID") ,"Agenda","001-date.png","index.php?noC=".noCac());
$mnu->addMnuBloque( array("subPuntoVenta_ID") ,"Punto de venta","003-cart.png","modulos/ventas/recursos/php/puntoDeVenta.php?noC=".noCac());
$mnu->addMnuBloque( array("MovAddRapid","subMovCaja_ID") ,"Nuevo Gasto","001-spending.png","modulos/finanzas/recursos/php/addMovCaja.php?noC=".noCac());
$mnu->addMnuBloque( array("subComisiEmp_ID") ,"Ver Comisiones","001-calculator.png","modulos/ventas/recursos/php/ListaComisionesEmp.php?noC=".noCac());
$mnu->addMnuBloque( array("subOpEmpleados") ,"Pagar Comisiones","011-employee.png","modulos/finanzas/recursos/php/opEmpleados.php?noC=".noCac());
$mnu->addMnuBloque( array("subNuevoCliente_ID","subClientes_ID") ,"Expediente Clientes","expediente.png","modulos/ventas/ListaClientes.php?noC=".noCac());
$mnu->addMnuBloque( array("subCuentasxCobrar_ID"),"Ctas. x Cobrar","002-debt.png","modulos/finanzas/ListaCtasxCobrar.php?noC=".noCac());
$mnu->addMnuBloque( array("subAlmacenesd_ID"),"Almacenes","008-box.png","modulos/inventarios/ListaAlmacen.php?noC=".noCac());
$mnu->addMnuBloque( array("opAjustesGrales"),"Ajustes generales","003-settings.png","#");