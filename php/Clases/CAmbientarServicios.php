<?php

include_once('Capi.php');
//include_once('CcurlApi.php');

class CAmbientarServicios{

    public function __construct()
    {
        $constructor = true;
    }
    
    public static function ambientarServicio_1053($arr)
    {
        $objApi = new Capirest();        
        $arrDatos = array(  'nss' => $arr['nss'],
                            'curp' => $arr['curp'],
                            'nfolio' => $arr['nfolio'],
                            'servicio' => $arr['servicio']);
                            
        try
        {  
            $resApi = $objApi->apirest('CtrlConsAclQueja','ambientacionCAQ',$arrDatos);

            if( $resApi )
            {
                return $resApi;
            }

        }
        catch( Exception $e)
        {
            return $e;
        }
    }

    public static function ambientarServicio_2031($arr)
    {
        $objApi = new Capirest();
        $arrDatos = array(
                'nss' => $arr['nss'],
                'curp' => $arr['curp'],
                'nombre' => $arr['nombres'],
                'paterno' => $arr['paterno'],
                'materno' => $arr['materno'],
                //'servicio' => $arr['servicio']
        );

        try {
            $resApi = $objApi->apirest('CtrlAmbientarEstadoCuenta','setCuatrimestre',$arrDatos);

            if( $resApi ) {
                return $resApi;
            }
        }
        catch( Exception $e ){
            return $e->getMessage();
        }


    }

}