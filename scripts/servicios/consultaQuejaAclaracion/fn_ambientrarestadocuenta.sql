
--SELECT * FROM fn_ambientarestadocuenta('2021-05-01','2021-08-31','29169478509','SOOL940219HSLTBB05','JOSE LIBRADO SOTO OBESO');

CREATE OR REPLACE FUNCTION fn_ambientarestadocuenta(
    dFechaIni DATE,
    fechafin DATE,
    cNss CHARACTER(11),
    cCurp CHARACTER(11),
    cNombre CHARACTER(60)
)
    RETURNS INTEGER AS 
$$
    DECLARE
    BEGIN

        FOR counter IN 1..3 LOOP
            INSERT INTO tbestadocuentaafore_anualizada
            (fechainianual,fechaini,fechafin,nss,curp,rfc,siefore,indicadorafiliacion,indicadoredocta,nombre,callenumero,colonia,codpostal,centroreparto,entidadfederativa,delegacionmunicipio,folioedocta,saldoahorroretiroini,saldoahorroretiroaporte,saldoahorroretiroretiros,saldoahorroretirorendimiento,saldoahorroretirocomision,saldoahorroretirofin,saldoahorrovoluntarioini,saldoahorrovoluntarioaporte,saldoahorrovoluntarioretiro,saldoahorrovoluntariorend,saldoahorrovoluntariocomision,saldoahorrovoluntariofin,saldoahorroviviendaini,saldoahorroviviendamovto,saldoahorroviviendafin,saldoahorrofin,imsssaldoinicialcvcs,imsssaldoaportecvcs,imsssaldoretirocvcs,imsssaldorendimientocvcs,imsssaldocomisioncvcs,imsssaldofinalcvcs,issstesaldoinicialrcv,issstesaldoaportercv,issstesaldoretirorcv,issstesaldorendimientorcv,issstesaldocomisionrcv,issstesaldofinalrcv,saldoahorrofovissste,saldoahorrofovissstemovto,saldoahorrofovissstefin,saldototalahorroissste,saldototal,saldoinicial,bonopensionactualudi,bonopensionnominal,bonopensionactpesos,bonopensionnompesos,consecutivotrabajador,estado)VALUES
            ('2019-05-01',dFechaIni,fechafin,cNss,cCurp,SUBSTR(cCurp,1,10)||'6H2',20,'2','2',cNombre,'DEL DESIERTO 2534                                             ','STANZA MAGNOLIA                                             ','80100','80001','SINALOA                                 ','CULIACAN                                ',cCurp||'26',140438.05,177643.43,-164206.05,15882.14,-1592.71,168164.86,0,0,0,0,0,0,123304.42,19604.7,142909.12,311073.98,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,311073.98,298780.4,0,0,0,0,212818,25);

            INSERT INTO tbestadocuentaafore_saldofinal
            (fechaini,fechafin,nss,curp,estado,saldoimss97,saldoissste08,saldocesentiavejez,saldocuotasocial,saldoinfonavit97,saldofovissste08,saldovoluntarias,saldocomplementarias,saldolargoplazo,saldosolidario,saldosarimss92,saldoinfonavit92,saldoissste92,saldofovissste92)VALUES
            (dFechaIni,fechafin,cNss,cCurp,101,60873.43,0,134180.37,23881.66,173268.98,0,0,0,0,0,0,0,0,0);


        END LOOP;

        RETURN 1;

    END;

$$

LANGUAGE plpgsql VOLATILE SECURITY DEFINER
CALLED ON NULL INPUT;
COMMENT ON FUNCTION fn_ambientarestadocuenta(DATE, DATE, CHARACTER, CHARACTER, CHARACTER ) IS 'funcion para ambientar el estado de cuenta';
ALTER FUNCTION fn_ambientarestadocuenta(DATE, DATE, CHARACTER, CHARACTER, CHARACTER)
OWNER TO sysadmonafore;
