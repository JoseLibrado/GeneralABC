import Peticion from '../js/clases/Peticion.js';
import { modal, cerrarModal } from './clases/Modal.js'; 

// rutas
let urlReq = '../afxreCxppxl/php/aforecxppxl.php';

// objetos 
let objReq = new Peticion();

//obtener lista de servicios
//llamado de servicios con async - await
async function lista_serviciosasync() {

    let res = objReq.peticion(urlReq, 'post', { opcion: 3, }, false);

    const librado = await res;
    librado.forEach(element => {
        let servicio = element.motivocod + ' ' + element.motivodesc;
        if ( element.motivocod == 1053 || element.motivocod == 1054 || element.motivocod == 1055 || element.motivocod == 2031 )
        {
            $('#servicio').append(`<option value="${element.motivocod}">${servicio}</option>`);                       
        }
        else {

            $('#servicio').append(`<option value="${element.motivocod}" disabled >${servicio}</option>`);
        }

    });
}

async function ambientarTurnos() {
    let resp = objReq.peticion(urlReq, 'post', {opcion: 4, }, false);

    const result = await resp;

    return result;

}

async function modalasync(){
  
    let respuesta = await ambientarTurnos();   

    //alert("Se ambientaron 10 turnos para la tienda #" + respuesta[0].turnos);
    let modalComponente = $('#modal-ser');
      let headerModal ='A F X R X - C X P P X L' ;
      let bodyModal = '<h2>Se realizo el ambiente para 10 turnos en tienda #: <span>'+ respuesta[0].turnos +'</span></h2>';
      modal(modalComponente,headerModal, bodyModal, '','text-success',()=>{ });

  }

//llamar a los servicios
lista_serviciosasync();

//boton limpiar
$('#limpiar').click(() => {
    $('#nss').val('');
    $('#curp').val('');
    $('#servicio').val('0');
});

$('#turnos').click( () => {

    modalasync();   
    
});
