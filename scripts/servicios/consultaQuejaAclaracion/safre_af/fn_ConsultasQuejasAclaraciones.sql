DROP FUNCTION fn_ConsultasQuejasAclaraciones(INTEGER, INTEGER, CHAR, CHAR, CHAR, INTEGER);
CREATE FUNCTION fn_ConsultasQuejasAclaraciones( fservicio INTEGER, fFoliorec INTEGER, fTipoId CHAR(2), fNss CHAR(11), fCurp CHAR(18), fNfolio INTEGER  )

RETURNING INTEGER AS servicio_amb;

DEFINE iServicio INTEGER;		
		
		IF ( fservicio = 1053 OR fservicio = 1054 OR fservicio = 1055 ) THEN			
			
			IF NOT EXISTS ( SELECT 	'X' FROM rec_solicitud WHERE folio_rec = fFoliorec AND tipo_id = fTipoId AND motivo_cod = fservicio ) THEN
				
				INSERT INTO rec_solicitud 
				(folio_rec  ,tipo_id    ,n_unico             ,n_seguro  ,n_folio ,origen_rec,medio_cod,tipo_cod,motivo_cod,retiroesar,tipoformatoesar,freclamo        ,finicio         ,ffin_est        ,ffin_real       ,codven      ,termino_cod,ftermino        ,operador  ,usuario   ,estado_rec,referencia    ,tiempo_ini    ,tiempo_fin    ,sub_termino_cod,motivo_cancelacion,idmotcancelacion,impresionesp,impresionesprev) VALUES
				(fFoliorec  ,fTipoId    ,fCurp				 ,fNss		,fNfolio ,1         ,1        ,1007    ,fservicio ,null      ,null           ,'01-01-1900'    ,'01-01-1900'    ,'08-29-2016'	,'01-01-1900'    ,'1104068927',0          ,'01-01-1900'    ,'96581409','96581409',1013      ,'            ','21:39:37'    ,'12:44:14'    ,null           ,null              ,null            ,null        ,null           )
				;
					
			ELSE
				DELETE FROM rec_solicitud WHERE folio_rec = fFoliorec AND tipo_id = fTipoId AND motivo_cod = fservicio;
				
				INSERT INTO rec_solicitud 
				(folio_rec  ,tipo_id    ,n_unico             ,n_seguro  ,n_folio ,origen_rec,medio_cod,tipo_cod,motivo_cod,retiroesar,tipoformatoesar,freclamo        ,finicio         ,ffin_est        ,ffin_real       ,codven      ,termino_cod,ftermino        ,operador  ,usuario   ,estado_rec,referencia    ,tiempo_ini    ,tiempo_fin    ,sub_termino_cod,motivo_cancelacion,idmotcancelacion,impresionesp,impresionesprev) VALUES
				(fFoliorec  ,fTipoId    ,fCurp				 ,fNss		,fNfolio ,1         ,1        ,1007    ,fservicio ,null      ,null           ,'01-01-1900'    ,'01-01-1900'    ,'08-29-2016'	,'01-01-1900'    ,'1104068927',0          ,'01-01-1900'    ,'96581409','96581409',1013      ,'            ','21:39:37'    ,'12:44:14'    ,null           ,null              ,null            ,null        ,null           )
				;
						
			END IF;
			
			LET iServicio = fservicio;
			
		ELSE 
			LET iServicio = 0;
		END IF;
		RETURN iServicio;

END FUNCTION;