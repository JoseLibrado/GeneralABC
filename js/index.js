import Datos from './clases/Datos.js';
import Peticion from './clases/Peticion.js';
import { modal, cerrarModal } from './clases/Modal.js'; 


// variables
let sNss;
let sCurp;
let sServicio;

let resAmbienteServicio;
//variable para almacenar la referencia del componente del modal. se utiliza esta variable para agregar contenido de modales y remover el contenido agregado.


//urls
let urlSolcitudConsultaDatosTrabajador = '../afxreCxppxl/php/aforecxppxl.php';
let urlSolicitudAmbientarServicio = '../afxreCxppxl/php/routerSxrvxcixs.php';
//objetos
const objpeticion = new Peticion();
const objdatos = new Datos();

//BEGIN PASO 1: CONSULTAR LA INFORMACION DEL TRABAJADOR SAFRE_AFOREGLOBAL
async function consultarTrabajador(){    
  objdatos.set_datos(sNss, sCurp,'','','','','','',0);
  let respuesta = await objpeticion.peticion(urlSolcitudConsultaDatosTrabajador, 'post', { nss: objdatos.nss, curp: objdatos.curp }, false );
  return respuesta;
}

async function async_consultarTrabajador(){
  let resServicio;
  let respuesta = await consultarTrabajador();
  console.log('Datos trabajador: \n',respuesta);
  objdatos.set_datos(respuesta[0].NSS, respuesta[0].CURP.trim(), respuesta[0].NFOLIO, respuesta[0].FECHANACIMIENTO, respuesta[0].PATERNO.trim(), respuesta[0].MATERNO.trim(), respuesta[0].NOMBRES.trim(), respuesta[0].GENERO, sServicio);
  resServicio =  await async_ambientarTrabajador();
     
  return resServicio;
  
}
//END PASO 1: CONSULTAR LA INFORMACION DEL TRABAJADOR SAFRE_AFOREGLOBAL

//BEGIN PASO 2: REALIZAR AMBIENTACION DEL SERVICIO
async function ambientarTrabajador(){ 
  let respuesta = objpeticion.peticion(urlSolicitudAmbientarServicio, 'post',objdatos.get_datos_obj(), false);
  resAmbienteServicio = await respuesta;
  return respuesta;
}

async function async_ambientarTrabajador(){
  let respuesta = await ambientarTrabajador();
  console.log('Datos ambientacion: \n',respuesta[0]);
  return respuesta;
}

async function alert_servicio(){
  let respuesta = async_consultarTrabajador();
  const res = await respuesta;
  //return res[0].SERVICIO_AMB;
}
//END PASO 2: REALIZAR AMBIENTACION DEL SERVICIO



// detonacion de eventos clicks

//detonador consultar trabajador y ambientador.
$('#consultar').click(() => {
  
  let modalComponente = $('#modal-ser');
  
  sNss = $('#nss').val();
  sCurp = $('#curp').val();
  sServicio = $('#servicio').val();

  if ( sNss == '' && sCurp == '' ){ 
    //alert('Favor de Ingresar algun dato');
    let headerModal ='A F X R X - C X P P X L' ;
    let bodyModal = '<h3>No se ingreso nss o curp para ser ambientado</h3>';
    modal(modalComponente,headerModal, bodyModal, '','text-warning',()=>{ });
  } else {
  
    if ( sServicio != 0 ){
      async_consultarTrabajador();
      setTimeout(()=>{
          let headerModal ='E X I T O' ;
          let bodyModal = '<h2>Se realizo el ambiente para servicio: <span>'+ resAmbienteServicio[0].SERVICIO_AMB +'</span></h2>';
          modal(modalComponente,headerModal, bodyModal, '','text-success',()=>{ });
        },1000);
        $('#nss').val('');
        $('#curp').val('');
        $('#servicio').val('0');
    }else {
      //alert('FAVOR DE SELECCIONAR UN SERVICIO');
      let modalComponente = $('#modal-ser');
      let headerModal ='A F X R X - C X P P X L' ;
      let bodyModal = '<h3>Favor de seleccionar algun Servicio activo en la lista.</h3>';
      modal(modalComponente,headerModal, bodyModal, '','text-warning',()=>{ });
    }
    
  }
  
});
//Boton para cerrar modal despues de haber ambientado un servicio.
$('#modal-btn').click(() => {
  console.log('se presiono boton para cerrar modal');
  cerrarModal($('#modal-ser'));
});