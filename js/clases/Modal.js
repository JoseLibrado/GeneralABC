
export const modal = (modalConponente,title, bodyhtml, controlshtml,classTexto, callback) => {
    let cabecera;
    let cuerpo;
    let piedepagina;
    let modal;
    
    modalConponente.removeClass('none');
    cabecera = `<div class="modal-header"><h1>${title}</h1></div>`;
    cuerpo = '<div class="modal-body '+ classTexto + '">' + bodyhtml +'</div>';
    piedepagina = `<div class="modal-footer">${controlshtml}</div>`;
    modal = `<div class="content-modal">
              ${cabecera}
              ${cuerpo}
              ${piedepagina}
            </div>`;  
    modalConponente.prepend(modal);
    callback();
  return modal;
}

export const cerrarModal = (componenteModal) => {
  let padre = componenteModal.first();
  console.log('modal cerrado');
  padre[0].firstChild.remove();
  $('#modal-ser').addClass('none');
  
}