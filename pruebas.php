<?php

include_once('./php/Clases/Capi.php');

$api = new Capirest();

$arrDatos = array('curp' => $cCurp, 'nss' => $cNss);

try {
    $resApi = $api->apirest('CtrlAmbientarEstadoCuenta','getCuatrimestre',$arrDatos);
    print_r($resApi);
}
catch(Exception $e){
    $excepcion = $e->getMessage();
    var_dump($excepcion);
}

