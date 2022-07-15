--DROP TYPE typ_respuestasAmbientacion;
CREATE TYPE typ_respuestasAmbientacion AS
(
    cCurp CHARACTER(18),
    cNss CHARACTER(11),
    iNfolio BIGINT,
    dFechaNac DATE,
    cApellidoPat CHARACTER(40),
    cApellidoMat CHARACTER(40),
    cNombre CHARACTER(60),
    sSexo INT
);
COMMENT ON TYPE typ_respuestasAmbientacion IS 'type para alojar las respuestas de la funcion fn_aggTrabajadorAfglobal';