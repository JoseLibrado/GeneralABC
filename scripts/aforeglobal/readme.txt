creacion de repositorio para funciones sql en postgres.

-- tablas que algunos servicios validan 
-eiservicios -- folio = eimaestro.folio

SELECT MAX(idpersona)+1 INTO biDpersona FROM eiservicios;

INSERT INTO eiservicios 
(fechaalta                 ,folio            ,tiposervicio,estatusexpediente,clientecoppel,tienda,numempleado,idpersona  ,tipoidoficial,tipocompdomicilio,fechavencimientoidoficial,fechavencimientocompdomicilio,finado,altamodificacion,grupodatos                      ,estatuscertificaexp,estatuscertificaop13,estatuscertificaimg,excepcionhuella,estatuscertificaop14,movimientobeneficiarios) VALUES
(YEAR(TODAY) - 1           ,iNfolio || '-S'  ,2040        ,5                ,0            ,5     ,90078981   ,bIdpersona ,3            ,1                ,'01-01-1900'             ,'01-01-1900'                 ,0     ,1               ,'                              ',102                ,202                 ,102                ,'-1 '          ,0                   ,0                      )
;

-eiserviciosdatospersonales
INSERT INTO eiserviciosdatospersonales 
(folio      ,idpersona      ,tipopersona    ,nss            ,curp                   ,rfc                            ,nombre             ,apellidopaterno    ,apellidomaterno    ,fechanacimiento    ,genero     ,nacionalidad   ,entidadnacimiento  )VALUES
(iNfolio    ,biDpersona     ,1              ,cNss           ,cCurp                  ,SUBSTR(cCurp,1,10)||'6H2'      ,cNombre            ,cApellidoPat       ,cApellidoMat       ,dFechaNac          ,sSexo      ,1              ,5                  );

-enroltrabajadores
INSERT INTO enroltrabajadores 
(fechaalta                 ,folioenrolamiento,tiposolicitud,numfuncionario,curp                ,estatus,estatusvalidacion,diagnosticoprocesar1,diagnosticoprocesar2,diagnosticoprocesar3,estatusaudio,fecharenbio     ,estatuscertificaacubio,estatuscertificaop13,fechavalidacion ,mdcreplica) VALUES
('2020-10-23 13:31:20'     ,12104535         ,2040         ,90078981      ,'SACA600815HDFLDS08',1      ,1                ,'   '               ,'   '               ,'   '               ,0           ,'1900-01-01'    ,102                   ,202                 ,'2020-10-26'    ,0         )
;

eiservicios "folio!" 123456-S
eiserviciosdatospersonales "folio"  123456
enroltrabajadores "folioenrolamiento" !=  

