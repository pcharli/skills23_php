-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 29 juin 2023 à 07:56
-- Version du serveur : 10.4.20-MariaDB
-- Version de PHP : 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `skills_23`
--

-- --------------------------------------------------------

--
-- Structure de la table `cities`
--

CREATE TABLE `cities` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `zipcode` varchar(100) NOT NULL,
  `id_pays` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `cities`
--

INSERT INTO `cities` (`id`, `name`, `zipcode`, `id_pays`) VALUES
(3, 'Philippeville', '5600', 1),
(4, 'Jamagne', '5600', 1),
(6, 'Charleroi', '6000', 1),
(7, 'Bruxelles', '1000', 1),
(8, 'Gosselies', '6041', 1),
(10, 'Istambul', '25L425', 3),
(13, 'Liège', '4000', 1),
(16, 'Madrid', '556685', 5),
(17, 'USA', '', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `contacts`
--

CREATE TABLE `contacts` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `adresse` varchar(300) DEFAULT NULL,
  `id_city` smallint(6) DEFAULT NULL,
  `inscription` tinyint(1) DEFAULT 1,
  `hobbies` set('tennis','cinéma','théâtre') DEFAULT NULL,
  `genre` enum('homme','femme','autre') DEFAULT NULL,
  `id_pere` smallint(6) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `prénom usuel` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `contacts`
--

INSERT INTO `contacts` (`id`, `lastname`, `firstname`, `email`, `adresse`, `id_city`, `inscription`, `hobbies`, `genre`, `id_pere`, `meta`, `prénom usuel`) VALUES
(1, 'Charlier', 'Pierre', 'ch.pi@gmail.com', 'Allée des Bleuets 10', 3, 1, 'tennis,théâtre', 'homme', 12, NULL, ''),
(2, 'Charlier', 'Benoit', NULL, 'Rue du Pouly 76', 4, 1, 'théâtre', 'homme', 12, NULL, ''),
(3, 'Barrier', 'Nicolas', 'nicolas.barrier@yahoo.fr', NULL, NULL, 0, NULL, NULL, NULL, NULL, ''),
(4, 'VanGru', 'Martine', 'vgma@hotmail.com', 'rue Baron 2', 6, NULL, 'cinéma,théâtre', 'femme', NULL, NULL, ''),
(5, 'Bonus', 'Stephane', NULL, NULL, NULL, 1, 'tennis', 'homme', NULL, NULL, ''),
(6, 'Pfer', 'Henry', 'hp@music.com', 'Rue de la musique 128', 6, 1, 'cinéma', 'femme', NULL, NULL, ''),
(7, 'Proust', 'Marcel', 'mp@livres.com', 'Rue du poème 19', 7, 0, 'théâtre', NULL, NULL, NULL, ''),
(8, 'Devos', 'Françoise', 'fd@cepegra.be', 'Av. G. Lemaître 22', 8, NULL, 'cinéma', 'femme', NULL, NULL, ''),
(9, 'Vanderijk', 'Yo', NULL, 'Place du Martyr 5', 10, 1, 'cinéma', 'femme', 6, NULL, ''),
(10, 'Bellery', 'Olivier', 'ob@cepegra.be', 'Rue Machin 18', 15, 1, 'cinéma', 'homme', NULL, NULL, ''),
(11, 'test', 'test', NULL, NULL, NULL, NULL, NULL, 'homme', NULL, NULL, 'nbnvn'),
(12, 'Charlier', 'Jean', NULL, NULL, NULL, 1, NULL, 'homme', 13, NULL, ''),
(13, 'Charlier', 'André', NULL, NULL, NULL, 1, NULL, 'homme', NULL, NULL, ''),
(15, 'Fichère', 'Gregory', NULL, NULL, NULL, 1, NULL, 'homme', NULL, NULL, ''),
(16, 'fabri', 'damien', NULL, NULL, NULL, 1, NULL, 'homme', NULL, NULL, ''),
(17, 'burke', 'bernadette', NULL, NULL, NULL, 1, NULL, 'femme', NULL, '{\r\n\"poste\" : \"secrétaire\"\r\n}', ''),
(19, 'vand', 'Thierry', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, ''),
(21, 'vand2', 'Thierry2', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, ''),
(22, 'chapeline', 'charlies brown', NULL, 'Rue du cinéma 12', 8, 1, NULL, 'homme', NULL, '{\"job\": \"acteur\"}', ''),
(23, 'Louis', 'Michel', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, ''),
(24, 'Louis', 'Michel', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, ''),
(25, 'Proust', 'Marcel', 'marcel@books.com', NULL, NULL, 1, NULL, 'homme', NULL, NULL, '');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `contacts_villes_pays`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `contacts_villes_pays` (
`id` smallint(5) unsigned
,`lastname` varchar(150)
,`firstname` varchar(150)
,`email` varchar(255)
,`adresse` varchar(300)
,`id_city` smallint(6)
,`inscription` tinyint(1)
,`hobbies` set('tennis','cinéma','théâtre')
,`genre` enum('homme','femme','autre')
,`id_cities` smallint(5) unsigned
,`name_city` varchar(100)
,`zipcode` varchar(100)
,`id_pays` tinyint(4)
,`id_contries` tinyint(3) unsigned
,`name_country` varchar(200)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `dad_and_soon`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `dad_and_soon` (
`id` smallint(5) unsigned
,`firstname` varchar(150)
,`lastname` varchar(150)
,`id_pere` smallint(5) unsigned
,`pere_firstname` varchar(150)
,`pere_lastname` varchar(150)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `pas dans villes 5 et 7`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `pas dans villes 5 et 7` (
`id` smallint(5) unsigned
,`firstname` varchar(150)
,`lastname` varchar(150)
,`genre` enum('homme','femme','autre')
);

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

CREATE TABLE `pays` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`id`, `name`) VALUES
(1, 'Belgique'),
(5, 'Espagne'),
(3, 'France2'),
(6, 'USA');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `login`, `password`) VALUES
(1, 'admin', 'pass'),
(2, 'pierre', 'test');

-- --------------------------------------------------------

--
-- Structure de la vue `contacts_villes_pays`
--
DROP TABLE IF EXISTS `contacts_villes_pays`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `contacts_villes_pays`  AS SELECT `contacts`.`id` AS `id`, `contacts`.`lastname` AS `lastname`, `contacts`.`firstname` AS `firstname`, `contacts`.`email` AS `email`, `contacts`.`adresse` AS `adresse`, `contacts`.`id_city` AS `id_city`, `contacts`.`inscription` AS `inscription`, `contacts`.`hobbies` AS `hobbies`, `contacts`.`genre` AS `genre`, `cities`.`id` AS `id_cities`, `cities`.`name` AS `name_city`, `cities`.`zipcode` AS `zipcode`, `cities`.`id_pays` AS `id_pays`, `pays`.`id` AS `id_contries`, `pays`.`name` AS `name_country` FROM ((`contacts` left join `cities` on(`cities`.`id` = `contacts`.`id_city`)) left join `pays` on(`cities`.`id_pays` = `pays`.`id`)) ORDER BY `pays`.`name` ASC ;

-- --------------------------------------------------------

--
-- Structure de la vue `dad_and_soon`
--
DROP TABLE IF EXISTS `dad_and_soon`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dad_and_soon`  AS SELECT `contacts`.`id` AS `id`, `contacts`.`firstname` AS `firstname`, `contacts`.`lastname` AS `lastname`, `peres`.`id` AS `id_pere`, `peres`.`firstname` AS `pere_firstname`, `peres`.`lastname` AS `pere_lastname` FROM (`contacts` join `contacts` `peres` on(`contacts`.`id_pere` = `peres`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `pas dans villes 5 et 7`
--
DROP TABLE IF EXISTS `pas dans villes 5 et 7`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pas dans villes 5 et 7`  AS SELECT `contacts`.`id` AS `id`, `contacts`.`firstname` AS `firstname`, `contacts`.`lastname` AS `lastname`, `contacts`.`genre` AS `genre` FROM `contacts` WHERE `contacts`.`id_city` not in (5,7) ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `zipcode` (`zipcode`),
  ADD KEY `id_pays` (`id_pays`) USING BTREE;

--
-- Index pour la table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `lastname` (`lastname`),
  ADD KEY `firstname` (`firstname`),
  ADD KEY `id_city` (`id_city`),
  ADD KEY `id_pere` (`id_pere`);

--
-- Index pour la table `pays`
--
ALTER TABLE `pays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `pays`
--
ALTER TABLE `pays`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
