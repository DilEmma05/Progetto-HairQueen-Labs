DROP DATABASE IF EXISTS HairQueen_Labs;
CREATE DATABASE IF NOT EXISTS HairQueen_Labs;
USE HairQueen_Labs;

-- Tabella Utenti (serve sia per i clienti che per l'admin)
CREATE TABLE Utente (
    id_utente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    indirizzo VARCHAR(255),
    ruolo ENUM('CLIENTE', 'ADMIN') DEFAULT 'CLIENTE'
);

-- Tabella Categorie
CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL
);

-- Tabella Prodotti
CREATE TABLE Prodotto (
    id_prodotto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    descrizione TEXT,
    prezzo DECIMAL(10, 2) NOT NULL,
    quantita_magazzino INT NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- Tabella Ordini
CREATE TABLE Ordine (
    id_ordine INT AUTO_INCREMENT PRIMARY KEY,
    data_ordine DATETIME DEFAULT CURRENT_TIMESTAMP,
    totale DECIMAL(10, 2) NOT NULL,
    stato VARCHAR(50) DEFAULT 'In elaborazione',
    id_utente INT,
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente)
);

-- Tabella Dettaglio_Ordine (collega l'ordine ai singoli prodotti acquistati)
CREATE TABLE Dettaglio_Ordine (
    id_ordine INT,
    id_prodotto INT,
    quantita_acquistata INT NOT NULL,
    prezzo_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_ordine, id_prodotto),
    FOREIGN KEY (id_ordine) REFERENCES Ordine(id_ordine),
    FOREIGN KEY (id_prodotto) REFERENCES Prodotto(id_prodotto)
);