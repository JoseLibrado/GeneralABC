<?php

class CcurlApi 
{

    public function apirest($sControlador, $sFuncion, $arrDatos)
    {

        $host = filter_input(INPUT_SERVER, 'HTTP_HOST', FILTER_SANITIZE_STRING);
        //API URL
        $url = 'http://'.$host.'/apiafxrxcxppxlmxdxlx/codeigniter/'.$sControlador.'/'.$sFuncion.'/';

        $data = http_build_query($arrDatos);
        //inicializa sesion curl para consumir api

        $ch = curl_init();

        //establecer opsion para la url
        curl_setopt($chi, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
        // peticion por post

        //API key
        $apiKey = '1234';

        //Auth credentials
        $usr = "admin";
        $in = "1234";

        curl_setopt($ch, CURLOPT_HTTPHEADER, array("X-API-KEY: " . $apiKey));
        curl_setopt($ch, CURLOPT_USERPWD, "$usr:$in");

        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, TRUE, $data);



        // realiza la peticion si obtener datos
        $res = curl_exec($ch);

        if ( curl_errorno($ch) )
        {
            return curl_errno($ch);
        } 
        else {
            return $res;
        }

    }
}