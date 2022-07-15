<?php
include_once('Capi.php');
include_once('CcurlApi.php');
//llamado api


class AgregarTrabajadorPgSafre
{
    
    public function __construct()
    {
        $constructor = true;
    }

    public static function agregarTrabajador($cCurp, $cNss)
    {
        $objApi = new Capirest();
        $arrDatos = array('curp' => $cCurp, 'nss' => $cNss);

        try 
        {
            $resApi = $objApi->apirest('CtrlAgregarTrabajador','setTrabajadorAforeglobalSafre',$arrDatos);

            if( $resApi )
            {
                // echo $resApi;
                return $resApi;
            }
        }
        catch( Exception $e )
        {
            return $e;
        }

    }

    public static function obtenerCurp($cCurp)
    {
        $objApi = new Capirest();
        $arrDatos = array('cCurp' => $cCurp);

        try 
        {
            $resApi = $objApi->apirest('CtrlAgregarTrabajador','consultarCurp',$arrDatos);

            if( $resApi )
            {
                echo $resApi;
                //return $resApi;
            }
        }
        catch( Exception $e )
        {
            return $e;
        }
    }

    public static function obtenerNss($cCurp)
    {
        $objApi = new Capirest();        
        $arrDatos = array('cCurp' => $cCurp);

        try
        {  
            $resApi = $objApi->apirest('CtrlAgregarTrabajador','pruebaConsultaNss',$arrDatos);

            if( $resApi )
            {
                // echo $resApi;
                return $resApi;
            }

        }
        catch( Exception $e)
        {
            return $e;
        }

    }

}

class Servicios
{
    public function __construct()
    {
        $constructor = true;
    }
    
    public static function listaServicios()
    {
        $objApi = new Capirest();        
        $arrDatos = array();

        try
        {  
            $resApi = $objApi->apirest('CtrlLostaServicios','obtenerListaServicio',$arrDatos);

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

    public static function ambientarTurnos()
    {
        $objApi = new Capirest();        
        $arrDatos = array();

        try
        {  
            $resApi = $objApi->apirest('CtrlLostaServicios','generarturnos',$arrDatos);

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
}

