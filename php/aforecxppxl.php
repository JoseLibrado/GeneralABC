<?php
include_once('Clases/Cafxrxcxppxl.php');

$arrDatos = array();
isset($_POST['curp']) ? $arrDatos['curp'] = $_POST['curp'] : $arrDatos['curp'] = '' ;
isset($_POST['nss']) ? $arrDatos['nss'] = $_POST['nss'] : $arrDatos['nss'] = '' ;
isset($_POST['opcion']) ? $iOpcion = $_POST['opcion'] : $iOpcion = $_POST['opcion'] = '';

if( $iOpcion == '3' ) 
{
    $res = Servicios::listaServicios();
    echo json_decode($res);
}

if( $iOpcion == '4' ) 
{
    $res = Servicios::ambientarTurnos();
    echo json_decode($res);
}


if ( !empty($arrDatos['curp']) || !empty($arrDatos['nss']) )
{
	$res = AgregarTrabajadorPgSafre::agregarTrabajador($arrDatos['curp'], $arrDatos['nss'] );
    echo json_decode($res);
} 


