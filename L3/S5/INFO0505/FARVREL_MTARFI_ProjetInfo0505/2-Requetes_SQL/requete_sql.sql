/**
 * requets SQL
 * 
 * @author FAVREL Corentin & MTARFI Souhail
 */
--le dossier de lot des produits d'origine française et y'a pas la presences de OGM et des colorants et le nom de technicien qui a fait l'inventaire est John Doe
SELECT * 
FROM DossierLot
WHERE IdLot IN (SELECT IdLot FROM Controle WHERE origine='France' AND OGM=0 AND colorants=0) 
AND IdLot IN (SELECT IdLot FROM FicheInventaire WHERE IdTechnicien IN (SELECT IdTechnicien FROM TechnicienStockage WHERE nomTechnicien='Doe' AND prenomTechnicien='John'));



-- la fiches descriptives des produits dont la température Max de stockage est supérieure à 10°C et la durée de conservation est inférieure à 200 jours par ordre décroissant de la date limite de consommation
SELECT *
FROM FicheDescriptive
WHERE IdProduit IN (SELECT IdProduit 
                    FROM LotProduit
                    where IdConditionStockage IN (
                        SELECT IdConditionStockage 
                            FROM ConditionStockage 
                                WHERE temperatureMax >10 AND dureeConservation<200));


-- la liste des produit dont la durée de conservation est supérieure à la durée de conservation moyenne des produits et la températureMin de stockage est inférieure à la températureMin de stockage moyenne des produits
SELECT *
FROM FicheDescriptive
WHERE IDProduit 
IN (SELECT IdProduit 
        FROM LotProduit 
            WHERE IdConditionStockage IN (
                    SELECT IdConditionStockage 
                            FROM ConditionStockage 
                                    WHERE dureeConservation > (SELECT AVG(dureeConservation) FROM ConditionStockage) 
                                            AND temperatureMin < (SELECT AVG(temperatureMin) FROM ConditionStockage)));
--le nom de technicien qui a fait l'inventaire d'un produit qui est un OGM et qui contient des colorants
SELECT nomTechnicien,prenomTechnicien
FROM TechnicienStockage
WHERE IdTechnicien IN (SELECT IdTechnicien
                       FROM FicheInventaire
                             WHERE IdLot IN (SELECT IdLot
                                        FROM Controle
                                             WHERE OGM=1 AND colorants=1));

-- la fiche descreptives des produits qui les reste plus de 50 jours avant la date limite de consommation par rapport à la date actuelle et qui ont un contrôle OK
SELECT *
FROM FicheDescriptive
WHERE IDProduit IN (SELECT IdProduit
                    FROM LotProduit
                    WHERE IdLot IN (SELECT IdLot
                                    FROM Controle
                                    WHERE dateLimiteConsommation > SYSDATE+50 AND resultat='OK'));
                   
--le nom Technicien de stockage que leur nom commence par 'T' et qui a fait l'inventaire d'un produit qui est un OGM et qui contient des colorants
SELECT nomTechnicien,prenomTechnicien
FROM TechnicienStockage
WHERE IdTechnicien IN (SELECT IdTechnicien
                       FROM FicheInventaire
                             WHERE IdLot IN (SELECT IdLot
                                        FROM Controle
                                             WHERE OGM=1 AND colorants=1))
AND nomTechnicien LIKE 'T%';
