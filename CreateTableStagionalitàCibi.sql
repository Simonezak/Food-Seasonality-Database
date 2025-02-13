CREATE DATABASE StagionalitàCibi;
USE StagionalitàCibi ;


CREATE TABLE ProdottoTerra (
  id_prodottoterra VARCHAR(7) NOT NULL,
  nomecomune_prodottoterra VARCHAR(50) NOT NULL,
  nomescientifico_prodottoterra VARCHAR(50) NOT NULL,
  kcal_100g INT NOT NULL,
  tipo VARCHAR(10) NOT NULL,
  PRIMARY KEY (id_prodottoterra)
  );


CREATE TABLE Mese (
  nome_mese VARCHAR(20) NOT NULL,
  stagione_mese VARCHAR(20) NOT NULL,
  PRIMARY KEY (nome_mese)
  );



CREATE TABLE Stagionalità (
  nome_mese VARCHAR(20) NOT NULL,
  id_prodottoterra VARCHAR(7) NOT NULL,
  PRIMARY KEY (nome_mese, id_prodottoterra),
  FOREIGN KEY (id_prodottoterra) REFERENCES ProdottoTerra(id_prodottoterra) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (nome_mese) REFERENCES Mese(nome_mese) ON DELETE NO ACTION ON UPDATE CASCADE
  );


CREATE TABLE Consorzio (
  partitaIVA INT NOT NULL,
  nome_consorzio VARCHAR(100) NOT NULL,
  sede_legale VARCHAR(50) NOT NULL,
  anno_fondazione YEAR NOT NULL,
  telefono VARCHAR(13),
  PRIMARY KEY (partitaIVA)
  );


CREATE TABLE Terreno (
  id_terreno VARCHAR(10) NOT NULL,
  indirizzo VARCHAR(100) NOT NULL,
  mq_terreno INT NOT NULL,
  anno_acquistoterreno YEAR NOT NULL,
  numero_dipendenti INT,
  partitaIVA INT NOT NULL,
  PRIMARY KEY (id_terreno),
  FOREIGN KEY (partitaIVA) REFERENCES Consorzio(partitaIVA) ON DELETE NO ACTION ON UPDATE CASCADE
  );


CREATE TABLE Coltivazione (
  id_terreno VARCHAR(10) NOT NULL,
  id_prodottoterra VARCHAR(7) NOT NULL,
  PRIMARY KEY (id_terreno, id_prodottoterra),
  FOREIGN KEY (id_prodottoterra) REFERENCES ProdottoTerra(id_prodottoterra) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (id_terreno) REFERENCES Terreno (id_terreno) ON DELETE NO ACTION ON UPDATE CASCADE
  );


CREATE TABLE Vitamina (
  nome_comunevitamina VARCHAR(10) NOT NULL,
  nome_chimicovitamina VARCHAR(50) NOT NULL,
  tipo VARCHAR(30) NOT NULL,
  PRIMARY KEY (nome_comunevitamina)
  );


CREATE TABLE ContieneV (
  id_prodottoterra VARCHAR(7) NOT NULL,
  nome_comunevitamina VARCHAR(10) NOT NULL,
  quantitàper100g FLOAT NOT NULL,
  PRIMARY KEY (id_prodottoterra, nome_comunevitamina),
  FOREIGN KEY (id_prodottoterra) REFERENCES ProdottoTerra (id_prodottoterra) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (nome_comunevitamina) REFERENCES Vitamina (nome_comunevitamina) ON DELETE NO ACTION ON UPDATE CASCADE
  );


CREATE TABLE SaleMinerale (
  simbolo_elementochimico VARCHAR(2) NOT NULL,
  nome_elementochimico VARCHAR(50) NOT NULL,
  tipo VARCHAR(30) NOT NULL,
  PRIMARY KEY (simbolo_elementochimico)
  );


CREATE TABLE ContieneSM (
  id_prodottoterra VARCHAR(7) NOT NULL,
  simbolo_elementochimico VARCHAR(2) NOT NULL,
  quantitàper100g FLOAT NOT NULL,
  PRIMARY KEY (id_prodottoterra, simbolo_elementochimico),
  FOREIGN KEY (id_prodottoterra) REFERENCES ProdottoTerra(id_prodottoterra) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (simbolo_elementochimico) REFERENCES SaleMinerale(simbolo_elementochimico) ON DELETE NO ACTION ON UPDATE CASCADE
  );


CREATE TABLE Funzione (
  id_funzione VARCHAR(7) NOT NULL,
  nome_funzione VARCHAR(50) NOT NULL,
  descrizione MEDIUMTEXT,
  PRIMARY KEY (id_funzione)
  );


CREATE TABLE SMSvolge (
  simbolo_elementochimico VARCHAR(2) NOT NULL,
  id_funzione VARCHAR(7) NOT NULL,
  PRIMARY KEY (simbolo_elementochimico, id_funzione),
  FOREIGN KEY (simbolo_elementochimico) REFERENCES SaleMinerale(simbolo_elementochimico) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (id_funzione) REFERENCES Funzione(id_funzione) ON DELETE NO ACTION ON UPDATE CASCADE
  );


CREATE TABLE Dieta (
  id_dieta VARCHAR(10) NOT NULL,
  nome_dieta VARCHAR(50) NOT NULL,
  durataraccomandata_ingiorni VARCHAR(20) NOT NULL,
  descrizione MEDIUMTEXT NULL,
  PRIMARY KEY (id_dieta)
  );


CREATE TABLE Persona (
  CF CHAR(16) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  cognome VARCHAR(50) NOT NULL,
  data_nascita DATE NOT NULL,
  indirizzo VARCHAR(100) NOT NULL,
  telefono VARCHAR(13) NOT NULL,
  email VARCHAR(50) NULL,
  PRIMARY KEY (CF)
  );


CREATE TABLE EffettuataDa (
  CF CHAR(16) NOT NULL,
  id_dieta VARCHAR(10) NOT NULL,
  inizio_dieta DATE NOT NULL,
  fine_dieta DATE,
  PRIMARY KEY (CF,id_dieta,inizio_dieta),
  FOREIGN KEY (CF) REFERENCES Persona(CF) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (id_dieta) REFERENCES Dieta(id_dieta) ON DELETE NO ACTION ON UPDATE CASCADE
  );


CREATE TABLE VUsataIn (
  id_dieta VARCHAR(10) NOT NULL,
  nome_comunevitamina VARCHAR(10) NOT NULL,
  quantitàgiornaliera_ingrammi FLOAT NOT NULL,
  PRIMARY KEY (id_dieta, nome_comunevitamina),
  FOREIGN KEY (id_dieta) REFERENCES Dieta(id_dieta) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (nome_comunevitamina) REFERENCES Vitamina(nome_comunevitamina) ON DELETE NO ACTION ON UPDATE CASCADE
  );


CREATE TABLE VSvolge (
  nome_comunevitamina VARCHAR(10) NOT NULL,
  id_funzione VARCHAR(7) NOT NULL,
  PRIMARY KEY (nome_comunevitamina, id_funzione),
  FOREIGN KEY (nome_comunevitamina) REFERENCES Vitamina(nome_comunevitamina) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (id_funzione) REFERENCES Funzione(id_funzione) ON DELETE NO ACTION ON UPDATE CASCADE
  );


CREATE TABLE SMUsatoIn (
  id_dieta VARCHAR(10) NOT NULL,
  simbolo_elementochimico VARCHAR(7) NOT NULL,
  quantitàgiornaliera_ingrammi FLOAT NOT NULL,
  PRIMARY KEY (id_dieta, simbolo_elementochimico),
  FOREIGN KEY (id_dieta) REFERENCES Dieta(id_dieta) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (simbolo_elementochimico) REFERENCES SaleMinerale (simbolo_elementochimico) ON DELETE NO ACTION ON UPDATE CASCADE
  );
  
  