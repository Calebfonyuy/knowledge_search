-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 27, 2019 at 11:47 AM
-- Server version: 5.7.28-0ubuntu0.18.04.4
-- PHP Version: 7.2.24-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `knowledge_search`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add blocked site', 7, 'add_blockedsite'),
(26, 'Can change blocked site', 7, 'change_blockedsite'),
(27, 'Can delete blocked site', 7, 'delete_blockedsite'),
(28, 'Can view blocked site', 7, 'view_blockedsite'),
(29, 'Can add result', 8, 'add_result'),
(30, 'Can change result', 8, 'change_result'),
(31, 'Can delete result', 8, 'delete_result'),
(32, 'Can view result', 8, 'view_result'),
(33, 'Can add search', 9, 'add_search'),
(34, 'Can change search', 9, 'change_search'),
(35, 'Can delete search', 9, 'delete_search'),
(36, 'Can view search', 9, 'view_search');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$150000$NSk0BViDc6GD$3/ELasvs4dp+tzrhmm3/ECIsKvw1Ol6jarcZGMLKH38=', '2019-12-13 15:35:44.638959', 1, 'admin', '', '', '', 1, 1, '2019-12-07 11:17:17.665580');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2019-12-07 11:28:42.202272', '1', 'BlockedSite object (1)', 1, '[{\"added\": {}}]', 7, 1),
(2, '2019-12-07 11:29:07.285792', '2', 'BlockedSite object (2)', 1, '[{\"added\": {}}]', 7, 1),
(3, '2019-12-07 11:30:27.277043', '3', 'www.twitter.com', 1, '[{\"added\": {}}]', 7, 1),
(4, '2019-12-12 18:09:40.155297', '4', 'amazon.com', 1, '[{\"added\": {}}]', 7, 1),
(5, '2019-12-12 18:10:01.805692', '5', 'www.walmart.com', 1, '[{\"added\": {}}]', 7, 1),
(6, '2019-12-12 18:10:15.336156', '6', 'www.newegg.com', 1, '[{\"added\": {}}]', 7, 1),
(7, '2019-12-12 18:10:43.189490', '7', 'www.samsclub.com', 1, '[{\"added\": {}}]', 7, 1),
(8, '2019-12-12 18:11:11.203129', '8', 'www.staples.com', 1, '[{\"added\": {}}]', 7, 1),
(9, '2019-12-13 15:36:00.352383', '9', 'instagram.com', 1, '[{\"added\": {}}]', 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'search', 'blockedsite'),
(8, 'search', 'result'),
(9, 'search', 'search'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2019-12-07 11:14:19.909696'),
(2, 'auth', '0001_initial', '2019-12-07 11:14:21.799729'),
(3, 'admin', '0001_initial', '2019-12-07 11:14:29.438140'),
(4, 'admin', '0002_logentry_remove_auto_add', '2019-12-07 11:14:31.013122'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2019-12-07 11:14:31.068604'),
(6, 'contenttypes', '0002_remove_content_type_name', '2019-12-07 11:14:32.184696'),
(7, 'auth', '0002_alter_permission_name_max_length', '2019-12-07 11:14:32.365830'),
(8, 'auth', '0003_alter_user_email_max_length', '2019-12-07 11:14:32.508826'),
(9, 'auth', '0004_alter_user_username_opts', '2019-12-07 11:14:32.565585'),
(10, 'auth', '0005_alter_user_last_login_null', '2019-12-07 11:14:33.161165'),
(11, 'auth', '0006_require_contenttypes_0002', '2019-12-07 11:14:33.195737'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2019-12-07 11:14:33.237646'),
(13, 'auth', '0008_alter_user_username_max_length', '2019-12-07 11:14:33.443497'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2019-12-07 11:14:33.635374'),
(15, 'auth', '0010_alter_group_name_max_length', '2019-12-07 11:14:33.898245'),
(16, 'auth', '0011_update_proxy_permissions', '2019-12-07 11:14:33.947062'),
(17, 'sessions', '0001_initial', '2019-12-07 11:14:34.414888'),
(18, 'search', '0001_initial', '2019-12-07 11:17:36.570326');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('d04s48f53z401x0ttaf7qp42v5nx9kus', 'NWNkNWJlZjMzYTU5YjMyYjNiOWE2MmI4YmM4ZGI5NDg4Yjc0NjBkODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlY2VhNDZhMDcyYjdiNGM0OGUxMDBkNWE1M2E3YjM5MzI1OTU5ZGE5In0=', '2019-12-27 15:35:44.707484');

-- --------------------------------------------------------

--
-- Table structure for table `search_blockedsite`
--

CREATE TABLE `search_blockedsite` (
  `id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `search_blockedsite`
--

INSERT INTO `search_blockedsite` (`id`, `url`) VALUES
(1, 'www.youtube.com'),
(2, 'www.facebook.com'),
(3, 'www.twitter.com'),
(4, 'amazon.com'),
(5, 'www.walmart.com'),
(6, 'www.newegg.com'),
(7, 'www.samsclub.com'),
(8, 'www.staples.com'),
(9, 'instagram.com');

-- --------------------------------------------------------

--
-- Table structure for table `search_result`
--

CREATE TABLE `search_result` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `snippet` varchar(255) NOT NULL,
  `nb_match` int(11) NOT NULL,
  `search_word_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `search_result`
--

INSERT INTO `search_result` (`id`, `title`, `url`, `snippet`, `nb_match`, `search_word_id`) VALUES
(12, 'Computer - Wikipedia', 'https://en.wikipedia.org/wiki/Computer', 'A computer is a machine that can be instructed to carry out sequences of \narithmetic or logical operations automatically via computer programming. Modern\n ...', 414, 4),
(13, 'Computers & Accessories | Amazon.com', 'https://www.amazon.com/computer-pc-hardware-accessories-add-ons/b?ie=UTF8&node=541966', 'Shop a wide selection of laptops, tablets, desktop computers, and accessories on \nAmazon.com from top brands including Apple, HP, Dell, and more.', 49, 4),
(14, 'Computers: PC, Laptops & Desktops at Every Day Low Price ...', 'https://www.walmart.com/cp/computers/3951', 'Find your next computer at Walmart.com. Shop laptops, desktops, netbooks, ultra\n-books and tablets at Every Day Low prices.', 429, 4),
(15, 'Computers, Laptops and Gaming Desktops - Newegg.com', 'https://www.newegg.com/Computer-Systems/Store/ID-3', 'Improve your productivity and user experience by choosing a computer system \nthat meets your demands, from laptops and all-in-ones to desktops and ...', 33, 4),
(16, 'Computer History Museum', 'https://computerhistory.org/', 'Computers help us design safer cars, diagnose diseases, and battle Orcs. They \nmanage our business by day and entertain us at night. Smartphones can hail a ...', 25, 4),
(17, 'Computers', 'https://www.samsclub.com/c/computers/1116', 'Find computers and accessories at affordable prices from the biggest brands. \nSave on laptops, desktops, monitors, printers, and more every day at Sam\'s Club.', 127, 4),
(18, 'IEEE Computer Society', 'https://www.computer.org/', 'Trending from the Computer Society Digital Library. IEEE Security & Privacy. \nExposing Cookie Policy Flaws Through an Extensive Evaluation of Browsers and\n ...', 28, 4),
(19, 'Computers for Your Home | Staples', 'https://www.staples.com/Laptops-Computers/cat_SC3', 'Shop Computers at Staples. Choose from our wide selection of laptops, desktops\n, notebooks & ultrabooks and get fast & free shipping on select orders.', 193, 4),
(20, 'This object-recognition dataset stumped the world\'s best computer ...', 'http://news.mit.edu/2019/object-recognition-dataset-stumped-worlds-best-computer-vision-models-1210', '1 day ago ... Computer vision models have learned to identify objects in photos so accurately \nthat some can outperform humans on some datasets.', 34, 4),
(21, 'Computer Science For All | whitehouse.gov', 'https://obamawhitehouse.archives.gov/blog/2016/01/30/computer-science-all', 'Jan 30, 2016 ... Computer Science for All is the President\'s bold new initiative to empower all \nAmerican students from kindergarten through high school to learn ...', 58, 4),
(22, 'We are the Human-Computer Interaction Institute at Carnegie ...', 'https://www.hcii.cmu.edu/', 'The Human-Computer Interaction Institute in the Carnegie Mellon University \nSchool of Computer Science is currently hiring faculty for all tracks to start in Fall\n ...', 12, 4),
(23, 'Computers.Woot', 'https://www.woot.com/category/computers', 'Apple iPad Pro (2018) 12.9\" Tablets. 6 hours left to buy. Deal of the Day. $. 349. \n99. Dell 5570 15.6\" FHD Intel 256GB Laptops. 6 hours left to buy. $. 39. 99.', 16, 4),
(24, 'What Not to Do on Your Work Computer - The New York Times', 'https://www.nytimes.com/2019/12/05/smarter-living/wirecutter/what-not-to-do-on-your-work-computer.html', '6 days ago ... If you use a work-issued laptop or desktop computer, you\'ve likely been tempted \nto check your personal email, store private files on the ...', 72, 4),
(25, 'Best Computer Reviews – Consumer Reports', 'https://www.consumerreports.org/cro/computers.htm', 'Looking for the best computer? Consumer Reports has honest ratings and \nreviews on computers from the unbiased experts you can trust.', 40, 4),
(26, 'Computer | HowStuffWorks', 'https://computer.howstuffworks.com/', 'HowStuffWorks Computer gets you explanations, reviews, opinions and prices for \nthe Internet, home networking, hardware, and software.', 36, 4),
(27, 'Informatique — Wikipédia', 'https://fr.wikipedia.org/wiki/Informatique', 'L\'informatique est un domaine d\'activité scientifique, technique et industriel \nconcernant le traitement automatique de l\'information par l\'exécution de ...', 241, 6),
(28, 'Définitions : informatique - Dictionnaire de français Larousse', 'https://www.larousse.fr/dictionnaires/francais/informatique/42996', 'informatique - Définitions Français : Retrouvez la définition de informatique... - \nDictionnaire, définitions, section_expression, conjugaison, synonymes, ...', 25, 6),
(29, 'Informatique : achat / vente Informatique sur LDLC.com', 'https://www.ldlc.com/informatique/cint3063/', 'Achat Informatique sur LDLC.com, n°1 du high-tech, élu Service Client de l\'\nAnnée. Comparez et achetez votre Informatique en livraison rapide à domicile ou \nen ...', 19, 6),
(30, 'Master Informatique', 'http://univ-amu.fr/master/Informatique', 'Domaine : Sciences et Technologies; Composante : Faculté des Sciences; \nNombre de crédits : 120; Code : ME5SIN; Frais d\'inscription : 243 €; Plaquette de \nla ...', 35, 6),
(31, 'Axen Informatique', 'http://www.axen-informatique.fr/', 'Axen Informatique propose des solutions de réseaux d\'entreprises. De l\'achat, à l\'\ninstallation en passant par la maintenance, que ce soit par télémaintenance ...', 15, 6),
(32, 'Informatique | Université Paris-Saclay', 'https://www.universite-paris-saclay.fr/fr/formation/master/informatique', 'L\'objectif de la mention informatique est de former des professionnels (de l\'\nindustrie ou de la recherche) maitrisant les fondements théoriques de l\'\ninformatique, ...', 32, 6),
(33, 'CISM Gestion Informatique - Votre fournisseur informatique à Montréal', 'https://cismdomain.com/', 'Depuis 20 ans, CISM offre des services informatique aux PME de Montréal \npossédant ou non un département informatique au sein de leur organisation.', 18, 6),
(34, 'informatique — Wiktionnaire', 'https://fr.wiktionary.org/wiki/informatique', 'Mot forgé par Philippe Dreyfus ; avalisé par Charles de Gaulle qui, lors d\'un \nConseil des ministres, trancha entre informatique et ordinatique. L\'allemand ...', 51, 6),
(35, 'INFORMATIQUE : Définition de INFORMATIQUE', 'https://www.cnrtl.fr/definition/informatique', 'Informatique documentaire, médicale; informatique de gestion. L\'électronique \nmise au service de l\'information, ce qu\'on appelle dans ce cas informatique (E.', 26, 6),
(36, 'AIKI informatique', 'https://www.aikitech.ca/', 'Nous offrons aux PME des services de soutien technique, d\'impartition, de \nconception de logiciels et de sites Web, ainsi que l\'installation d\'environnements\n ...', 16, 6),
(37, 'Informatique : Définition simple et facile du dictionnaire', 'https://www.linternaute.fr/dictionnaire/fr/definition/informatique/', 'Fraude informatique Sens : Piratage d\'un système informatique dans le but de s\'\nemparer de données confidentielles ou de s\'enrichir. Origine : Les premières ...', 31, 6),
(38, 'Téléchargez des cours d\'informatique gratuits', 'https://www.doc-etudiant.fr/Informatique/', 'Vous trouvez des cours d\'informatique pour tous les niveaux, de débutant à \nexpérimenté. Chacun de ces cours se trouvent en téléchargement gratuit et vous\n ...', 83, 6),
(39, 'Création site Internet Suisse Valais Vaud, graphisme, informatique ...', 'https://www.gxc-informatique.ch/fr/', 'Création de site internet, refonte de site internet, relookage de site internet, \nGraphisme, Dépannage informatique, SEO, référencement optimisé pour le \nmoteurs ...', 11, 6),
(40, 'Diplôme d\'ingénieur(e) en informatique | UTBM (Université de ...', 'https://www.utbm.fr/formations/ingenieur/informatique/', 'Une demande accrue de compétences informatiques dans tous les secteurs. Les \nentreprises industrielles et tertiaires recrutent nos ingénieurs pour leurs ...', 17, 6),
(41, 'Règlement de la communauté YouTube - Aide YouTube', 'https://support.google.com/youtube/answer/9288567?hl=fr', 'Utiliser YouTube, c\'est rejoindre une communauté de personnes venant du \nmonde entier. Nous vous demandons de respecter les consignes ci-dessous \npour ...', 34, 7),
(42, 'Sur YouTube, il fait librement de la pub pour le cannabis vendu à ...', 'https://www.lavoixdunord.fr/678523/article/2019-12-10/sur-youtube-il-fait-librement-de-la-pub-pour-le-cannabis-vendu-lille-sud', 'il y a 1 jour ... Dans une vidéo vue plus de 140 000 fois sur Internet, un youtuber présente, à \nvisage découvert, un lieu de deal de cannabis à Lille-Sud et fait ...', 11, 7),
(43, 'Règles de confidentialité – Règles de confidentialité et conditions d ...', 'https://policies.google.com/privacy?hl=fr', '25 mars 2003 ... Des applications, des sites et des appareils Google, tels que la recherche \nGoogle, YouTube et Google Home; Des plates-formes, telles que le ...', 20, 7),
(44, 'Créer une chaîne - Aide YouTube', 'https://support.google.com/youtube/answer/1646861?hl=fr', 'Avec un compte Google, vous pouvez regarder des vidéos, cliquer sur \"J\'aime\" et \nvous abonner à des chaînes. Cependant, sans chaîne YouTube, vous ne ...', 31, 7),
(45, 'Définition | YouTube | Futura Tech', 'https://www.futura-sciences.com/tech/definitions/internet-youtube-16495/', 'YouTube est un service en ligne d\'hébergement et de diffusion de vidéos en \nstreaming qui intègre des fonctionnalités sociales de partage et de commentaires\n ...', 34, 7),
(46, 'Convertisseur YouTube MP3 et MP4 en ligne gratuit', 'https://www.mp3hub.com/fr2', 'Convertisseur vidéo pour télécharger des vidéos en MP3 et MP4 depuis \nYouTube, Facebook, Twitter, Instagram, Vk, Dailymotion, Soundcloud, Vimeo et \nplus ...', 13, 7),
(47, 'Convertisseur Youtube mp3 pour télécharger une vidéo Youtube', 'https://youzik.com/fr2', 'Youzik, c\'est le site web de référence pour convertir et télécharger des vidéos \nYoutube au format mp3, c\'est le service de téléchargement mp3 le plus rapide du\n ...', 14, 7),
(48, 'Convertisseur Youtube en mp3 en ligne - PointMp3', 'https://www.pointmp3.com/french', 'Commençons, devrions-nous? C\'est très simple, vraiment. Vous pouvez convertir \ndes vidéos YouTube au format mp3 instantanément sans avoir le souci de ...', 20, 7),
(49, 'Convertisseur YouTube, convertir une vidéo de YouTube en MP4', 'https://keepvid.pro/fr1/youtube-converter-free', 'Free YouTube Video Converter fournit un service de conversation vidéo en ligne \ntotalement gratuit qui vous permet de télécharger et de convertir des vidéos ...', 38, 7),
(50, 'Télécharger Video YouTube - télécharger des vidéos en ligne gratuit', 'https://fr.savefrom.net/1-comment-t%C3%A9l%C3%A9charger-une-vid%C3%A9o-youtube.html', 'SaveFrom.net présente les méthodes de téléchargement de vidéos YouTube les \nplus rapides et dans la qualité la plus élevée.', 25, 7),
(51, 'Liste des vidéos les plus visionnées sur YouTube — Wikipédia', 'https://fr.wikipedia.org/wiki/Liste_des_vid%C3%A9os_les_plus_visionn%C3%A9es_sur_YouTube', 'Cet article est la liste de vidéos les plus vues sur la plate-forme d\'hébergement \nde vidéos en ligne YouTube. Sommaire. 1 Historique; 2 Liste; 3 Références ...', 35, 7),
(52, 'Télécharger TubeMate Youtube Downloader (gratuit) - Comment Ça ...', 'https://www.commentcamarche.net/download/telecharger-34097958-tubemate-youtube-downloader', 'TubeMate YouTube Downloader est une application pour smartphones et \ntablettes Android permettant de télécharger en local les vidéos diffusées par \nYouTube ...', 31, 7),
(53, 'Youtube lance une vraie offre de VOD - Capital.fr', 'https://www.capital.fr/entreprises-marches/youtube-lance-une-vraie-offre-de-vod-597374', '10 mai 2011 ... Après des mois de négociations, Youtube a enfin trouvé un accord avec les \nstudios d\'Hollywood. Le site de vidéos en ligne va ajouter 3.000 ...', 16, 7),
(54, 'Plus d\'un milliard de vidéos regardées chaque jour sur Youtube ...', 'https://www.capital.fr/economie-politique/plus-d-un-milliard-de-videos-regardees-chaque-jour-sur-youtube-441526', '12 oct. 2009 ... Le site internet Youtube recense plus d\'un milliard de vidéos regardées par jour, \na annoncé son patron, Chad Hurley, sur le blog du groupe.', 13, 7),
(55, 'Piratage : YouTube et Viacom règlent leurs comptes | ITespresso.fr', 'https://www.itespresso.fr/piratage-youtube-et-viacom-reglent-leurs-comptes-34284.html', '22 mars 2010 ... Viacom accuse les fondateurs de YouTube d\'avoir encouragé la publication de \nvidéos protégées par le droit d\'auteur sur son site, tandis que la ...', 12, 7),
(56, 'YouTube lance enfin son nouveau service de streaming musical ...', 'https://www.lesechos.fr/2018/05/youtube-lance-enfin-son-nouveau-service-de-streaming-musical-972608', '18 mai 2018 ... On prend les mêmes et on recommence. Bien décidé à se faire une place sur le \njuteux marché du streaming musical, YouTube a annoncé ...', 12, 7),
(57, 'YouTube: Cinq ans et un record', 'https://www.lejdd.fr/Medias/Internet/YouTube-Cinq-ans-et-un-record-194016-3268727', '18 mai 2010 ... Cinq ans après le lancement de sa première vidéo sur la toile, le site de partage \nde vidéos YouTube annonce que ses contenus sont regardés ...', 12, 7),
(58, 'YouTube.com : vidéos, musique - YouTube en français', 'https://www.webrankinfo.com/google/youtube.htm', 'Pour consulter le site YouTube en français, allez sur youtube.fr ou bien sur \nyoutube.com et sélectionnez la langue et le pays (vous trouverez les liens en bas \nde ...', 413, 7),
(59, 'YouTube MP3 - Convertisseur YouTube en MP3 et MP4', 'https://www.dlnowsoft.com/fr/youtube-mp3', 'Télécharger vos musiques en MP3 directement depuis les vidéos YouTube. \nNotre convertisseur MP3 est 100% gratuit, sans installation ni inscription.', 14, 7),
(60, 'YouTube fait la chasse à la tricherie scolaire', 'https://www.franceinter.fr/emissions/l-edito-m/l-edito-m-09-mai-2018', '9 mai 2018 ... YouTube est intervenu après l\'enquête. Que révélait celle-ci ? Que des centaines \nde comptes de Youtubeurs – équivalents de nos \"Norman\" ...', 14, 7),
(61, 'Youtube 14.43.55 pour Android - Télécharger', 'https://youtube.fr.uptodown.com/android', 'Voici l\'application officielle pour Android YouTube, le portail numéro un pour la \ndiffusion vidéo en continu. Elle vous permettra d\'accéder à toutes les vidéos ...', 23, 7),
(62, 'Chiffres clés sur YouTube 2019 : ahurissants ! nb de vidéos vues ...', 'https://www.webrankinfo.com/dossiers/youtube/chiffres-statistiques', '8 juil. 2019 ... Plein de chiffres incroyables et de stats sur YouTube ainsi qu\'un résumé \nchronologique de la plus grande plateforme de vidéos au monde.', 131, 7),
(63, 'Master Informatique des Systèmes Embarqués - Université Paris 8', 'https://www.univ-paris8.fr/-Master-Informatique-des-Systemes-Embarques-', 'Domaine : Sciences, Technologies, Santé Mention : Informatique Parcours :  Informatique des Systèmes Embarqués (ISE) Conduite de Projets Informatiques ...', 25, 6),
(64, 'Achat informatique : Équipez-vous à petit prix | High-Tech E.Leclerc', 'https://www.hightech.leclerc/informatique-tablette-u', 'Question informatique, nous en connaissons un rayon ! Ordinateurs portables, de  bureau, tablettes, souris, accessoires gamer… nous avons pensé à tout avec ...', 11, 6),
(65, 'Techniques de l\'informatique : programmeur-analyste - Cégep de ...', 'https://www.cegepshawinigan.ca/futurs-etudiants/programmes-detudes/programmes-techniques/techniques-de-linformatique/', 'Nous vous souhaitons la bienvenue au Cégep de Shawinigan, un établissement  d\'enseignement supérieur de qualité supérieure! La fierté et le sentiment ...', 14, 6),
(66, 'Gentil Geek - Dépannage & Assistance Informatique à Domicile', 'https://gentilgeek.fr/', 'Vous avez un problème informatique ? Nos experts interviennent 7J/7. Prix fixe et  transparent de 79 €. Vous êtes dépanné ou non facturé !', 21, 6),
(67, 'GDG Informatique et Gestion', 'https://www.gdginc.com/', 'Au-delà de l\'informatique, il y a nos valeurs. GDG · Nouvelles · Carrières · Nous ...  Analyste de systèmes informatiques en intelligence d\'affaires sénior (2171) ...', 17, 6),
(68, 'Master d\'Informatique - SCIENCES', 'http://sciences.sorbonne-universite.fr/fr/formations/diplomes/sciences_et_technologies2/masters2/master_informatique_m1.html', 'La mention Informatique propose un enseignement scientifique et technique de  haut niveau destiné à former des informaticiens capables de s\'adapter à ...', 14, 6),
(69, 'Licence d\'informatique - SCIENCES', 'http://sciences.sorbonne-universite.fr/fr/formations/diplomes/sciences_et_technologies2/licences/licence_st_mention_informatique.html', 'L\'informatique s\'est insinuée dans bien des niveaux de notre quotidien. Ses  manifestations sont multiples, de notre sphère privée aux applications  industrielles ...', 22, 6),
(70, 'Informatique - Achat / Vente Informatique pas cher - Cdiscount', 'https://www.cdiscount.com/informatique/v-107-0.html', 'Profitez de prix ultra-préférentiels sur des milliers de références de matériel  informatique de grandes marques. Ce tout au long de l\'année comme à l\' occasion ...', 25, 6),
(71, 'Master : ingénieur civil en informatique', 'https://uclouvain.be/prog-info2m', 'Master [120] : ingénieur civil en informatique. info2m 2019-2020 Louvain-la- Neuve. A Louvain-la-Neuve - 120 crédits - 2 années - Horaire de jour - En  anglais.', 15, 6),
(72, 'Informatique Algerie', 'https://www.ouedkniss.com/informatique', 'Informatique. Ordinateurs portables , Laptop (Pc Portable) RAM : 2 GO Ecran : 15  pouces. Disque : 500 GO .intel. Bon état. Appeler apres 18h16000 DA ...', 63, 6),
(73, 'Licence Info - Présentation', 'https://www.fil.univ-lille1.fr/licence', '24 oct. 2019 ... La formation proposée par la licence d\'informatique de l\'Université Lille1 permet l \'apprentissage des aspects tant théoriques qu\'appliqués de ...', 11, 6),
(74, 'Abakom - vente et dépannage informatique à Ostwald', 'https://www.abakom-km-informatique.fr/', 'Découvrez les avis clients du vendeur de matériel informatique et système d\' encaissement Abakom, entreprise engagée dans la satisfaction de ses clients.', 20, 6),
(75, 'Informatique - Université de Bordeaux', 'https://www.u-bordeaux.fr/formation/PRLIIN_110/licence-informatique', 'Cette licence a pour objectif de préparer l\'accès aux masters informatique ou  méthodes informatiques appliquées à la gestion des entreprises (MIAGE), ...', 73, 6),
(76, 'Les formations de Cédric - Formation Informatique Avec Cedric', 'https://formation-informatique-avec-cedric.fr/formations-de-cedric/', '20 janv. 2019 ... Je vous offre mon savoir informatique car désormais toutes mes formations sont  gratuites. Vous avez bien lu…Toutes mes formations sont ...', 15, 6),
(77, 'DUT Informatique - Onisep', 'http://www.onisep.fr/Ressources/Univers-Formation/Formations/Post-bac/DUT-Informatique', 'Ce DUT forme des assistants ingénieurs et des chefs de projet en informatique  de gestion et en informatique industrielle. Immédiatement opérationnels en ...', 29, 6),
(78, 'Informatique | Polytech Marseille : Ecole d\'ingénieurs universitaire', 'https://polytech.univ-amu.fr/formations/cycle-ingenieur/informatique-reseau-multimedia', 'Présentation de la Filière d\'ingénieur en informatique réseaux et multimédia  Polytech Marseille (ex. ESIL Ecole Supérieure d\'ingénieurs de Luminy)', 15, 6),
(79, 'L\'informatique au service du bien-être collectif et du développement ...', 'https://www.unamur.be/info', 'La Faculté d\'Informatique a pour vision celle d\'un monde dans lequel l\'usage  intensif et croissant de l\'informatique est orienté vers le bien-être collectif et le ...', 16, 6),
(80, 'Livres du rayon Informatique - Librairie Eyrolles', 'https://www.eyrolles.com/Informatique/', 'Librairie Eyrolles, livres informatiques et nouvelles technologies (langages de  programmation, réseaux, graphisme et multimédia) vente de livres bureautique, ...', 17, 6),
(81, 'Boutique Informatique Tunisie, vente Pc portable , Tablette ...', 'https://www.mytek.tn/3-informatique', 'Boutique informatique en Tunisie, Achetez votre pc portable HP, DELL, Lenovo,  ASUS, ordinateur de bureau, tablette au meilleur prix chez Mytek.', 11, 6),
(82, 'DUT Informatique - IUT Nancy-Charlemagne', 'https://iut-charlemagne.univ-lorraine.fr/informatique/dut-informatique/', 'Le DUT informatique forme des informaticiens généralistes de niveau bac +2  possédant une solide formation théorique et pratique, qui leur permet de s\' adapter ...', 41, 6),
(83, 'Comment renforcer la sécurité informatique des pouvoirs publics ...', 'https://www.vie-publique.fr/en-bref/272026-comment-renforcer-la-securite-informatique-des-pouvoirs-publics', '28 nov. 2019 ... Quelles mesures pour renforcer la sécurité informatique des pouvoirs publics ?  Société. Parce qu\'ils sont au cœur des enjeux stratégiques et ...', 15, 6),
(84, 'Baccalauréat en informatique', 'https://www.uqar.ca/etudes/etudier-a-l-uqar/programmes-d-etudes/7833', 'Présentation. Le baccalauréat en informatique vise la formation des spécialistes  qui œuvreront dans des entreprises qui utilisent l\'informatique dans leurs ...', 63, 6),
(85, 'Bachelor Informatique & systèmes de communication - Fribourg ...', 'http://www.heia-fr.ch/fr/formation/bachelor/informatique-et-systemes-de-communication/', 'Devenir ingénieur-e en informatique et systèmes de communication à Fribourg.', 26, 6),
(86, 'Informatique Education', 'http://web.informatique-edu.com/', 'Informatique Education Products. We believe that our continuous evaluation of  our products, will ensure meeting the customers\' requirements ...', 17, 1),
(87, 'informatique | translate French to English: Cambridge Dictionary', 'https://dictionary.cambridge.org/dictionary/french-english/informatique', 'Dec 18, 2019 ... informatique translate: computing, IT, computer, computing, information  technology, IT. Learn more in the Cambridge French-English ...', 13, 1),
(88, 'Boîtier (informatique) — Wikipédia', 'https://fr.wikipedia.org/wiki/Bo%C3%AEtier_(informatique)', 'En informatique, le boîtier de l\'unité centrale protège les principaux composants  d\'un appareil informatique (poste, système embarqué) composé d\'un ou ...', 11, 1),
(89, 'Mannai Corporation announces the squeeze-out of Gfi ...', 'https://mannai.com/news/mannai-corporation-announces-the-squeeze-out-of-gfi-informatiques-shares-following-the-results-of-the-buy-out-offer/', 'Dec 13, 2018 ... Following today\'s notice published by the Autorité des marchés financiers (AMF)  on the results of the buy-out offer for Gfi Informatique\'s shares ...', 15, 1),
(90, 'Computer Science - Informatique (Swansea), MSc - Swansea ...', 'https://www.swansea.ac.uk/postgraduate/taught/science/computer-science/msc-computer-science-informatique/', 'Discover our MSc Informatique (Swansea route) Science at Swansea University  and join our welcoming Computer Science department.', 12, 1),
(91, 'équipement informatique - English translation – Linguee', 'https://www.linguee.com/french-english/translation/%C3%A9quipement+informatique.html', 'Many translated example sentences containing \"équipement informatique\" –  English-French dictionary and search engine for English translations.', 35, 1),
(92, 'Informatique - Cégep de la Gaspésie et des Iles', 'https://www.cegepgim.ca/futurs-etudiants/programmes/74-gaspe/technique/69-informatique', 'Que ce soit par l\'élaboration de jeux vidéos, l\'expérimentation des pratiques de  cybersécurité ou le déploiement d\'un réseau informatique, ce programme ...', 11, 1),
(93, 'Maîtrise en informatique - Université de Montréal', 'https://admission.umontreal.ca/programmes/maitrise-en-informatique/', 'Objectifs. Les études au niveau de la maîtrise visent une spécialisation dans un  domaine de l\'informatique au moyen de cours avancés. Elles ont pour but ...', 16, 1),
(94, 'strategic acquistion by subsidiary Malta Informatique of ICT Group', 'https://www.globenewswire.com/news-release/2019/10/08/1926194/0/en/Pharmagest-Interactive-strategic-acquistion-by-subsidiary-Malta-Informatique-of-ICT-Group.html', 'Oct 8, 2019 ... Villers-les-Nancy, 8 October 2019 – 7:00 a.m. (CET)Press release MALTA  INFORMATIQUE expands the coverage of its services to community ...', 24, 1),
(95, 'Unité de formation d\'informatique - Université de Bordeaux', 'https://www.u-bordeaux.fr/Formation/Composantes-de-formation/College-Sciences-et-technologies/Unite-de-formation-d-informatique', '12 déc. 2013 ... L\'unité de formation en informatique de l\'université Bordeaux rassemble environ  70 enseignants-chercheurs tous issus du LaBRI (Laboratoire ...', 18, 1),
(96, 'Département d\'informatique - Université de Sherbrooke', 'https://www.usherbrooke.ca/informatique/', 'Nouvelle embauche au Département d\'informatique. Martin Vallières, nouveau  titulaire d\'une chaire en intelligence artificielle de CIFAR · 9 décembre 2019.', 24, 1);

-- --------------------------------------------------------

--
-- Table structure for table `search_search`
--

CREATE TABLE `search_search` (
  `id` int(11) NOT NULL,
  `search_term` varchar(255) NOT NULL,
  `lang` varchar(10) NOT NULL,
  `frequency` int(11) NOT NULL,
  `extended_search` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `search_search`
--

INSERT INTO `search_search` (`id`, `search_term`, `lang`, `frequency`, `extended_search`) VALUES
(1, 'informatique', 'lang_en', 15, 0),
(2, 'information', 'lang_en', 13, 0),
(3, 'stupid', 'lang_en', 4, 0),
(4, 'computer', 'lang_en', 21, 0),
(6, 'informatique', 'lang_fr', 17, 1),
(7, 'youtube', 'lang_fr', 23, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `search_blockedsite`
--
ALTER TABLE `search_blockedsite`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `search_result`
--
ALTER TABLE `search_result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `search_result_search_word_id_9b9a9698_fk_search_search_id` (`search_word_id`);

--
-- Indexes for table `search_search`
--
ALTER TABLE `search_search`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `search_blockedsite`
--
ALTER TABLE `search_blockedsite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `search_result`
--
ALTER TABLE `search_result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;
--
-- AUTO_INCREMENT for table `search_search`
--
ALTER TABLE `search_search`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `search_result`
--
ALTER TABLE `search_result`
  ADD CONSTRAINT `search_result_search_word_id_9b9a9698_fk_search_search_id` FOREIGN KEY (`search_word_id`) REFERENCES `search_search` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
