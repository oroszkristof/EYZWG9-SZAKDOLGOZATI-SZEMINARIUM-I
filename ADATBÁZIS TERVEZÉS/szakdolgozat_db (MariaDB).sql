ADATBÁZIS LÉTREHOZÁSA

CREATE DATABASE szakdolgozat_db;


BELÉPÉS AZ ADATBÁZISBA

USE szakdolgozat_db;


CÉGEK TÁBLA LÉTREHOZÁSA

CREATE TABLE cegek (
    cegek_id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    adoszam VARCHAR(20) NOT NULL,
    letrehozva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

FELHASZNÁLÓK TÁBLA LÉTREHOZÁSA


CREATE TABLE felhasznalok (
    felhasznalok_id INT AUTO_INCREMENT PRIMARY KEY,
    ceg_id INT NOT NULL,
    nev VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    jelszo VARCHAR(255) NOT NULL,
    szerepkor ENUM('cegvezeto', 'csoportvezeto', 'fejleszto') NOT NULL,
    szakterulet VARCHAR(100),
    tapasztalat_ev INT,
    heti_kapacitas INT,
    foglalkoztatas_tipusa ENUM('teljes_munkaido', 'reszmunkaido'),
    letrehozva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (ceg_id) REFERENCES cegek(cegek_id)
);

CSOPORTOK TÁBLA LÉTREHOZÁSA

CREATE TABLE csoportok (
    csoportok_id INT AUTO_INCREMENT PRIMARY KEY,
    ceg_id INT NOT NULL,
    vezeto_id INT NULL,
    nev VARCHAR(100) NOT NULL,
    leiras TEXT NULL,

    FOREIGN KEY (ceg_id) REFERENCES cegek(cegek_id),
    FOREIGN KEY (vezeto_id) REFERENCES felhasznalok(felhasznalok_id)
);

CSOPORT_TAGOK TÁBLA LÉTREHOZÁSA


CREATE TABLE csoport_tagok (
    csoport_tagok_id INT AUTO_INCREMENT PRIMARY KEY,
    csoport_id INT NOT NULL,
    felhasznalo_id INT NOT NULL,

    FOREIGN KEY (csoport_id) REFERENCES csoportok(csoportok_id),
    FOREIGN KEY (felhasznalo_id) REFERENCES felhasznalok(felhasznalok_id)
);




KÉSZSÉGEK TÁBLA LÉTREHOZÁSA


CREATE TABLE keszsegek (
    keszsegek_id INT AUTO_INCREMENT PRIMARY KEY,
    nev VARCHAR(100) NOT NULL,
    kategoria VARCHAR(100),
    leiras TEXT,
    aktiv BOOLEAN NOT NULL DEFAULT TRUE,
    letrehozva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

FELHASZNALOK_KESZSEGEK TÁBLA LÉTREHOZÁSA

CREATE TABLE felhasznalok_keszsegek (
    felhasznalok_keszsegek_id INT AUTO_INCREMENT PRIMARY KEY,
    felhasznalo_id INT NOT NULL,
    keszseg_id INT NOT NULL,
    szint INT NOT NULL,
    tapasztalat_ev INT,
    megjegyzes TEXT,

    FOREIGN KEY (felhasznalo_id) REFERENCES felhasznalok(felhasznalok_id),
    FOREIGN KEY (keszseg_id) REFERENCES keszsegek(keszsegek_id)
);


PROJEKTEK TÁBLA LÉTREHOZÁSA

CREATE TABLE projektek (
    projektek_id INT AUTO_INCREMENT PRIMARY KEY,
    ceg_id INT NOT NULL,
    csoport_id INT NOT NULL,
    nev VARCHAR(150) NOT NULL,
    leiras TEXT,
    kezdes DATE,
    hatarido DATE,
    prioritas INT,
    statusz VARCHAR(50),
    letrehozva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (ceg_id) REFERENCES cegek(cegek_id),
    FOREIGN KEY (csoport_id) REFERENCES csoportok(csoportok_id)
);

FELADATOK TÁBLA LÉTREHOZÁSA

CREATE TABLE feladatok (
    feladatok_id INT AUTO_INCREMENT PRIMARY KEY,
    projekt_id INT NOT NULL,
    szukseges_keszseg_id INT NOT NULL,
    nev VARCHAR(150) NOT NULL,
    leiras TEXT,
    prioritas INT,
    becsult_munkaora INT,
    elvart_szint INT,
    hatarido DATE,
    statusz VARCHAR(50),

    FOREIGN KEY (projekt_id) REFERENCES projektek(projektek_id),
    FOREIGN KEY (szukseges_keszseg_id) REFERENCES keszsegek(keszsegek_id)
);

OPTIMALIZALASOK TÁBLA LÉTREHOZÁSA

CREATE TABLE optimalizalasok (
    optimalizalasok_id INT AUTO_INCREMENT PRIMARY KEY,
    projekt_id INT NOT NULL,
    futtato_id INT NOT NULL,
    optimalizalas_nev VARCHAR(150) NOT NULL,
    futtatas_ideje DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    populacio_meret INT,
    generaciok_szama INT,
    mutacios_rata DECIMAL(5,4),
    keresztezesi_rata DECIMAL(5,4),
    fitness_ertek DECIMAL(10,4),
    futasi_ido_ms INT,

    FOREIGN KEY (projekt_id) REFERENCES projektek(projektek_id),
    FOREIGN KEY (futtato_id) REFERENCES felhasznalok(felhasznalok_id)
);

BEOSZTÁSOK TÁBLA LÉTREHOZÁSA


CREATE TABLE beosztasok (
    beosztasok_id INT AUTO_INCREMENT PRIMARY KEY,
    felhasznalok_id INT NOT NULL,
    feladat_id INT NOT NULL,
    optimalizalas_id INT NOT NULL,
    tervezett_munkaora INT,
    tenyleges_munkaora INT,
    statusz VARCHAR(50),

    FOREIGN KEY (felhasznalok_id) REFERENCES felhasznalok(felhasznalok_id),
    FOREIGN KEY (feladat_id) REFERENCES feladatok(feladatok_id),
    FOREIGN KEY (optimalizalas_id) REFERENCES optimalizalasok(optimalizalasok_id)
);

CÉGEK TÁBLA FELTÖLTÉSE

INSERT INTO cegek (nev, email, adoszam)
VALUES
('TechNova Kft.', 'info@technova.hu', '12345678-2-41'),
('CodeBridge Kft.', 'info@codebridge.hu', '87654321-2-42');


FELHASZNALOK TÁBLA FELTÖLTÉSE

INSERT INTO felhasznalok
(ceg_id, nev, email, jelszo, szerepkor,
 szakterulet, tapasztalat_ev, heti_kapacitas, foglalkoztatas_tipusa)
VALUES
(1, 'Kovács Péter', 'kovacs.peter@technova.hu', 'teszt123',
 'cegvezeto', 'Vállalatvezetés', 12, 40, 'teljes_munkaido'),

(1, 'Nagy Anna', 'nagy.anna@technova.hu', 'teszt123',
 'csoportvezeto', 'Backend fejlesztés', 8, 40, 'teljes_munkaido'),

(1, 'Szabó Bence', 'szabo.bence@technova.hu', 'teszt123',
 'fejleszto', 'Python fejlesztés', 4, 40, 'teljes_munkaido'),

(2, 'Tóth Eszter', 'toth.eszter@codebridge.hu', 'teszt123',
 'csoportvezeto', 'Frontend fejlesztés', 7, 40, 'teljes_munkaido'),

(2, 'Varga Dávid', 'varga.david@codebridge.hu', 'teszt123',
 'fejleszto', 'Webfejlesztés', 3, 20, 'reszmunkaido');


CSOPORTOK TÁBLA FELTÖLTÉSE

INSERT INTO csoportok
(ceg_id, vezeto_id, nev, leiras)
VALUES
(1, 2, 'Backend fejlesztői csoport',
 'Szerveroldali alkalmazások és API-k fejlesztése'),

(1, 2, 'Adatfeldolgozó csoport',
 'Adatfeldolgozási és adatbázis-kezelési feladatok'),

(2, 4, 'Frontend fejlesztői csoport',
 'Webes felhasználói felületek fejlesztése');


CSOPORT_TAGOK TÁBLA FELTÖLTÉSE

INSERT INTO csoport_tagok
(csoport_id, felhasznalo_id)
VALUES
(1, 2),
(1, 3),
(2, 2),
(2, 3),
(3, 4);


KESZSEGEK TÁBLA FELTÖLTÉSE

INSERT INTO keszsegek
(nev, kategoria, leiras, aktiv)
VALUES
('Python', 'Programozási nyelv', 'Python alapú alkalmazásfejlesztés', TRUE),
('Java', 'Programozási nyelv', 'Java alkalmazások fejlesztése', TRUE),
('JavaScript', 'Programozási nyelv', 'Webes alkalmazások fejlesztése', TRUE),
('SQL', 'Adatbázis', 'Relációs adatbázisok kezelése', TRUE),
('React', 'Frontend keretrendszer', 'React alapú felületfejlesztés', TRUE),
('MongoDB', 'Adatbázis', 'Dokumentumorientált adatbázis-kezelés', TRUE);


FELHASZNALOK_KESZSEGEK TÁBLA FELTÖLTÉSE

INSERT INTO felhasznalok_keszsegek
(felhasznalo_id, keszseg_id, szint, tapasztalat_ev, megjegyzes)
VALUES
(2, 1, 5, 7, 'Haladó Python ismeretek'),
(2, 4, 5, 8, 'Adatbázis-tervezési tapasztalat'),
(3, 1, 4, 4, 'Python fejlesztési tapasztalat'),
(3, 6, 3, 2, 'MongoDB alapismeretek'),
(4, 3, 5, 7, 'Haladó JavaScript ismeretek'),
(4, 5, 5, 6, 'React fejlesztési tapasztalat'),
(5, 3, 3, 3, 'JavaScript fejlesztési tapasztalat'),
(5, 5, 3, 2, 'React komponensek fejlesztése');


PROJEKTEK TÁBLA FELTÖLTÉSE

INSERT INTO projektek
(ceg_id, csoport_id, nev, leiras, kezdes, hatarido, prioritas, statusz)
VALUES
(1, 1, 'Vállalatirányítási rendszer',
 'Vállalati folyamatokat támogató rendszer fejlesztése',
 '2026-01-10', '2026-06-30', 5, 'folyamatban'),

(1, 2, 'Adatfeldolgozó platform',
 'Nagy mennyiségű adat feldolgozására szolgáló platform',
 '2026-02-01', '2026-07-31', 4, 'folyamatban'),

(2, 3, 'Webáruház fejlesztés',
 'Modern webáruház felület kialakítása',
 '2026-01-15', '2026-05-31', 5, 'folyamatban'),

(2, 3, 'Ügyfélportál',
 'Ügyfelek számára elérhető webes portál',
 '2026-03-01', '2026-08-31', 3, 'tervezett'),

(1, 1, 'API integrációs rendszer',
 'Külső rendszerek összekapcsolása API-kon keresztül',
 '2026-02-15', '2026-09-30', 4, 'folyamatban');

FELADATOK TÁBLA FELTÖLTÉSE

INSERT INTO feladatok
(projekt_id, szukseges_keszseg_id, nev, leiras,
 prioritas, becsult_munkaora, elvart_szint, hatarido, statusz)
VALUES
(1, 1, 'Backend API fejlesztése',
 'A rendszer backend API végpontjainak elkészítése',
 5, 40, 4, '2026-04-30', 'folyamatban'),

(1, 4, 'Adatbázis-lekérdezések készítése',
 'SQL lekérdezések megvalósítása',
 4, 24, 4, '2026-05-15', 'tervezett'),

(2, 1, 'Adatfeldolgozó modul fejlesztése',
 'Adatfeldolgozási funkciók kialakítása',
 5, 36, 4, '2026-05-31', 'tervezett'),

(2, 6, 'MongoDB adatkezelés kialakítása',
 'MongoDB alapú adattárolás megvalósítása',
 4, 28, 3, '2026-06-15', 'tervezett'),

(3, 3, 'Webáruház felület fejlesztése',
 'A webáruház felhasználói felületének elkészítése',
 5, 40, 4, '2026-04-30', 'folyamatban'),

(3, 5, 'Terméklista komponens készítése',
 'React alapú terméklista megvalósítása',
 4, 24, 3, '2026-05-15', 'tervezett'),

(4, 5, 'Ügyfélportál kezdőoldal',
 'Az ügyfélportál kezdőoldalának kialakítása',
 4, 30, 3, '2026-06-30', 'tervezett'),

(4, 3, 'Űrlapkezelés megvalósítása',
 'Webes űrlapok és validáció kialakítása',
 3, 20, 3, '2026-07-15', 'tervezett'),

(5, 1, 'API integráció fejlesztése',
 'Külső API-k integrációjának megvalósítása',
 5, 36, 4, '2026-07-31', 'folyamatban'),

(5, 4, 'Integrációs adatok kezelése',
 'Integrációs adatok adatbázis-kezelése',
 4, 20, 4, '2026-08-15', 'tervezett');


OPTIMALIZÁLÁSOK TÁBLÁK FELTÖLTÉSE

INSERT INTO optimalizalasok
(projekt_id, futtato_id, optimalizalas_nev,
 populacio_meret, generaciok_szama, mutacios_rata,
 keresztezesi_rata, fitness_ertek, futasi_ido_ms)
VALUES
(1, 2, 'Vállalatirányítási optimalizálás',
 50, 100, 0.0500, 0.8000, 92.5000, 1250),

(2, 2, 'Adatfeldolgozási optimalizálás',
 60, 120, 0.0400, 0.8500, 89.7500, 1480),

(3, 4, 'Webáruház optimalizálás',
 50, 100, 0.0600, 0.8000, 94.2000, 1320),

(4, 4, 'Ügyfélportál optimalizálás',
 40, 80, 0.0500, 0.7500, 87.6000, 980),

(5, 2, 'API integrációs optimalizálás',
 70, 150, 0.0300, 0.9000, 95.1000, 1750);

BEOSZTASOK TÁBLÁK FELTÖLTÉSE

INSERT INTO beosztasok
(felhasznalok_id, feladat_id, optimalizalas_id,
 tervezett_munkaora, tenyleges_munkaora, statusz)
VALUES
(3, 1, 1, 40, 20, 'folyamatban'),
(2, 2, 1, 24, 0, 'tervezett'),
(3, 3, 2, 36, 0, 'tervezett'),
(3, 4, 2, 28, 0, 'tervezett'),
(4, 5, 3, 40, 18, 'folyamatban'),
(5, 6, 3, 24, 0, 'tervezett'),
(5, 7, 4, 30, 0, 'tervezett'),
(4, 8, 4, 20, 0, 'tervezett'),
(3, 9, 5, 36, 12, 'folyamatban'),
(2, 10, 5, 20, 0, 'tervezett');

