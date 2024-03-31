/**
 * script de creation de la bdd
 * 
 * @author FAVREL Corentin & MTARFI Souhail
 */
CREATE TABLE Produit
(
    Idproduit NUMBER(10) PRIMARY KEY,
    typeProduit VARCHAR2(50) NOT NULL
);
CREATE TABLE FicheDescriptive
(
    IdFicheD NUMBER(10) PRIMARY KEY,
    IdProduit NUMBER(10) NOT NULL,
    poids NUMBER(15,3) NOT NULL,
    volume NUMBER(10) NOT NULL,
    dateLimiteConsommation DATE NOT NULL,
    description_ VARCHAR2(250) NOT NULL
);

Create table LotProduit
(
    IdLot NUMBER(10) PRIMARY KEY,
    IdProduit NUMBER(10) NOT NULL,
    IdConditionStockage NUMBER(10) NOT NULL
);
create table DossierLot
(
    IdDossier NUMBER(10) PRIMARY KEY,
    IdLot NUMBER(10) NOT NULL,
    dateEntree DATE NOT NULL,
    dateRetrait DATE NOT NULL,
    quantite NUMBER(10) NOT NULL
);
Create table ConditionStockage
(
    IdConditionStockage NUMBER(10) PRIMARY KEY,
    dureeConservation NUMBER(10) NOT NULL,
    temperatureMin NUMBER(10)  NOT NULL,
    temperatureMax NUMBER(10) NOT NULL
);

create table FicheInventaire
(
    IdFicheI NUMBER(10) PRIMARY KEY,
    IdLot NUMBER(10) NOT NULL,
    dateInventaire DATE NOT NULL,
    statut VARCHAR2(50) NOT NULL,
    IdTechnicien NUMBER(10) NOT NULL
);
create table CadreAdministratif
(
    IdCadreAdministratif NUMBER(10) PRIMARY KEY,
    IdLot NUMBER(10) NOT NULL,
    IdCondition NUMBER(10) NOT NULL,
    IdProduit NUMBER(10) NOT NULL,
    tempsConservation NUMBER(10) NOT NULL,
    temperatureMax NUMBER(10) NOT NULL,
    temperatureMin NUMBER(10) NOT NULL
);
Create table Controle
(
    IdControle NUMBER(10) PRIMARY KEY,
    IdLot NUMBER(10) NOT NULL,
    origine VARCHAR2(50) NOT NULL,
    OGM NUMBER(1) NOT NULL,
    colorants NUMBER(1) NOT NULL,
    dateVerif DATE NOT NULL,
    resultat VARCHAR2(250) NOT NULL,
    commentaire VARCHAR2(250) NOT NULL
);
create table TechnicienStockage
(
    IdTechnicien NUMBER(10) PRIMARY KEY,
    nomTechnicien VARCHAR2(50) NOT NULL,
    prenomTechnicien VARCHAR2(50) NOT NULL
);
create table definit
(
    IdCadreAdministratif NUMBER(10) NOT NULL,
    IdControle NUMBER(10) NOT NULL
    
);
create table preleve
(
    IdLot NUMBER(10) NOT NULL,
    IdTechnicien NUMBER(10) NOT NULL
   
);


Alter table LotProduit add constraint fk_lotproduit_produit foreign key (IdProduit) references Produit(IdProduit);
alter table LotProduit add constraint fk_lotproduit_conditionstockage foreign key (IdConditionStockage) references ConditionStockage(IdConditionStockage);

Alter table DossierLot add constraint fk_dossierlot_lotproduit foreign key (IdLot) references LotProduit(IdLot);

Alter table FicheInventaire add constraint fk_ficheinventaire_lotproduit foreign key (IdLot) references LotProduit(IdLot);
Alter table FicheInventaire add constraint fk_ficheinventaire_technicienstockage foreign key (IdTechnicien) references TechnicienStockage(IdTechnicien);

Alter table CadreAdministratif add constraint fk_cadreadministratif_lotproduit foreign key (IdLot) references LotProduit(IdLot);
Alter table CadreAdministratif add constraint fk_cadreadministratif_conditionstockage foreign key (IdCondition) references ConditionStockage(IdCondition);
Alter table CadreAdministratif add constraint fk_cadreadministratif_produit foreign key (IdProduit) references Produit(IdProduit);

Alter table Controle add constraint fk_controle_lotproduit foreign key (IdLot) references LotProduit(IdLot);

Alter table definit add constraint fk_definit_cadreadministratif foreign key (IdCadreAdministratif) references CadreAdministratif(IdCadreAdministratif);
Alter table definit add constraint fk_definit_controle foreign key (IdControle) references Controle(IdControle);

Alter table preleve add constraint fk_preleve_lotproduit foreign key (IdLot) references LotProduit(IdLot);
Alter table preleve add constraint fk_preleve_technicienstockage foreign key (IdTechnicien) references TechnicienStockage(IdTechnicien);

--insertion des données
INSERT INTO Produit VALUES (1,'Fruits');
INSERT INTO Produit VALUES (2,'Légumes');
INSERT INTO Produit VALUES (3,'Viandes');
INSERT INTO Produit VALUES (4,'Laitages');

INSERT INTO FicheDescriptive VALUES (1,1,100,120,to_date('21/01/2022','dd/mm/yyyy'),'Orange de marque Belle France');
INSERT INTO FicheDescriptive VALUES (5,1,80,120,to_date('12/02/2022','dd/mm/yyyy'),'pomme de marque Belle France');
INSERT INTO FicheDescriptive VALUES (2,2,80,100,to_date('18/02/2022','dd/mm/yyyy'),'pomme de terre de marque Belle France'); 
INSERT INTO FicheDescriptive VALUES (6,2,80,100,to_date('03/02/2022','dd/mm/yyyy'),'Carotte de marque Belle France'); 
INSERT INTO FicheDescriptive VALUES (3,3,100,120,to_date('30/11/2022','dd/mm/yyyy'),'poulet de marque Belle France');
INSERT INTO FicheDescriptive VALUES (7,3,100,120,to_date('07/11/2022','dd/mm/yyyy'),'veau de marque Belle France');
INSERT INTO FicheDescriptive VALUES (4,4,100,120,to_date('18/01/2024','dd/mm/yyyy'),'Fromage cheddar de marque la vache qui rit');
INSERT INTO FicheDescriptive VALUES (8,4,100,120,to_date('08/04/2023','dd/mm/yyyy'),'Yaourt de marque la vache qui rit');

INSERT INTO ConditionStockage VALUES (1,21,5,15);
INSERT INTO ConditionStockage VALUES (2,90,5,20);
INSERT INTO ConditionStockage VALUES (3,360,-10,5);
INSERT INTO ConditionStockage VALUES (4,250,5,15);
INSERT INTO ConditionStockage VALUES (5,21,5,15);
INSERT INTO ConditionStockage VALUES (6,90,5,20);
INSERT INTO ConditionStockage VALUES (7,360,-10,5);
INSERT INTO ConditionStockage VALUES (8,600,5,15);

INSERT INTO LotProduit VALUES (1,1,1);
INSERT INTO LotProduit VALUES (2,2,2);
INSERT INTO LotProduit VALUES (3,3,3);
INSERT INTO LotProduit VALUES (4,4,4);
INSERT INTO LotProduit VALUES (5,1,5);
INSERT INTO LotProduit VALUES (6,2,6);
INSERT INTO LotProduit VALUES (7,3,7);
INSERT INTO LotProduit VALUES (8,4,8);

--on mis que la date de retrait c'est la date limite de consommation
INSERT INTO DossierLot VALUES (1,1,to_date('01/01/2022','dd/mm/yyyy'),to_date('21/01/2022','dd/mm/yyyy'),120);
INSERT INTO DossierLot VALUES (2,2,to_date('01/12/2021','dd/mm/yyyy'),to_date('18/02/2022','dd/mm/yyyy'),180);
INSERT INTO DossierLot VALUES (3,3,to_date('13/01/2022','dd/mm/yyyy'),to_date('07/11/2022','dd/mm/yyyy'),100);
INSERT INTO DossierLot VALUES (4,4,to_date('06/06/2022','dd/mm/yyyy'),to_date('08/04/2023','dd/mm/yyyy'),100);
INSERT INTO DossierLot VALUES (5,5,to_date('01/01/2022','dd/mm/yyyy'),to_date('12/02/2022','dd/mm/yyyy'),120);
INSERT INTO DossierLot VALUES (6,6,to_date('01/12/2021','dd/mm/yyyy'),to_date('03/02/2022','dd/mm/yyyy'),180);
INSERT INTO DossierLot VALUES (7,7,to_date('13/01/2022','dd/mm/yyyy'),to_date('07/11/2022','dd/mm/yyyy'),100);
INSERT INTO DossierLot VALUES (8,8,to_date('06/06/2022','dd/mm/yyyy'),to_date('08/04/2023','dd/mm/yyyy'),100);

INSERT INTO TechnicienStockage VALUES (1,'Doe','John');
INSERT INTO TechnicienStockage VALUES (2,'Topa','Caline');
INSERT INTO TechnicienStockage VALUES (3,'Dupont','Quentin');

INSERT INTO FicheInventaire VALUES (1,1,to_date('01/01/2022','dd/mm/yyyy'),'OK',1);
INSERT INTO FicheInventaire VALUES (2,2,to_date('01/12/2021','dd/mm/yyyy'),'OK',1);
INSERT INTO FicheInventaire VALUES (3,3,to_date('13/01/2022','dd/mm/yyyy'),'OK',1);
INSERT INTO FicheInventaire VALUES (4,4,to_date('06/06/2022','dd/mm/yyyy'),'OK',2);
INSERT INTO FicheInventaire VALUES (5,5,to_date('01/01/2022','dd/mm/yyyy'),'OK',2);
INSERT INTO FicheInventaire VALUES (6,6,to_date('01/12/2021','dd/mm/yyyy'),'OK',2);
INSERT INTO FicheInventaire VALUES (7,7,to_date('13/01/2022','dd/mm/yyyy'),'OK',3);
INSERT INTO FicheInventaire VALUES (8,8,to_date('06/06/2022','dd/mm/yyyy'),'OK',3);
INSERT INTO FicheInventaire VALUES (9,4,to_date('06/06/2022','dd/mm/yyyy'),'OK',1);

INSERT INTO CadreAdministratif VALUES (1,1,1,1,21,15,5);
INSERT INTO CadreAdministratif VALUES (2,2,2,2,90,20,5);
INSERT INTO CadreAdministratif VALUES (3,3,3,3,360,5,-10);
INSERT INTO CadreAdministratif VALUES (4,4,4,4,250,15,5);
INSERT INTO CadreAdministratif VALUES (5,5,1,1,21,15,5);
INSERT INTO CadreAdministratif VALUES (6,6,2,2,90,20,5);
INSERT INTO CadreAdministratif VALUES (7,7,3,3,360,5,-10);
INSERT INTO CadreAdministratif VALUES (8,8,4,4,600,15,5);

INSERT INTO Controle VALUES (1,1,'Maroc',0,0,to_date('20/01/2022','dd/mm/yyyy'),'OK','les oranges sont de bonne qualité');
INSERT INTO Controle VALUES (2,2,'Italie',0,0,to_date('20/02/2022','dd/mm/yyyy'),'KO','Il y a des légumes abimés ils sont deppassés la date limite');
INSERT INTO Controle VALUES (3,3,'Espagne',1,0,to_date('07/07/2022','dd/mm/yyyy'),'OK','les viandes sont de bonne qualité mais le poulet est OGM');
INSERT INTO Controle VALUES (4,4,'France',0,0,to_date('01/01/2022','dd/mm/yyyy'),'OK','le fromage est de bonne qualité');
INSERT INTO Controle VALUES (5,5,'Ukraine',1,1,to_date('20/01/2022','dd/mm/yyyy'),'OK','les pommes sont de bonne qualité mais elles sont OGM et elles contient des colorants');
INSERT INTO Controle VALUES (6,6,'Italie',0,0,to_date('20/02/2022','dd/mm/yyyy'),'KO','Il y a des légumes abimés ils sont deppassés la date limite');
INSERT INTO Controle VALUES (7,7,'Espagne',1,0,to_date('07/07/2022','dd/mm/yyyy'),'OK','le veau contient l OGM');
INSERT INTO Controle VALUES (8,8,'France',0,1,to_date('01/01/2022','dd/mm/yyyy'),'OK','le yaourt contient des colorants');
INSERT INTO Controle VALUES (9,4,'France',0,0,to_date('25/03/2022','dd/mm/yyyy'),'OK','le fromage est encore bon !!');



INSERT INTO definit VALUES (1,1);
INSERT INTO definit VALUES (2,2);
INSERT INTO definit VALUES (1,3);
INSERT INTO definit VALUES (2,4);
INSERT INTO definit VALUES (1,5);
INSERT INTO definit VALUES (2,6);
INSERT INTO definit VALUES (6,7);
INSERT INTO definit VALUES (8,8);


INSERT INTO preleve VALUES (1,1);
INSERT INTO preleve VALUES (2,2);
INSERT INTO preleve VALUES (3,1);
INSERT INTO preleve VALUES (4,1);
INSERT INTO preleve VALUES (5,2);
INSERT INTO preleve VALUES (6,2);
INSERT INTO preleve VALUES (7,3);
INSERT INTO preleve VALUES (8,3);
--pour visualiser les tables
select * from produit;
select * from lotProduit;
select * from DossierLot;
select * from TechnicienStockage;
select * from FicheInventaire;
select * from CadreAdministratif;
select * from Controle;
select * from definit;
select * from preleve;

--suppression des tables
DROP TABLE produit;
DROP TABLE lot;
DROP TABLE DossierLot;
DROP TABLE TechnicienStockage;
DROP TABLE FicheInventaire;
DROP TABLE CadreAdministratif;
DROP TABLE Controle;
DROP TABLE definit;
DROP TABLE preleve;