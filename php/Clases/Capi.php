<?php

class Capirest 
{

    public function apirest($sControlador, $sFuncion, $arrDatos)
    {
        
        $host = filter_input(INPUT_SERVER, 'HTTP_HOST', FILTER_SANITIZE_STRING);
		//API URL
		$url = 'http://'.$host.'/apiafxrxcxppxlmxdxlx/codeigniter/'.$sControlador.'/'.$sFuncion.'/';
		//API key
		$apiKey = '1234';

		//Auth credentials
		$usr = "admin";
		$in = "1234";
		//create a new cURL resource
		//INICIALIZA SESION curl
		$ch = curl_init($url);

		curl_setopt($ch, CURLOPT_TIMEOUT, 30);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
		curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
		//-------------------------------------TOKEN----------------------------------------------

		$arrDatos["componente"] = false; 	 //  CON TOKEN: true , SIN TOKEN: false
		if(isset($_SESSION["authorization"])){	
			curl_setopt($ch, CURLOPT_HTTPHEADER, array("X-API-KEY: " . $apiKey, "Authorization: " . $_SESSION["authorization"]));
		}else{
			curl_setopt($ch, CURLOPT_HTTPHEADER, array("X-API-KEY: " . $apiKey));
		}
		//------------------------------------FIN TOKEN-------------------------------------------
		curl_setopt($ch, CURLOPT_HTTPHEADER, array("X-API-KEY: " . $apiKey));
		curl_setopt($ch, CURLOPT_USERPWD, "$usr:$in");

		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $arrDatos);

		$result = curl_exec($ch);

		//close cURL resource
		curl_close($ch);

		return $result;
    }
    



}