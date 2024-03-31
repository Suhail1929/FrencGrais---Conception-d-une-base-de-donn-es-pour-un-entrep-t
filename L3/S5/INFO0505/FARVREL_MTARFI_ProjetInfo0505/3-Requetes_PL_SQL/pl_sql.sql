/**
 * requets PL/SQL
 * 
 * @author FAVREL Corentin & MTARFI Souhail
 */
-- procedure pl/sql qui utilise un cursor calcule le pourcentage de produits qui ont un controle OK par rapport au nombre total de produits
CREATE OR REPLACE PROCEDURE pourcentageProduitOK
IS
    CURSOR c1 IS
        SELECT count(*)
        FROM Controle
        WHERE resultat='OK';
    nbProduitOK NUMBER;
    nbProduit NUMBER;
BEGIN
    SELECT COUNT(*) INTO nbProduit FROM Controle;
    OPEN c1;
    LOOP
        FETCH c1 INTO nbProduitOK;
        EXIT WHEN c1%NOTFOUND;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('le pourcentage de produits qui ont un controle OK est : '||nbProduitOK/nbProduit*100||'%');
END pourcentageProduitOK;

call pourcentageProduitOK

--un cursor qui parcours les produits qui ont un controle KO et qui affiche  le nom du technicien qui a fait l'inventaire 
DECLARE
    CURSOR c1 IS
        SELECT nomTechnicien,prenomTechnicien
        FROM TechnicienStockage
        WHERE IdTechnicien IN (SELECT IdTechnicien
                               FROM FicheInventaire
                                     WHERE IdLot IN (SELECT IdLot
                                                    FROM Controle
                                                    WHERE resultat='KO'));
    nomTechnicien_c VARCHAR2(20);
    prenomTechnicien_c VARCHAR2(20);
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO nomTechnicien_c,prenomTechnicien_c;
        EXIT WHEN c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('le nom du technicien qui a fait l''inventaire est : '||nomTechnicien_c||' '||prenomTechnicien_c);
    END LOOP;
END ;
--un trigger qui verifie que la date retrait n'est pas null sinon il met une valeur par defaut et ne peut pas être antérieure à la date d'entrée
CREATE OR REPLACE TRIGGER dateRetrait
BEFORE INSERT ON DossierLot
FOR EACH ROW
BEGIN
    IF :new.dateRetrait < :new.dateEntree THEN
        DBMS_OUTPUT.PUT_LINE('la date retrait ne peut pas être antérieure à la date d''entrée on a mis 31/12/2100 par defaut');
        :new.dateRetrait:=to_date('31/12/2100','dd/mm/yyyy');
    END IF;
END dateRetrait;

insert into DossierLot values(9,4,to_date('01/01/2019','dd/mm/yyyy'),to_date('01/01/2018','dd/mm/yyyy'),10);
--une fonction qui prend en paramètre une température et qui retourne la température en degré Fahrenheit
CREATE OR REPLACE FUNCTION tempFahrenheit(temp NUMBER)
RETURN NUMBER
IS
    tempF NUMBER;
BEGIN
    tempF:=temp*1.8+32;
    RETURN tempF;
END tempFahrenheit;

DECLARE 
    temp NUMBER;
BEGIN
    temp:=tempFahrenheit(10);
    DBMS_OUTPUT.PUT_LINE('la température en degré Fahrenheit est : '||temp);
END;

-- une Procedure permettant pour chaque produit, la temperature de stockage maximal .
CREATE OR REPLACE Procedure tempMaxProduit
IS
    CURSOR c1 IS
        SELECT temperatureMax
        FROM ConditionStockage
        WHERE IdConditionStockage IN (SELECT IdConditionStockage
                                     FROM LotProduit
                                     WHERE IdProduit IN (SELECT IdProduit
                                                         FROM FicheDescriptive));
    temp NUMBER;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO temp;
        EXIT WHEN c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('la temperature de stockage maximal des produits est : '||temp);
    END LOOP;
END tempMaxProduit;

call tempMaxProduit