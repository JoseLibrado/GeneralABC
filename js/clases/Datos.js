
export default class Datos {
    nss = '';
    curp = '';
    nfolio = '';
    fena = '';
    paterno = '';
    materno = '';
    nombres = '';
    genero = '';
    servicio = 0;

    constructor(){
    }

    set_datos(nss, curp, nfolio, fena, paterno, materno, nombres, genero, servicio){

        this.nss = nss;
        this.curp = curp;
        this.nfolio = nfolio;
        this.fena = fena;
        this.paterno = paterno;
        this.materno = materno;
        this.nombres = nombres;
        this.genero = genero;
        this.servicio = servicio;
    }

    get_datos_obj(nss, curp, nfolio, fena, paterno, materno, nombres, genero, servicio){

       return {
                nss: this.nss,
                curp: this.curp,
                nfolio: this.nfolio,
                fena: this.fena,
                paterno: this.paterno,
                materno: this.materno,
                nombres: this.nombres,
                genero: this.genero,
                servicio: this.servicio,
            }
    }

}