

export default class Peticion {
    resData;
    resErr;
    
    constructor(){
      console.log('constructor clase Peticion.....');
    }

    
    peticion(urlPet, tipo, objDatos,sinc){
        let resData = '';
        console.log('Objeto de Datos a enviar por POST: \n',objDatos);
        $.ajax({
            url: urlPet,
            async: sinc,
            headers: {'X-Requested-With': 'XMLHttpRequest'},
            type: tipo,
            data: objDatos,
            success: function(data){
                resData = JSON.parse(data);  
            },
            error: function(err){
                console.log('Error:',err);
            },
            
        });  
        return resData.registros;        
    }
}

