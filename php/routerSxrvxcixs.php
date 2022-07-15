<?php
include_once('Clases/CAmbientarServicios.php');

isset($_POST['curp']) ? $arrDatos['curp'] = $_POST['curp'] : $arrDatos['curp'] = '';
isset($_POST['fena']) ? $arrDatos['fechana'] = $_POST['fena'] : $arrDatos['fechana'] = '';
isset($_POST['genero']) ? $arrDatos['genero'] = $_POST['genero'] : $arrDatos['genero'] = '';
isset($_POST['materno']) ? $arrDatos['materno'] = $_POST['materno'] : $arrDatos['materno'] = '';
isset($_POST['nfolio']) ? $arrDatos['nfolio'] = $_POST['nfolio'] : $arrDatos['nfolio'] = '';
isset($_POST['nombres']) ? $arrDatos['nombres'] = $_POST['nombres'] : $arrDatos['nombres'] = '';
isset($_POST['nss']) ? $arrDatos['nss'] = $_POST['nss'] : $arrDatos['nss'] = '';
isset($_POST['paterno']) ? $arrDatos['paterno'] = $_POST['paterno'] : $arrDatos['paterno'] = '';
isset($_POST['servicio']) ? $arrDatos['servicio'] = $_POST['servicio'] : $arrDatos['servicio'] = null ;
isset($_POST['servicio']) ? $iOpcion = $_POST['servicio'] : $iOpcion = $_POST['servicio'] = null;

switch($iOpcion)
    {
        case '1053':
            $res = CAmbientarServicios::ambientarServicio_1053($arrDatos);
            echo json_decode($res);
            break;
        case '1054':
            $res = CAmbientarServicios::ambientarServicio_1053($arrDatos);
            echo json_decode($res);
            break;
        case '1055':
            $res = CAmbientarServicios::ambientarServicio_1053($arrDatos);
            echo json_decode($res);
            break;
        case '2031':
            $res = CAmbientarServicios::ambientarServicio_2031($arrDatos);
            echo json_decode($res); 
            break;
        default:
        break;

    }