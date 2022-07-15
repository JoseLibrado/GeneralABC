--SELECT * FROM fn_aggTrabajadorAfglobal('LORM521001HDFPBG03','01725243834','2219458','1952-10-01','LOPEZ','ROBLEDO','MIGUEL ANGEL',1);
--DROP FUNCTION fn_aggTrabajadorAfglobal(CHAR, CHAR, INTEGER, DATE, CHAR, CHAR, CHAR, INTEGER);

CREATE OR REPLACE FUNCTION fn_aggTrabajadorAfglobal(CHAR(18), CHAR(11), INTEGER, DATE, CHAR(30), CHAR(30),CHAR(30),INTEGER)
RETURNS SETOF typ_respuestasAmbientacion AS $$

DECLARE
cCurp			ALIAS	FOR $1;
cNss			ALIAS	FOR $2;
iNfolio			ALIAS	FOR $3;
dFechaNac		ALIAS	FOR $4;
cApellidoPat	ALIAS	FOR $5;
cApellidoMat	ALIAS	FOR $6;
cNombre			ALIAS	FOR $7;
sSexo			ALIAS	FOR $8;

respuestas typ_respuestasAmbientacion;

biDpersona INTEGER;

iBanderaAfopCuoDia INTEGER;
iTrabajador INTEGER;

iTrabajadorEim INTEGER;
iBanderaEimaestro INTEGER;

iTrabajadorEiser INTEGER;
iBanderaEiservicios INTEGER;

iTrabajadorEiserdp INTEGER;
iBanderaEiserviciosdp INTEGER;

iBanderaEnroltrabajador INTEGER;
iFenrol INTEGER;

BEGIN

	biDpersona = 0;

	iBanderaAfopCuoDia = 0;
	iTrabajador = 0;

	iTrabajadorEim = 0;
	iBanderaEimaestro = 0;

	iTrabajadorEiser = 0;
	iBanderaEiservicios = 0;
	
	iTrabajadorEiserdp = 0;
	iBanderaEiserviciosdp = 0;

	iBanderaEnroltrabajador = 0;
	iFenrol = 0;

	IF EXISTS (SELECT 'OK' FROM  afop_cuota_diaria WHERE n_unico = cCurp OR n_seguro = cNss) THEN
		SELECT COUNT(n_unico) INTO iTrabajador FROM  afop_cuota_diaria WHERE n_unico = cCurp OR n_seguro = cNss;
		IF (iTrabajador > 1) THEN
			DELETE FROM afop_cuota_diaria WHERE n_unico = cCurp OR n_seguro = cNss ;
			
			INSERT INTO afop_cuota_diaria 
			(tipo_solicitud,n_folio ,n_seguro     ,n_unico             ,n_rfc                    ,fentcons    ,finicta     ,sexo    ,fena      ,paterno      ,materno      ,nombres  ,codpos ,ciudad_cod,ciudad_desc                               ,calle                                                         ,numero      ,colonia                                                       ,telefono                                  ,estad_cod,estad_desc                                 ,ipsvrorigen      ,depto       ,entidad_nacimiento,frecafor    ,statusinterno,tel_cod,identificadorunico) VALUES
			(1             ,iNfolio ,cNss        ,cCurp                ,SUBSTR(cCurp,1,10)||'6H2','2021-04-22','2021-04-22',sSexo   ,dFechaNac ,cApellidoPat ,cApellidoMat ,cNombre  ,'94020',3000      ,'                                        ','C 19 DE SEPTIEMBRE                                          ','2         ','TLALTETELA                                                  ','2282552675                              ',30       ,'VERACRUZ                                ' ,'10.26.190.137  ','          ',30                ,'2021-04-22',200          ,4      ,1169630978        )
			;
			--Bandera se asigna 1 para confirmar que se ambiento en tabla
			iBanderaAfopCuoDia = 1;
		ELSE 
			IF EXISTS (SELECT 'OK' FROM  afop_cuota_diaria WHERE n_unico = cCurp AND n_seguro = cNss) THEN
				--Bandera se asigna 2 para confirmar que ya existia trabajador
				iBanderaAfopCuoDia = 2;
			ELSE
			END IF;
		END IF;
	ELSE
		INSERT INTO afop_cuota_diaria 
		(tipo_solicitud,n_folio ,n_seguro     ,n_unico             ,n_rfc                    ,fentcons    ,finicta     ,sexo    ,fena      ,paterno      ,materno      ,nombres  ,codpos ,ciudad_cod,ciudad_desc                               ,calle                                                         ,numero      ,colonia                                                       ,telefono                                  ,estad_cod,estad_desc                                 ,ipsvrorigen      ,depto       ,entidad_nacimiento,frecafor    ,statusinterno,tel_cod,identificadorunico) VALUES
		(1             ,iNfolio ,cNss        ,cCurp                ,SUBSTR(cCurp,1,10)||'6H2','2021-04-22','2021-04-22',sSexo   ,dFechaNac ,cApellidoPat ,cApellidoMat ,cNombre  ,'94020',3000      ,'                                        ','C 19 DE SEPTIEMBRE                                          ','2         ','TLALTETELA                                                  ','2282552675                              ',30       ,'VERACRUZ                                ' ,'10.26.190.137  ','          ',30                ,'2021-04-22',200          ,4      ,1169630978        )
		;
		--Bandera se asigna 3 para confirmar que se inserto nuevo registro
		iBanderaAfopCuoDia = 3;
	END IF;

	IF EXISTS (SELECT 'OK' FROM  eimaestro WHERE folio = iNfolio ) THEN
		SELECT COUNT(curp) INTO iTrabajadorEim FROM  eimaestro WHERE curp = cCurp OR nss = cNss;
		IF (iTrabajadorEim < 1) THEN
			DELETE FROM eimaestro WHERE folio = iNfolio ;
			
			INSERT INTO eimaestro 
            (fecharegistro   ,fechaactualizacion,fechasolicitud  ,folio   ,tiposervicio,estatus,nss          ,curp   ,rfc                      ,nombres       ,apellidopaterno    ,apellidomaterno        ,fechanacimiento ,genero,nacionalidad,entidadnacimiento,telefono01  ,tipotelefono01,telefono02  ,tipotelefono02,correoelectronico                                   ,fechavencimientoidoficial,tipocomprobantedomicilio,promotor,claveconsar ,finado,clientecoppel,tiposolicitante,tieneexpedientebiometrico,tipomovimiento,flujovalidacion,indicadortransitorio,mdcreplica,folioservicioenrolado,tiposervicioenrolado,captura10huellas,moddatosmenores) VALUES
            (CURRENT_DATE    ,CURRENT_DATE      ,CURRENT_DATE    ,iNfolio ,2022        ,0      ,cNss         ,cCurp  ,SUBSTR(cCurp,1,10)||'6H2',cNombre       ,cApellidoPat       ,cApellidoMat           ,dFechaNac       ,sSexo ,1           ,30               ,'2282552676',1             ,'          ',-1            ,'jose.soto@aforecoppel.com                         ','2030-04-19'             ,0                       ,94462291,'1212055626',0     ,0            ,0              ,2                        ,0             ,'  '           ,0                   ,0         ,0                    ,0                   ,null            ,0              )
            ;
			--insert para cuando no exista el campo mdcreplica
			--INSERT INTO eimaestro 
			--(fecharegistro   ,fechaactualizacion,fechasolicitud  ,folio   ,tiposervicio,estatus,nss          ,curp   ,rfc                      ,nombres       ,apellidopaterno    ,apellidomaterno        ,fechanacimiento ,genero,nacionalidad,entidadnacimiento,telefono01  ,tipotelefono01,telefono02  ,tipotelefono02,correoelectronico                                   ,fechavencimientoidoficial,tipocomprobantedomicilio,promotor,claveconsar ,finado,clientecoppel,tiposolicitante,tieneexpedientebiometrico,tipomovimiento,flujovalidacion,indicadortransitorio,folioservicioenrolado,tiposervicioenrolado,captura10huellas,moddatosmenores)VALUES
			--(CURRENT_DATE    ,CURRENT_DATE      ,CURRENT_DATE    ,iNfolio ,2022        ,0      ,cNss         ,cCurp  ,SUBSTR(cCurp,1,10)||'6H2',cNombre       ,cApellidoPat       ,cApellidoMat           ,dFechaNac       ,sSexo ,1           ,30               ,'2282552676',1             ,'          ',-1            ,'jose.soto@aforecoppel.com                         ','2030-04-19'             ,0                       ,94462291,'1212055626',0     ,0            ,0              ,2                        ,0             ,'  '           ,0                   ,0                    ,0                   ,null            ,0              );
			
			--Bandera se asigna 1 para confirmar que se ambiento en tabla
			iBanderaEimaestro = 1;
		ELSE 
						
			IF NOT EXISTS (SELECT 'OK' FROM  eimaestro WHERE curp = cCurp AND nss = cNss AND FOLIO = iNfolio ) THEN
				DELETE FROM eimaestro WHERE folio = iNfolio ;
				
				UPDATE eimaestro SET folio = iNfolio WHERE curp = cCurp AND nss = cNss;
				iBanderaEimaestro = 2;
			ELSE
			END IF;
		END IF;
	ELSE
		INSERT INTO eimaestro 
        (fecharegistro   ,fechaactualizacion,fechasolicitud  ,folio   ,tiposervicio,estatus,nss          ,curp   ,rfc                      ,nombres       ,apellidopaterno    ,apellidomaterno        ,fechanacimiento ,genero,nacionalidad,entidadnacimiento,telefono01  ,tipotelefono01,telefono02  ,tipotelefono02,correoelectronico                                   ,fechavencimientoidoficial,tipocomprobantedomicilio,promotor,claveconsar ,finado,clientecoppel,tiposolicitante,tieneexpedientebiometrico,tipomovimiento,flujovalidacion,indicadortransitorio,mdcreplica,folioservicioenrolado,tiposervicioenrolado,captura10huellas,moddatosmenores) VALUES
        (CURRENT_DATE    ,CURRENT_DATE      ,CURRENT_DATE    ,iNfolio ,2022        ,0      ,cNss         ,cCurp  ,SUBSTR(cCurp,1,10)||'6H2',cNombre       ,cApellidoPat       ,cApellidoMat           ,dFechaNac       ,sSexo ,1           ,30               ,'2282552676',1             ,'          ',-1            ,'jose.soto@aforecoppel.com                         ','2030-04-19'             ,0                       ,94462291,'1212055626',0     ,0            ,0              ,2                        ,0             ,'  '           ,0                   ,0         ,0                    ,0                   ,null            ,0              )
        ;
		--Bandera se asigna 3 para confirmar que se inserto nuevo registro
		iBanderaEimaestro = 3;
	END IF;


	IF NOT EXISTS ( SELECT 'OK' FROM eiservicios WHERE folio IN (iNfolio::CHAR(10), iNfolio::CHAR(10) || '-S') ) THEN
		
		SELECT MAX(idpersona)+1 INTO biDpersona FROM eiservicios;

		INSERT INTO eiservicios 
		(fechaalta                 ,folio            ,tiposervicio,estatusexpediente,clientecoppel,tienda,numempleado,idpersona  ,tipoidoficial,tipocompdomicilio,fechavencimientoidoficial,fechavencimientocompdomicilio,finado,altamodificacion,grupodatos                      ,estatuscertificaexp,estatuscertificaop13,estatuscertificaimg,excepcionhuella,estatuscertificaop14,movimientobeneficiarios) VALUES
		('2021-04-22'              ,iNfolio || '-S'  ,2040        ,5                ,0            ,5     ,90078981   ,bIdpersona ,3            ,1                ,'1900-01-01'             ,'1900-01-01'                 ,0     ,1               ,'                              ',102                ,202                 ,102                ,'-1 '          ,0                   ,0                      )
		;
	
		iBanderaEiservicios = 1;

	ELSE 
		UPDATE eiservicios SET tiposervicio = '2040', estatusexpediente = 5 WHERE folio IN (iNfolio::CHAR(10), iNfolio::CHAR(10) || '-S'); 		
		
		iBanderaEiservicios = 2;

	END IF;

	SELECT idpersona INTO biDpersona FROM eiservicios WHERE folio IN (iNfolio::CHAR(10), iNfolio::CHAR(10) || '-S'); 

	IF NOT EXISTS ( SELECT 'OK' FROM eiserviciosdatospersonales WHERE idpersona = biDpersona ) THEN
		IF NOT EXISTS ( SELECT 'OK' FROM eiserviciosdatospersonales WHERE nss = cNss OR curp = cCurp OR folio = iNfolio::CHAR(10) ) THEN
			INSERT INTO eiserviciosdatospersonales 
			(folio      			,idpersona      ,tipopersona    ,nss            ,curp                   ,rfc                            ,nombre             ,apellidopaterno    ,apellidomaterno    ,fechanacimiento    ,genero     ,nacionalidad   ,entidadnacimiento  )VALUES
			(iNfolio::CHAR(10)	    ,biDpersona     ,1              ,cNss           ,cCurp                  ,SUBSTR(cCurp,1,10)||'6H2'      ,cNombre            ,cApellidoPat       ,cApellidoMat       ,dFechaNac          ,sSexo      ,1              ,5                  );

			iBanderaEiserviciosdp = 1;
		ELSE
			IF ( (SELECT COUNT(*) FROM eiserviciosdatospersonales WHERE nss = cNss OR curp = cCurp OR folio = iNfolio::CHAR(10)) > 1 ) THEN
				IF NOT EXISTS ( SELECT 'OK' FROM eiserviciosdatospersonales WHERE nss = cNss AND curp = cCurp AND folio = iNfolio::CHAR(10) ) THEN
					INSERT INTO eiserviciosdatospersonales 
					(folio      			,idpersona      ,tipopersona    ,nss            ,curp                   ,rfc                            ,nombre             ,apellidopaterno    ,apellidomaterno    ,fechanacimiento    ,genero     ,nacionalidad   ,entidadnacimiento  )VALUES
					(iNfolio::CHAR(10)	    ,biDpersona     ,1              ,cNss           ,cCurp                  ,SUBSTR(cCurp,1,10)||'6H2'      ,cNombre            ,cApellidoPat       ,cApellidoMat       ,dFechaNac          ,sSexo      ,1              ,5                  );

					iBanderaEiserviciosdp = 1;
				ELSE 
					UPDATE eiserviciosdatospersonales SET idpersona = biDpersona WHERE nss = cNss AND curp = cCurp AND folio = iNfolio::CHAR(10) ;
					iBanderaEiserviciosdp = 2;
				END IF;
			ELSE 
				IF NOT EXISTS ( SELECT 'OK' FROM eiserviciosdatospersonales WHERE nss = cNss AND curp = cCurp AND folio = iNfolio::CHAR(10) ) THEN
					INSERT INTO eiserviciosdatospersonales 
					(folio      			,idpersona      ,tipopersona    ,nss            ,curp                   ,rfc                            ,nombre             ,apellidopaterno    ,apellidomaterno    ,fechanacimiento    ,genero     ,nacionalidad   ,entidadnacimiento  )VALUES
					(iNfolio::CHAR(10)	    ,biDpersona     ,1              ,cNss           ,cCurp                  ,SUBSTR(cCurp,1,10)||'6H2'      ,cNombre            ,cApellidoPat       ,cApellidoMat       ,dFechaNac          ,sSexo      ,1              ,5                  );

					iBanderaEiserviciosdp = 1;
				ELSE
					UPDATE eiserviciosdatospersonales SET idpersona = biDpersona WHERE nss = cNss AND curp = cCurp AND folio = iNfolio::CHAR(10) ;
					iBanderaEiserviciosdp = 2;
				END IF;
			END IF;
		END IF;
	ELSE
		IF NOT EXISTS ( SELECT 'OK' FROM eiserviciosdatospersonales WHERE nss = cNss AND curp = cCurp AND idpersona = biDpersona AND folio = iNfolio::CHAR(10) ) THEN
			IF NOT EXISTS ( SELECT 'OK' FROM eiserviciosdatospersonales WHERE nss = cNss AND curp = cCurp AND folio = iNfolio::CHAR(10) ) THEN
				IF NOT EXISTS ( SELECT 'OK' FROM eiserviciosdatospersonales WHERE nss = cNss AND curp = cCurp ) THEN
					INSERT INTO eiserviciosdatospersonales 
					(folio      			,idpersona      ,tipopersona    ,nss            ,curp                   ,rfc                            ,nombre             ,apellidopaterno    ,apellidomaterno    ,fechanacimiento    ,genero     ,nacionalidad   ,entidadnacimiento  )VALUES
					(iNfolio::CHAR(10)    	,biDpersona     ,1              ,cNss           ,cCurp                  ,SUBSTR(cCurp,1,10)||'6H2'      ,cNombre            ,cApellidoPat       ,cApellidoMat       ,dFechaNac          ,sSexo      ,1              ,5                  );

					iBanderaEiserviciosdp = 1;
				ELSE	
					UPDATE eiserviciosdatospersonales SET idpersona = biDpersona, folio = iNfolio::CHAR(10) WHERE nss = cNss AND curp = cCurp; 
					iBanderaEiserviciosdp = 2;
				END IF;
			ELSE 
				UPDATE eiserviciosdatospersonales SET idpersona = biDpersona WHERE nss = cNss AND curp = cCurp;
				iBanderaEiserviciosdp = 2;
			END IF;
		--ELSE
			--UPDATE eiserviciosdatospersonales SET idpersona = biDpersona WHERE nss = cNss AND curp = cCurp;
			--iBanderaEiserviciosdp = 2;
		END IF;
	END IF;


	IF NOT EXISTS ( SELECT 'OK' FROM enroltrabajadores WHERE curp = cCurp ) THEN

		SELECT MAX(folioenrolamiento)+1 INTO iFenrol FROM enroltrabajadores;

		INSERT INTO enroltrabajadores 
		(fechaalta                 ,folioenrolamiento,tiposolicitud,numfuncionario,curp                ,estatus,estatusvalidacion,diagnosticoprocesar1,diagnosticoprocesar2,diagnosticoprocesar3,estatusaudio,fecharenbio     ,estatuscertificaacubio,estatuscertificaop13,fechavalidacion ,mdcreplica) VALUES
		('2020-10-23 13:31:20'     ,iFenrol          ,2040         ,90078981      ,cCurp               ,1      ,1                ,'   '               ,'   '               ,'   '               ,0           ,'1900-01-01'    ,102                   ,202                 ,'2020-10-26'    ,0         )
		;

		iBanderaEnroltrabajador = 1;

	ELSE
		
		UPDATE enroltrabajadores SET tiposolicitud = '2040', estatus = 1, estatusvalidacion = 1 WHERE curp = cCurp;
		
		iBanderaEnroltrabajador = 2;

	END IF;

	respuestas.cCurp = cCurp;
	respuestas.cNss = cNss;
	respuestas.iNfolio = iNfolio;
	respuestas.dFechaNac = dFechaNac;
	respuestas.cApellidoPat = cApellidoPat;
	respuestas.cApellidoMat = cApellidoMat;
	respuestas.cNombre = cNombre;
	respuestas.sSexo = sSexo;

	RETURN NEXT respuestas;
	RETURN;
END;

$$

LANGUAGE plpgsql VOLATILE SECURITY DEFINER
CALLED ON NULL INPUT;
COMMENT ON FUNCTION fn_aggTrabajadorAfglobal(CHAR, CHAR, INTEGER, DATE, CHAR, CHAR,CHAR,INT) IS 'funcion para agregar trabajadores en aforeglobal,
tablas: afop_cuota_diaria, eimaestro, eiservicios, eiserviciosdatospersonales';