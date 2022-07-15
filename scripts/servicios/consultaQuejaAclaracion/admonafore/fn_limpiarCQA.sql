CREATE OR REPLACE FUNCTION fn_limpiarCQA( fservicio INTEGER, fTipoServicio CHARACTER, fCurp CHARACTER, fNss CHARACTER )
		RETURNS INTEGER AS 
$BODY$
	DECLARE
		respuesta INTEGER;
		
		BEGIN
			IF NOT EXISTS ( SELECT 'Z' FROM recSolicitudServicio WHERE folioServicio = fservicio  ) THEN
			
				respuesta = 0;
				 
								
			ELSE 
			
				DELETE FROM recSolicitudServicio WHERE folioServicio = fservicio AND tipoServicio = fTipoServicio;
				DELETE FROM recSolicitudServicio WHERE curp = fCurp ;
			
				respuesta = 1;
				
			END IF;
					
			RETURN respuesta;
			
		END;

$BODY$

LANGUAGE plpgsql VOLATILE SECURITY DEFINER
CALLED ON NULL INPUT;
COMMENT ON FUNCTION fn_limpiarCQA( INTEGER, CHARACTER, CHARACTER, CHARACTER) IS 'funcion para elimiar los registros asociados al foliorec y datos curp,nss,
tablas: recSolicitudServicio';
