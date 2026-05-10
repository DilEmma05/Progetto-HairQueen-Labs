DROP DATABASE IF EXISTS HairQueen_Labs;
CREATE DATABASE HairQueen_Labs;
USE HairQueen_Labs;

-- 1. Tabella Categorie Principali
CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL
);

-- 2. Tabella Sottocategorie
CREATE TABLE Sottocategoria (
    id_sottocategoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_sottocategoria VARCHAR(100) NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria) ON DELETE CASCADE
);

-- 3. Tabella Prodotti
CREATE TABLE Prodotto (
    id_prodotto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descrizione TEXT,
    prezzo DECIMAL(10, 2) NOT NULL,
    quantita_magazzino INT NOT NULL,
    immagine_url VARCHAR(255),
    fase_utilizzo VARCHAR(50), -- Es: Pre-Lavaggio, Lavaggio, Post-Asciugatura, Styling
    id_sottocategoria INT,
    FOREIGN KEY (id_sottocategoria) REFERENCES Sottocategoria(id_sottocategoria) ON DELETE SET NULL
);

-- 4. Tabella Utente
CREATE TABLE Utente (
    id_utente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    indirizzo VARCHAR(255),
    ruolo ENUM('CLIENTE', 'ADMIN') DEFAULT 'CLIENTE'
);

-- 5. Tabella Ordine
CREATE TABLE Ordine (
    id_ordine INT AUTO_INCREMENT PRIMARY KEY,
    data_ordine DATETIME DEFAULT CURRENT_TIMESTAMP,
    totale DECIMAL(10, 2) NOT NULL,
    stato VARCHAR(50) DEFAULT 'In elaborazione',
    id_utente INT,
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE
);

-- 6. Tabella Dettaglio_Ordine
CREATE TABLE Dettaglio_Ordine (
    id_ordine INT,
    id_prodotto INT,
    quantita_acquistata INT NOT NULL,
    prezzo_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_ordine, id_prodotto),
    FOREIGN KEY (id_ordine) REFERENCES Ordine(id_ordine) ON DELETE CASCADE,
    FOREIGN KEY (id_prodotto) REFERENCES Prodotto(id_prodotto) ON DELETE CASCADE
);