--DROP FUNCTION fn_aggTrabajadorSafre(CHAR(18));
CREATE FUNCTION fn_aggTrabajadorSafre( fcCurp CHAR(18))
RETURNING CHAR(18) AS curp, CHAR(11) AS nss, BIGINT AS nfolio, DATE AS fechanacimiento, CHAR(60) AS paterno, CHAR(60) AS materno, CHAR(80) AS nombres, INTEGER AS genero ;
    DEFINE cCurp CHAR(18);
    DEFINE cNss CHAR(11);
    DEFINE dNfolio DECIMAL;
    DEFINE fFechaNac DATE;
    DEFINE cPaterno CHAR(60);
    DEFINE cMaterno CHAR(60);
    DEFINE cNombres CHAR(80);
    DEFINE sEstado INTEGER;
    DEFINE iTrabajador SMALLINT;
    DEFINE iSexo INTEGER;
    DEFINE cRespuestaQuery CHAR(200);
    --banderas
    DEFINE banderaAfiDomicilio SMALLINT;
    DEFINE banderaAfiTelefono SMALLINT;
    DEFINE banderaAfiCorreo SMALLINT;
    DEFINE banderaAfiActividad SMALLINT;
    DEFINE banderaAfiNivelEstu SMALLINT;
    DEFINE banderaCuotaDiaria SMALLINT;

    
    LET iTrabajador = 0;
    LET banderaAfiDomicilio = 0;
    LET banderaAfiTelefono = 0;
    LET banderaAfiCorreo = 0;
    LET banderaAfiActividad = 0;
    LET banderaAfiNivelEstu = 0;
    LET banderaCuotaDiaria = 0;
    LET cRespuestaQuery = '';


    IF EXISTS ( SELECT 'OK' FROM afi_mae_afiliado WHERE n_unico = fcCurp ) THEN 
        
        SELECT COUNT(n_unico) INTO iTrabajador FROM afi_mae_afiliado WHERE n_unico = fcCurp ;

        IF ( iTrabajador > 1 ) THEN
            LET cCurp = '2';
            LET cNss= '0';
            LET dNfolio = 0;
            LET fFechaNac = '';
            LET cPaterno = '';
            LET cMaterno= '';
            LET cNombres = '';
            LET iSexo = 0;
        ELSE
        --inicia con las validaciones en tablas 
            SELECT n_unico, n_seguro, n_folio, fena, paterno, materno, nombres, sexo, estadon 
                INTO cCurp, cNss, dNfolio, fFechaNac, cPaterno, cMaterno, cNombres, iSexo, sEstado
            FROM afi_mae_afiliado WHERE n_unico = fcCurp;

            --afi_domicilio
            IF NOT EXISTS ( SELECT 'OK' FROM afi_domicilio WHERE n_folio= dNfolio AND nss = cNss ) THEN
                IF NOT EXISTS ( SELECT 'OK' FROM afi_domicilio WHERE nss = cNss OR n_folio = dNfolio ) THEN
                    INSERT INTO afi_domicilio 
                    (nss          ,n_folio ,tipo_solicitud,calle                                                         ,calle_ref1,calle_ref2,numero      ,depto       ,colonia                                                       ,delega,ciudad,estado      ,codpos     ,dom_cod,pais_cod,marca_envio,usuario,factualiza      ) VALUES
                    (cNss         ,dNfolio,1              ,'CDA FCO ACUNA DE FIGUEROA                                   ',null      ,null      ,'MZA 18 A  ','LT 13     ','ZAPOTITLA                                                   ',9013  ,901   ,sEstado     ,'80029'    ,2      ,'MEX'   ,'X'        ,null   ,'08-05-2021')
                    ;
                    LET banderaAfiDomicilio = 1;
                ELSE
                    IF NOT EXISTS ( SELECT 'OK' FROM afi_domicilio WHERE n_folio = dNfolio ) THEN
                        IF NOT EXISTS ( SELECT 'OK' FROM afi_domicilio WHERE nss = cNss ) THEN
                            INSERT INTO afi_domicilio 
                            (nss          ,n_folio ,tipo_solicitud,calle                                                         ,calle_ref1,calle_ref2,numero      ,depto       ,colonia                                                       ,delega,ciudad,estado      ,codpos     ,dom_cod,pais_cod,marca_envio,usuario,factualiza      ) VALUES
                            (cNss         ,dNfolio,1              ,'CDA FCO ACUNA DE FIGUEROA                                   ',null      ,null      ,'MZA 18 A  ','LT 13     ','ZAPOTITLA                                                   ',9013  ,901   ,sEstado     ,'80029'    ,2      ,'MEX'   ,'X'        ,null   ,'08-05-2021')
                            ;
                            LET banderaAfiDomicilio = 1;
                        ELSE
                            SELECT COUNT(nss) INTO iTrabajador FROM afi_domicilio WHERE nss = cNss ;
                            IF ( iTrabajador > 1 ) THEN
                                DELETE FROM afi_domicilio WHERE nss = cNss;
                                INSERT INTO afi_domicilio 
                                (nss          ,n_folio ,tipo_solicitud,calle                                                         ,calle_ref1,calle_ref2,numero      ,depto       ,colonia                                                       ,delega,ciudad,estado      ,codpos     ,dom_cod,pais_cod,marca_envio,usuario,factualiza      ) VALUES
                                (cNss         ,dNfolio,1              ,'CDA FCO ACUNA DE FIGUEROA                                   ',null      ,null      ,'MZA 18 A  ','LT 13     ','ZAPOTITLA                                                   ',9013  ,901   ,sEstado     ,'80029'    ,2      ,'MEX'   ,'X'        ,null   ,'08-05-2021')
                                ;
                                LET banderaAfiDomicilio = 1;
                            ELSE 
                                UPDATE afi_domicilio SET n_folio = dNfolio, estado = sEstado WHERE nss = cNss ;      
                                LET banderaAfiDomicilio = 1;
                            END IF;
                        END IF;
                    ELSE
                        SELECT COUNT(n_folio) INTO iTrabajador FROM afi_domicilio WHERE n_folio = dNfolio ;
                        IF ( iTrabajador > 1 ) THEN
                            DELETE FROM afi_domicilio WHERE n_folio = dNfolio;
                            INSERT INTO afi_domicilio 
                            (nss          ,n_folio ,tipo_solicitud,calle                                                         ,calle_ref1,calle_ref2,numero      ,depto       ,colonia                                                       ,delega,ciudad,estado      ,codpos     ,dom_cod,pais_cod,marca_envio,usuario,factualiza      ) VALUES
                            (cNss         ,dNfolio,1              ,'CDA FCO ACUNA DE FIGUEROA                                   ',null      ,null      ,'MZA 18 A  ','LT 13     ','ZAPOTITLA                                                   ',9013  ,901   ,sEstado     ,'80029'    ,2      ,'MEX'   ,'X'        ,null   ,'08-05-2021')
                            ;
                            LET banderaAfiDomicilio = 1;
                        ELSE 
                            UPDATE afi_domicilio SET nss = cNss WHERE n_folio = dNfolio ;     
                            LET banderaAfiDomicilio = 1;
                        END IF;

                    END IF;
                    
                END IF; 
            ELSE
                IF NOT EXISTS ( SELECT 'OK' FROM afi_domicilio WHERE n_folio= dNfolio AND nss = cNss AND estado = sEstado ) THEN
                    UPDATE afi_domicilio SET estado = sEstado WHERE n_folio = dNfolio ;
                END IF;            
                LET banderaAfiDomicilio = 1;
            END IF;
            --afi_domicilio
            --afi_telefono

            IF NOT EXISTS ( SELECT 'OK' FROM afi_telefono WHERE n_folio= dNfolio AND nss = cNss ) THEN
                IF NOT EXISTS ( SELECT 'OK' FROM afi_telefono WHERE nss = cNss OR n_folio = dNfolio ) THEN
                    INSERT INTO afi_telefono 
                    (nss          ,n_folio ,tipo_solicitud,pais_cod,cve_lada,extension,telefono                                  ,tel_cod,tel_hora_ini,tel_tp_hora_ini,tel_hora_fin,tel_tp_hora_fin,tel_dia,usuario,factualiza      ) VALUES
                    (cNss         ,dNfolio ,1             ,'MEX'   ,'55 '   ,null     ,'14775509                                ',4      ,'00:00'     ,'1'            ,'00:00'     ,'1'            ,'0'    ,null   ,'08-05-2017')
                    ;
                    LET banderaAfiTelefono = 1;
                ELSE
                    IF NOT EXISTS ( SELECT 'OK' FROM afi_telefono WHERE n_folio = dNfolio ) THEN
                        IF NOT EXISTS ( SELECT 'OK' FROM afi_telefono WHERE nss = cNss ) THEN
                            INSERT INTO afi_telefono 
                            (nss          ,n_folio ,tipo_solicitud,pais_cod,cve_lada,extension,telefono                                  ,tel_cod,tel_hora_ini,tel_tp_hora_ini,tel_hora_fin,tel_tp_hora_fin,tel_dia,usuario,factualiza      ) VALUES
                            (cNss         ,dNfolio ,1             ,'MEX'   ,'55 '   ,null     ,'14775509                                ',4      ,'00:00'     ,'1'            ,'00:00'     ,'1'            ,'0'    ,null   ,'05-08-2017')
                            ;
                            LET banderaAfiTelefono = 1;
                        ELSE
                            SELECT COUNT(nss) INTO iTrabajador FROM afi_telefono WHERE nss = cNss ;
                            IF ( iTrabajador > 1 ) THEN
                                DELETE FROM afi_telefono WHERE nss = cNss;
                                INSERT INTO afi_telefono 
                                (nss          ,n_folio ,tipo_solicitud,pais_cod,cve_lada,extension,telefono                                  ,tel_cod,tel_hora_ini,tel_tp_hora_ini,tel_hora_fin,tel_tp_hora_fin,tel_dia,usuario,factualiza      ) VALUES
                                (cNss         ,dNfolio ,1             ,'MEX'   ,'55 '   ,null     ,'14775509                                ',4      ,'00:00'     ,'1'            ,'00:00'     ,'1'            ,'0'    ,null   ,'05-08-2017')
                                ;
                                LET banderaAfiTelefono = 1;
                            ELSE 
                                UPDATE afi_telefono SET n_folio = dNfolio WHERE nss = cNss ;      
                                LET banderaAfiTelefono = 1;              
                            END IF;
                        END IF;
                    ELSE
                        SELECT COUNT(n_folio) INTO iTrabajador FROM afi_telefono WHERE n_folio = dNfolio ;
                        IF ( iTrabajador > 1 ) THEN
                            DELETE FROM afi_telefono WHERE n_folio = dNfolio;
                            INSERT INTO afi_telefono 
                            (nss          ,n_folio ,tipo_solicitud,pais_cod,cve_lada,extension,telefono                                  ,tel_cod,tel_hora_ini,tel_tp_hora_ini,tel_hora_fin,tel_tp_hora_fin,tel_dia,usuario,factualiza      ) VALUES
                            (cNss         ,dNfolio ,1             ,'MEX'   ,'55 '   ,null     ,'14775509                                ',4      ,'00:00'     ,'1'            ,'00:00'     ,'1'            ,'0'    ,null   ,'05-08-2017')
                            ;
                            LET banderaAfiTelefono = 1;
                        ELSE 
                            UPDATE afi_telefono SET nss = cNss WHERE n_folio = dNfolio ;     
                            LET banderaAfiTelefono = 1;               
                        END IF;

                    END IF;
                    
                END IF; 
            ELSE            
                LET banderaAfiTelefono = 1;
            END IF;
            --afi_telefono

            --afi_correo_elect

            IF NOT EXISTS ( SELECT 'OK' FROM afi_correo_elect WHERE n_folio= dNfolio AND nss = cNss ) THEN
                IF NOT EXISTS ( SELECT 'OK' FROM afi_correo_elect WHERE nss = cNss OR n_folio = dNfolio ) THEN
                    INSERT INTO afi_correo_elect 
                    (nss          ,n_folio ,tipo_solicitud,cod_correo_e,correo_elect                                                                                          ,marca_envio,folio,factualiza      ,usuario   ) VALUES
                    (cNss         ,dNfolio ,1             ,1           ,'jose.soto@aforecoppel.com                                                                           ','X'        ,null ,'05-08-2021','APP     ')
                    ;
                    LET banderaAfiCorreo = 1;
                ELSE
                    IF NOT EXISTS ( SELECT 'OK' FROM afi_correo_elect WHERE n_folio = dNfolio ) THEN
                        IF NOT EXISTS ( SELECT 'OK' FROM afi_correo_elect WHERE nss = cNss ) THEN
                            INSERT INTO afi_correo_elect 
                            (nss          ,n_folio ,tipo_solicitud,cod_correo_e,correo_elect                                                                                          ,marca_envio,folio,factualiza      ,usuario   ) VALUES
                            (cNss         ,dNfolio ,1             ,1           ,'jose.soto@aforecoppel.com                                                                           ','X'        ,null ,'05-08-2021','APP     ')
                            ;
                            LET banderaAfiCorreo = 1;
                        ELSE
                            SELECT COUNT(nss) INTO iTrabajador FROM afi_correo_elect WHERE nss = cNss ;
                            IF ( iTrabajador > 1 ) THEN
                                DELETE FROM afi_correo_elect WHERE nss = cNss;
                                INSERT INTO afi_correo_elect 
                                (nss          ,n_folio ,tipo_solicitud,cod_correo_e,correo_elect                                                                                          ,marca_envio,folio,factualiza      ,usuario   ) VALUES
                                (cNss         ,dNfolio ,1             ,1           ,'jose.soto@aforecoppel.com                                                                           ','X'        ,null ,'05-08-2021','APP     ')
                                ;
                                LET banderaAfiCorreo = 1;
                            ELSE 
                                UPDATE afi_correo_elect SET n_folio = dNfolio WHERE nss = cNss ;      
                                LET banderaAfiCorreo = 1;              
                            END IF;
                        END IF;
                    ELSE
                        SELECT COUNT(n_folio) INTO iTrabajador FROM afi_correo_elect WHERE n_folio = dNfolio ;
                        IF ( iTrabajador > 1 ) THEN
                            DELETE FROM afi_correo_elect WHERE n_folio = dNfolio;
                            INSERT INTO afi_correo_elect 
                            (nss          ,n_folio ,tipo_solicitud,cod_correo_e,correo_elect                                                                                          ,marca_envio,folio,factualiza      ,usuario   ) VALUES
                            (cNss         ,dNfolio ,1             ,1           ,'jose.soto@aforecoppel.com                                                                           ','X'        ,null ,'05-08-2021','APP     ')
                            ;
                            LET banderaAfiCorreo = 1;
                        ELSE 
                            UPDATE afi_correo_elect SET nss = cNss WHERE n_folio = dNfolio ;     
                            LET banderaAfiCorreo = 1;               
                        END IF;

                    END IF;
                    
                END IF; 
            ELSE            
                LET banderaAfiCorreo = 1;
            END IF;
            --afi_correo_elect

            --afi_ctr_actividad

            IF NOT EXISTS ( SELECT 'OK' FROM afi_ctr_actividad WHERE n_folio= dNfolio AND nss = cNss ) THEN
                IF NOT EXISTS ( SELECT 'OK' FROM afi_ctr_actividad WHERE nss = cNss OR n_folio = dNfolio ) THEN
                    INSERT INTO afi_ctr_actividad 
                    (nss          ,n_folio ,tipo_solicitud,profesion_cod,actividad_cod,usuario,factualiza      ) VALUES
                    (cNss         ,dNfolio ,1             ,19           ,9            ,null   ,'05-08-2017')
                    ;
                    LET banderaAfiActividad = 1;
                ELSE
                    IF NOT EXISTS ( SELECT 'OK' FROM afi_ctr_actividad WHERE n_folio = dNfolio ) THEN
                        IF NOT EXISTS ( SELECT 'OK' FROM afi_ctr_actividad WHERE nss = cNss ) THEN
                            INSERT INTO afi_ctr_actividad 
                            (nss          ,n_folio ,tipo_solicitud,profesion_cod,actividad_cod,usuario,factualiza      ) VALUES
                            (cNss         ,dNfolio ,1             ,19           ,9            ,null   ,'05-08-2017')
                            ;
                            LET banderaAfiActividad = 1;
                        ELSE
                            SELECT COUNT(nss) INTO iTrabajador FROM afi_ctr_actividad WHERE nss = cNss ;
                            IF ( iTrabajador > 1 ) THEN
                                DELETE FROM afi_ctr_actividad WHERE nss = cNss;
                                INSERT INTO afi_ctr_actividad 
                                (nss          ,n_folio ,tipo_solicitud,profesion_cod,actividad_cod,usuario,factualiza      ) VALUES
                                (cNss         ,dNfolio ,1             ,19           ,9            ,null   ,'05-08-2017')
                                ;
                                LET banderaAfiActividad = 1;
                            ELSE 
                                UPDATE afi_ctr_actividad SET n_folio = dNfolio WHERE nss = cNss ;      
                                LET banderaAfiActividad = 1;              
                            END IF;
                        END IF;
                    ELSE
                        SELECT COUNT(n_folio) INTO iTrabajador FROM afi_ctr_actividad WHERE n_folio = dNfolio ;
                        IF ( iTrabajador > 1 ) THEN
                            DELETE FROM afi_ctr_actividad WHERE n_folio = dNfolio;
                            INSERT INTO afi_ctr_actividad 
                            (nss          ,n_folio ,tipo_solicitud,profesion_cod,actividad_cod,usuario,factualiza      ) VALUES
                            (cNss         ,dNfolio ,1             ,19           ,9            ,null   ,'05-08-2017')
                            ;
                            LET banderaAfiActividad = 1;
                        ELSE 
                            UPDATE afi_ctr_actividad SET nss = cNss WHERE n_folio = dNfolio ;     
                            LET banderaAfiActividad = 1;               
                        END IF;

                    END IF;
                    
                END IF; 
            ELSE            
                LET banderaAfiActividad = 1;
            END IF;
            --afi_ctr_actividad
            --afi_nivel_estudios

            IF NOT EXISTS ( SELECT 'OK' FROM afi_nivel_estudios WHERE n_folio= dNfolio AND nss = cNss ) THEN
                IF NOT EXISTS ( SELECT 'OK' FROM afi_nivel_estudios WHERE nss = cNss OR n_folio = dNfolio ) THEN
                    INSERT INTO afi_nivel_estudios 
                    (nss          ,n_folio ,tipo_solicitud,nivel_cod,usuario   ,factualiza      ) VALUES
                    (cNss         ,dNfolio ,1             ,1        ,'safre   ','05-18-2018')
                    ;
                    LET banderaAfiNivelEstu = 1;
                ELSE
                    IF NOT EXISTS ( SELECT 'OK' FROM afi_nivel_estudios WHERE n_folio = dNfolio ) THEN
                        IF NOT EXISTS ( SELECT 'OK' FROM afi_nivel_estudios WHERE nss = cNss ) THEN
                            INSERT INTO afi_nivel_estudios 
                            (nss          ,n_folio ,tipo_solicitud,nivel_cod,usuario   ,factualiza      ) VALUES
                            (cNss         ,dNfolio ,1             ,1        ,'safre   ','05-18-2018')
                            ;
                            LET banderaAfiNivelEstu = 1;
                        ELSE
                            SELECT COUNT(nss) INTO iTrabajador FROM afi_nivel_estudios WHERE nss = cNss ;
                            IF ( iTrabajador > 1 ) THEN
                                DELETE FROM afi_nivel_estudios WHERE nss = cNss;
                                INSERT INTO afi_nivel_estudios 
                                (nss          ,n_folio ,tipo_solicitud,nivel_cod,usuario   ,factualiza      ) VALUES
                                (cNss         ,dNfolio ,1             ,1        ,'safre   ','05-18-2018')
                                ;
                                LET banderaAfiNivelEstu = 1;
                            ELSE 
                                UPDATE afi_nivel_estudios SET n_folio = dNfolio WHERE nss = cNss ;      
                                LET banderaAfiNivelEstu = 1;              
                            END IF;
                        END IF;
                    ELSE
                        SELECT COUNT(n_folio) INTO iTrabajador FROM afi_nivel_estudios WHERE n_folio = dNfolio ;
                        IF ( iTrabajador > 1 ) THEN
                            DELETE FROM afi_nivel_estudios WHERE n_folio = dNfolio;
                            INSERT INTO afi_nivel_estudios 
                            (nss          ,n_folio ,tipo_solicitud,nivel_cod,usuario   ,factualiza      ) VALUES
                            (cNss         ,dNfolio ,1             ,1        ,'safre   ','05-18-2018')
                            ;
                            LET banderaAfiNivelEstu = 1;
                        ELSE 
                            UPDATE afi_nivel_estudios SET nss = cNss WHERE n_folio = dNfolio ;     
                            LET banderaAfiNivelEstu = 1;               
                        END IF;

                    END IF;
                    
                END IF; 
            ELSE            
                LET banderaAfiNivelEstu = 1;
            END IF;
            --afi_nivel_estudios

            --cuota_diaria

            IF NOT EXISTS ( SELECT 'OK' FROM cuota_diaria WHERE n_folio= dNfolio AND n_seguro = cNss ) THEN
                IF NOT EXISTS ( SELECT 'OK' FROM cuota_diaria WHERE n_seguro = cNss OR n_folio = dNfolio ) THEN
                    INSERT INTO cuota_diaria 
                    (tipo_solicitud,n_folio ,n_seguro     ,n_unico             ,n_rfc          	            ,fentcons        ,finicta         ,sexo    ,fena            ,factualiza      ) VALUES
                    (1             ,dNfolio ,cNss         ,cCurp 		       ,SUBSTR(cCurp,1,10)||'6H2'	,'12-23-2008'    ,'02-13-2020'    ,iSexo   ,'01-27-1995'    ,'03-03-2020'    )
                    ;
                    LET banderaCuotaDiaria = 1;
                ELSE
                    IF NOT EXISTS ( SELECT 'OK' FROM cuota_diaria WHERE n_folio = dNfolio ) THEN
                        IF NOT EXISTS ( SELECT 'OK' FROM cuota_diaria WHERE n_seguro = cNss ) THEN
                            INSERT INTO cuota_diaria 
                            (tipo_solicitud,n_folio ,n_seguro     ,n_unico             ,n_rfc          	            ,fentcons        ,finicta         ,sexo    ,fena            ,factualiza      ) VALUES
                            (1             ,dNfolio ,cNss         ,cCurp 		       ,SUBSTR(cCurp,1,10)||'6H2'	,'12-23-2008'    ,'02-13-2020'    ,iSexo   ,'01-27-1995'    ,'03-03-2020'    )
                            ;
                            LET banderaCuotaDiaria = 1;
                        ELSE
                            SELECT COUNT(nss) INTO iTrabajador FROM cuota_diaria WHERE n_seguro = cNss ;
                            IF ( iTrabajador > 1 ) THEN
                                DELETE FROM cuota_diaria WHERE n_seguro = cNss;
                                INSERT INTO cuota_diaria 
                                (tipo_solicitud,n_folio ,n_seguro     ,n_unico             ,n_rfc          	            ,fentcons        ,finicta         ,sexo    ,fena            ,factualiza      ) VALUES
                                (1             ,dNfolio ,cNss         ,cCurp 		       ,SUBSTR(cCurp,1,10)||'6H2'	,'12-23-2008'    ,'02-13-2020'    ,iSexo   ,'01-27-1995'    ,'03-03-2020'    )
                                ;
                                LET banderaCuotaDiaria = 1;
                            ELSE 
                                UPDATE cuota_diaria SET n_folio = dNfolio, tipo_solicitud = 1 WHERE n_seguro = cNss ;      
                                LET banderaCuotaDiaria = 1;              
                            END IF;
                        END IF;
                    ELSE
                        SELECT COUNT(n_folio) INTO iTrabajador FROM cuota_diaria WHERE n_folio = dNfolio ;
                        IF ( iTrabajador > 1 ) THEN
                            DELETE FROM cuota_diaria WHERE n_folio = dNfolio;
                            INSERT INTO cuota_diaria 
                            (tipo_solicitud,n_folio ,n_seguro     ,n_unico             ,n_rfc          	            ,fentcons        ,finicta         ,sexo    ,fena            ,factualiza      ) VALUES
                            (1             ,dNfolio ,cNss         ,cCurp 		       ,SUBSTR(cCurp,1,10)||'6H2'	,'12-23-2008'    ,'02-13-2020'    ,iSexo   ,'01-27-1995'    ,'03-03-2020'    )
                            ;
                            LET banderaCuotaDiaria = 1;
                        ELSE 
                            UPDATE cuota_diaria SET n_seguro = cNss, tipo_solicitud = 1 WHERE n_folio = dNfolio ;     
                            LET banderaCuotaDiaria = 1;               
                        END IF;

                    END IF;
                    
                END IF; 
            ELSE            
                UPDATE cuota_diaria SET tipo_solicitud = 1 WHERE n_folio = dNfolio ;     
                LET banderaCuotaDiaria = 1;
            END IF;
            --cuota_diaria

        END IF;

    ELSE
        LET cCurp = '0';
        LET cNss= '0';
        LET dNfolio = 0;
        LET fFechaNac = '';
        LET cPaterno = '';
        LET cMaterno= '';
        LET cNombres = '';
        LET iSexo = 0;
    END IF;

    RETURN cCurp, cNss, dNfolio::BIGINT, fFechaNac, cPaterno, cMaterno, cNombres, iSexo;

END FUNCTION;