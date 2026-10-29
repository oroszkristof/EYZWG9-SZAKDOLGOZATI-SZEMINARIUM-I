-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Okt 29. 13:57
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `szakdolgozat_db`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `beosztasok`
--

CREATE TABLE `beosztasok` (
  `beosztasok_id` int(11) NOT NULL,
  `felhasznalok_id` int(11) NOT NULL,
  `feladat_id` int(11) NOT NULL,
  `optimalizalas_id` int(11) NOT NULL,
  `tervezett_munkaora` int(11) DEFAULT NULL,
  `tenyleges_munkaora` int(11) DEFAULT NULL,
  `statusz` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `beosztasok`
--

INSERT INTO `beosztasok` (`beosztasok_id`, `felhasznalok_id`, `feladat_id`, `optimalizalas_id`, `tervezett_munkaora`, `tenyleges_munkaora`, `statusz`) VALUES
(1, 3, 1, 1, 40, 20, 'folyamatban'),
(2, 2, 2, 1, 24, 0, 'tervezett'),
(3, 3, 3, 2, 36, 0, 'tervezett'),
(4, 3, 4, 2, 28, 0, 'tervezett'),
(5, 4, 5, 3, 40, 18, 'folyamatban'),
(6, 5, 6, 3, 24, 0, 'tervezett'),
(7, 5, 7, 4, 30, 0, 'tervezett'),
(8, 4, 8, 4, 20, 0, 'tervezett'),
(9, 3, 9, 5, 36, 12, 'folyamatban'),
(10, 2, 10, 5, 20, 0, 'tervezett');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cegek`
--

CREATE TABLE `cegek` (
  `cegek_id` int(11) NOT NULL,
  `nev` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `adoszam` varchar(20) NOT NULL,
  `letrehozva` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `cegek`
--

INSERT INTO `cegek` (`cegek_id`, `nev`, `email`, `adoszam`, `letrehozva`) VALUES
(1, 'TechNova Kft.', 'info@technova.example', '12345678-2-41', '2026-10-29 12:05:06'),
(2, 'CodeBridge Kft.', 'info@codebridge.example', '87654321-2-42', '2026-10-29 12:05:06');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `csoportok`
--

CREATE TABLE `csoportok` (
  `csoportok_id` int(11) NOT NULL,
  `ceg_id` int(11) NOT NULL,
  `vezeto_id` int(11) DEFAULT NULL,
  `nev` varchar(100) NOT NULL,
  `leiras` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `csoportok`
--

INSERT INTO `csoportok` (`csoportok_id`, `ceg_id`, `vezeto_id`, `nev`, `leiras`) VALUES
(1, 1, 2, 'Backend fejlesztői csoport', 'A TechNova Kft. szerveroldali fejlesztéseivel foglalkozó csoport.'),
(2, 1, 2, 'Adatfeldolgozó csoport', 'A TechNova Kft. adatfeldolgozási és automatizálási feladatait végző csoport.'),
(3, 2, 4, 'Frontend fejlesztői csoport', 'A CodeBridge Kft. felhasználói felületeinek fejlesztéséért felelős csoport.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `csoport_tagok`
--

CREATE TABLE `csoport_tagok` (
  `csoport_tagok_id` int(11) NOT NULL,
  `csoport_id` int(11) NOT NULL,
  `felhasznalo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `csoport_tagok`
--

INSERT INTO `csoport_tagok` (`csoport_tagok_id`, `csoport_id`, `felhasznalo_id`) VALUES
(1, 1, 2),
(2, 1, 3),
(3, 2, 2),
(4, 2, 3),
(5, 3, 4);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `feladatok`
--

CREATE TABLE `feladatok` (
  `feladatok_id` int(11) NOT NULL,
  `projekt_id` int(11) NOT NULL,
  `szukseges_keszseg_id` int(11) NOT NULL,
  `nev` varchar(150) NOT NULL,
  `leiras` text DEFAULT NULL,
  `prioritas` int(11) DEFAULT NULL,
  `becsult_munkaora` int(11) DEFAULT NULL,
  `elvart_szint` int(11) DEFAULT NULL,
  `hatarido` date DEFAULT NULL,
  `statusz` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `feladatok`
--

INSERT INTO `feladatok` (`feladatok_id`, `projekt_id`, `szukseges_keszseg_id`, `nev`, `leiras`, `prioritas`, `becsult_munkaora`, `elvart_szint`, `hatarido`, `statusz`) VALUES
(1, 1, 1, 'Backend API fejlesztése', 'A vállalatirányítási rendszer REST API végpontjainak kialakítása.', 5, 40, 4, '2026-12-15', 'folyamatban'),
(2, 1, 4, 'Adatbázis-lekérdezések készítése', 'A vállalatirányítási rendszer SQL-lekérdezéseinek elkészítése.', 4, 24, 4, '2027-01-15', 'tervezett'),
(3, 2, 1, 'Adatfeldolgozó modul fejlesztése', 'Automatizált adatfeldolgozó folyamatok megvalósítása Pythonban.', 5, 36, 4, '2027-01-31', 'tervezett'),
(4, 2, 6, 'MongoDB adatkezelés kialakítása', 'Dokumentumorientált adattárolási megoldás kialakítása.', 3, 28, 3, '2027-02-28', 'tervezett'),
(5, 3, 3, 'Webáruház felület fejlesztése', 'A webáruház interaktív felhasználói felületének kialakítása.', 5, 40, 4, '2026-12-20', 'folyamatban'),
(6, 3, 5, 'Terméklista komponens készítése', 'React-alapú terméklista és keresési felület fejlesztése.', 4, 24, 3, '2027-01-15', 'tervezett'),
(7, 4, 5, 'Ügyfélportál kezdőoldal', 'Az ügyfélportál kezdőoldalának elkészítése React használatával.', 3, 30, 3, '2027-02-28', 'tervezett'),
(8, 4, 3, 'Űrlapkezelés megvalósítása', 'Az ügyfélportál interaktív űrlapjainak fejlesztése.', 4, 20, 3, '2027-03-31', 'tervezett'),
(9, 5, 1, 'API integráció fejlesztése', 'Külső szolgáltatások REST API kapcsolatainak megvalósítása.', 5, 36, 4, '2027-01-15', 'folyamatban'),
(10, 5, 4, 'Integrációs adatok kezelése', 'A külső rendszerekből érkező adatok SQL-alapú tárolása.', 4, 20, 4, '2027-02-01', 'tervezett');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `felhasznalok_id` int(11) NOT NULL,
  `ceg_id` int(11) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `jelszo` varchar(255) NOT NULL,
  `szerepkor` enum('cegvezeto','csoportvezeto','fejleszto') NOT NULL,
  `szakterulet` varchar(100) DEFAULT NULL,
  `tapasztalat_ev` int(11) DEFAULT NULL,
  `heti_kapacitas` int(11) DEFAULT NULL,
  `foglalkoztatas_tipusa` enum('teljes_munkaido','reszmunkaido') DEFAULT NULL,
  `letrehozva` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`felhasznalok_id`, `ceg_id`, `nev`, `email`, `jelszo`, `szerepkor`, `szakterulet`, `tapasztalat_ev`, `heti_kapacitas`, `foglalkoztatas_tipusa`, `letrehozva`) VALUES
(1, 1, 'Kovács Péter', 'kovacs.peter@technova.example', 'teszt123', 'cegvezeto', 'Projektmenedzsment', 12, 40, 'teljes_munkaido', '2026-10-29 12:16:02'),
(2, 1, 'Nagy Anna', 'nagy.anna@technova.example', 'teszt123', 'csoportvezeto', 'Backend fejlesztés', 8, 40, 'teljes_munkaido', '2026-10-29 12:16:02'),
(3, 1, 'Szabó Bence', 'szabo.bence@technova.example', 'teszt123', 'fejleszto', 'Python fejlesztés', 4, 40, 'teljes_munkaido', '2026-10-29 12:16:02'),
(4, 2, 'Tóth Eszter', 'toth.eszter@codebridge.example', 'teszt123', 'csoportvezeto', 'Frontend fejlesztés', 7, 40, 'teljes_munkaido', '2026-10-29 12:16:02'),
(5, 2, 'Varga Dávid', 'varga.david@codebridge.example', 'teszt123', 'fejleszto', 'Webfejlesztés', 3, 20, 'reszmunkaido', '2026-10-29 12:16:02');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok_keszsegek`
--

CREATE TABLE `felhasznalok_keszsegek` (
  `felhasznalok_keszsegek_id` int(11) NOT NULL,
  `felhasznalo_id` int(11) NOT NULL,
  `keszseg_id` int(11) NOT NULL,
  `szint` int(11) NOT NULL,
  `tapasztalat_ev` int(11) DEFAULT NULL,
  `megjegyzes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `felhasznalok_keszsegek`
--

INSERT INTO `felhasznalok_keszsegek` (`felhasznalok_keszsegek_id`, `felhasznalo_id`, `keszseg_id`, `szint`, `tapasztalat_ev`, `megjegyzes`) VALUES
(1, 2, 1, 5, 8, 'Haladó Python fejlesztési tapasztalat'),
(2, 2, 4, 5, 7, 'Relációs adatbázisok tervezése'),
(3, 3, 1, 4, 4, 'Backend alkalmazások fejlesztése'),
(4, 3, 6, 3, 2, 'MongoDB adatbázisok kezelése'),
(5, 4, 3, 5, 7, 'Frontend alkalmazások fejlesztése'),
(6, 4, 5, 5, 5, 'React alkalmazások fejlesztése'),
(7, 5, 3, 3, 3, 'JavaScript webfejlesztés'),
(8, 5, 5, 3, 2, 'React komponensek készítése');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `keszsegek`
--

CREATE TABLE `keszsegek` (
  `keszsegek_id` int(11) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `kategoria` varchar(100) DEFAULT NULL,
  `leiras` text DEFAULT NULL,
  `aktiv` tinyint(1) NOT NULL DEFAULT 1,
  `letrehozva` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `keszsegek`
--

INSERT INTO `keszsegek` (`keszsegek_id`, `nev`, `kategoria`, `leiras`, `aktiv`, `letrehozva`) VALUES
(1, 'Python', 'Programozási nyelv', 'Backend fejlesztéshez és adatfeldolgozáshoz használt programozási nyelv.', 1, '2026-10-29 12:28:48'),
(2, 'Java', 'Programozási nyelv', 'Objektumorientált alkalmazások fejlesztésére használt programozási nyelv.', 1, '2026-10-29 12:28:48'),
(3, 'JavaScript', 'Programozási nyelv', 'Webes alkalmazások és interaktív felületek fejlesztésére használt nyelv.', 1, '2026-10-29 12:28:48'),
(4, 'SQL', 'Adatbázis-kezelés', 'Relációs adatbázisok kezelésére és lekérdezésére szolgáló nyelv.', 1, '2026-10-29 12:28:48'),
(5, 'React', 'Frontend technológia', 'Felhasználói felületek fejlesztésére szolgáló JavaScript könyvtár.', 1, '2026-10-29 12:28:48'),
(6, 'MongoDB', 'Adatbázis-kezelés', 'Dokumentumorientált NoSQL adatbázis-kezelő rendszer.', 1, '2026-10-29 12:28:48');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `optimalizalasok`
--

CREATE TABLE `optimalizalasok` (
  `optimalizalasok_id` int(11) NOT NULL,
  `projekt_id` int(11) NOT NULL,
  `futtato_id` int(11) NOT NULL,
  `optimalizalas_nev` varchar(150) NOT NULL,
  `futtatas_ideje` datetime NOT NULL DEFAULT current_timestamp(),
  `populacio_meret` int(11) DEFAULT NULL,
  `generaciok_szama` int(11) DEFAULT NULL,
  `mutacios_rata` decimal(5,4) DEFAULT NULL,
  `keresztezesi_rata` decimal(5,4) DEFAULT NULL,
  `fitness_ertek` decimal(10,4) DEFAULT NULL,
  `futasi_ido_ms` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `optimalizalasok`
--

INSERT INTO `optimalizalasok` (`optimalizalasok_id`, `projekt_id`, `futtato_id`, `optimalizalas_nev`, `futtatas_ideje`, `populacio_meret`, `generaciok_szama`, `mutacios_rata`, `keresztezesi_rata`, `fitness_ertek`, `futasi_ido_ms`) VALUES
(1, 1, 2, 'Vállalatirányítási rendszer optimalizálása', '2026-10-29 12:46:26', 50, 100, 0.0500, 0.8000, 92.5000, 1250),
(2, 2, 2, 'Adatfeldolgozó platform optimalizálása', '2026-10-29 12:46:26', 60, 120, 0.0400, 0.8500, 89.7500, 1480),
(3, 3, 4, 'Webáruház fejlesztés optimalizálása', '2026-10-29 12:46:26', 50, 100, 0.0600, 0.8000, 94.2000, 1320),
(4, 4, 4, 'Ügyfélportál optimalizálása', '2026-10-29 12:46:26', 40, 80, 0.0500, 0.7500, 87.6000, 980),
(5, 5, 2, 'API integrációs rendszer optimalizálása', '2026-10-29 12:46:26', 70, 150, 0.0300, 0.9000, 95.1000, 1750);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `projektek`
--

CREATE TABLE `projektek` (
  `projektek_id` int(11) NOT NULL,
  `ceg_id` int(11) NOT NULL,
  `csoport_id` int(11) NOT NULL,
  `nev` varchar(150) NOT NULL,
  `leiras` text DEFAULT NULL,
  `kezdes` date DEFAULT NULL,
  `hatarido` date DEFAULT NULL,
  `prioritas` int(11) DEFAULT NULL,
  `statusz` varchar(50) DEFAULT NULL,
  `letrehozva` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `projektek`
--

INSERT INTO `projektek` (`projektek_id`, `ceg_id`, `csoport_id`, `nev`, `leiras`, `kezdes`, `hatarido`, `prioritas`, `statusz`, `letrehozva`) VALUES
(1, 1, 1, 'Vállalatirányítási rendszer', 'Belső vállalatirányítási rendszer backend fejlesztése.', '2026-09-01', '2027-02-28', 5, 'folyamatban', '2026-10-29 12:33:53'),
(2, 1, 2, 'Adatfeldolgozó platform', 'Automatizált adatfeldolgozási és elemzési platform fejlesztése.', '2026-10-01', '2027-03-31', 4, 'folyamatban', '2026-10-29 12:33:53'),
(3, 2, 3, 'Webáruház fejlesztés', 'Reszponzív webáruház felhasználói felületének kialakítása.', '2026-09-15', '2027-01-31', 5, 'folyamatban', '2026-10-29 12:33:53'),
(4, 2, 3, 'Ügyfélportál', 'Online ügyfélportál frontend fejlesztése.', '2026-11-01', '2027-04-30', 3, 'tervezett', '2026-10-29 12:33:53'),
(5, 1, 1, 'API integrációs rendszer', 'Külső szolgáltatások integrálása REST API-kon keresztül.', '2026-10-15', '2027-02-15', 4, 'folyamatban', '2026-10-29 12:33:53');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `beosztasok`
--
ALTER TABLE `beosztasok`
  ADD PRIMARY KEY (`beosztasok_id`),
  ADD KEY `felhasznalok_id` (`felhasznalok_id`),
  ADD KEY `feladat_id` (`feladat_id`),
  ADD KEY `optimalizalas_id` (`optimalizalas_id`);

--
-- A tábla indexei `cegek`
--
ALTER TABLE `cegek`
  ADD PRIMARY KEY (`cegek_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A tábla indexei `csoportok`
--
ALTER TABLE `csoportok`
  ADD PRIMARY KEY (`csoportok_id`),
  ADD KEY `ceg_id` (`ceg_id`),
  ADD KEY `vezeto_id` (`vezeto_id`);

--
-- A tábla indexei `csoport_tagok`
--
ALTER TABLE `csoport_tagok`
  ADD PRIMARY KEY (`csoport_tagok_id`),
  ADD KEY `csoport_id` (`csoport_id`),
  ADD KEY `felhasznalo_id` (`felhasznalo_id`);

--
-- A tábla indexei `feladatok`
--
ALTER TABLE `feladatok`
  ADD PRIMARY KEY (`feladatok_id`),
  ADD KEY `projekt_id` (`projekt_id`),
  ADD KEY `szukseges_keszseg_id` (`szukseges_keszseg_id`);

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`felhasznalok_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `ceg_id` (`ceg_id`);

--
-- A tábla indexei `felhasznalok_keszsegek`
--
ALTER TABLE `felhasznalok_keszsegek`
  ADD PRIMARY KEY (`felhasznalok_keszsegek_id`),
  ADD KEY `felhasznalo_id` (`felhasznalo_id`),
  ADD KEY `keszseg_id` (`keszseg_id`);

--
-- A tábla indexei `keszsegek`
--
ALTER TABLE `keszsegek`
  ADD PRIMARY KEY (`keszsegek_id`);

--
-- A tábla indexei `optimalizalasok`
--
ALTER TABLE `optimalizalasok`
  ADD PRIMARY KEY (`optimalizalasok_id`),
  ADD KEY `projekt_id` (`projekt_id`),
  ADD KEY `futtato_id` (`futtato_id`);

--
-- A tábla indexei `projektek`
--
ALTER TABLE `projektek`
  ADD PRIMARY KEY (`projektek_id`),
  ADD KEY `ceg_id` (`ceg_id`),
  ADD KEY `csoport_id` (`csoport_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `beosztasok`
--
ALTER TABLE `beosztasok`
  MODIFY `beosztasok_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `cegek`
--
ALTER TABLE `cegek`
  MODIFY `cegek_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `csoportok`
--
ALTER TABLE `csoportok`
  MODIFY `csoportok_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `csoport_tagok`
--
ALTER TABLE `csoport_tagok`
  MODIFY `csoport_tagok_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `feladatok`
--
ALTER TABLE `feladatok`
  MODIFY `feladatok_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `felhasznalok_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `felhasznalok_keszsegek`
--
ALTER TABLE `felhasznalok_keszsegek`
  MODIFY `felhasznalok_keszsegek_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `keszsegek`
--
ALTER TABLE `keszsegek`
  MODIFY `keszsegek_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `optimalizalasok`
--
ALTER TABLE `optimalizalasok`
  MODIFY `optimalizalasok_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `projektek`
--
ALTER TABLE `projektek`
  MODIFY `projektek_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `beosztasok`
--
ALTER TABLE `beosztasok`
  ADD CONSTRAINT `beosztasok_ibfk_1` FOREIGN KEY (`felhasznalok_id`) REFERENCES `felhasznalok` (`felhasznalok_id`),
  ADD CONSTRAINT `beosztasok_ibfk_2` FOREIGN KEY (`feladat_id`) REFERENCES `feladatok` (`feladatok_id`),
  ADD CONSTRAINT `beosztasok_ibfk_3` FOREIGN KEY (`optimalizalas_id`) REFERENCES `optimalizalasok` (`optimalizalasok_id`);

--
-- Megkötések a táblához `csoportok`
--
ALTER TABLE `csoportok`
  ADD CONSTRAINT `csoportok_ibfk_1` FOREIGN KEY (`ceg_id`) REFERENCES `cegek` (`cegek_id`),
  ADD CONSTRAINT `csoportok_ibfk_2` FOREIGN KEY (`vezeto_id`) REFERENCES `felhasznalok` (`felhasznalok_id`);

--
-- Megkötések a táblához `csoport_tagok`
--
ALTER TABLE `csoport_tagok`
  ADD CONSTRAINT `csoport_tagok_ibfk_1` FOREIGN KEY (`csoport_id`) REFERENCES `csoportok` (`csoportok_id`),
  ADD CONSTRAINT `csoport_tagok_ibfk_2` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`felhasznalok_id`);

--
-- Megkötések a táblához `feladatok`
--
ALTER TABLE `feladatok`
  ADD CONSTRAINT `feladatok_ibfk_1` FOREIGN KEY (`projekt_id`) REFERENCES `projektek` (`projektek_id`),
  ADD CONSTRAINT `feladatok_ibfk_2` FOREIGN KEY (`szukseges_keszseg_id`) REFERENCES `keszsegek` (`keszsegek_id`);

--
-- Megkötések a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD CONSTRAINT `felhasznalok_ibfk_1` FOREIGN KEY (`ceg_id`) REFERENCES `cegek` (`cegek_id`);

--
-- Megkötések a táblához `felhasznalok_keszsegek`
--
ALTER TABLE `felhasznalok_keszsegek`
  ADD CONSTRAINT `felhasznalok_keszsegek_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`felhasznalok_id`),
  ADD CONSTRAINT `felhasznalok_keszsegek_ibfk_2` FOREIGN KEY (`keszseg_id`) REFERENCES `keszsegek` (`keszsegek_id`);

--
-- Megkötések a táblához `optimalizalasok`
--
ALTER TABLE `optimalizalasok`
  ADD CONSTRAINT `optimalizalasok_ibfk_1` FOREIGN KEY (`projekt_id`) REFERENCES `projektek` (`projektek_id`),
  ADD CONSTRAINT `optimalizalasok_ibfk_2` FOREIGN KEY (`futtato_id`) REFERENCES `felhasznalok` (`felhasznalok_id`);

--
-- Megkötések a táblához `projektek`
--
ALTER TABLE `projektek`
  ADD CONSTRAINT `projektek_ibfk_1` FOREIGN KEY (`ceg_id`) REFERENCES `cegek` (`cegek_id`),
  ADD CONSTRAINT `projektek_ibfk_2` FOREIGN KEY (`csoport_id`) REFERENCES `csoportok` (`csoportok_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
