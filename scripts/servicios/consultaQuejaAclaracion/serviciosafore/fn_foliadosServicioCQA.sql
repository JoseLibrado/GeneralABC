CREATE OR REPLACE FUNCTION fn_foliadosServicioCQA( fTipoServicio CHARACTER )
		RETURNS INTEGER AS 
$BODY$
	DECLARE
		iFolio INTEGER;
		
		BEGIN
			
			SELECT MAX(folio)+1 INTO iFolio FROM FoliadorServicios WHERE tipoServicio= fTipoServicio; 
			
			RETURN iFolio;
			
		END;

$BODY$

LANGUAGE plpgsql VOLATILE SECURITY DEFINER
CALLED ON NULL INPUT;
COMMENT ON FUNCTION fn_foliadosServicioCQA(fTipoServicio CHARACTER) IS 'funcion para obtener el folio maximo+1 en servicios,
tablas: FoliadorServicios';

--SELECT fn_foliadosServicioCQA AS folio FROM fn_foliadosServicioCQA( 'C' ); parametro {A: aclaraciones, C: consulta, Q: queja}