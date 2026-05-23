-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 22/05/2026 às 22:03
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `pin2026`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `instituicoes`
--

CREATE TABLE `instituicoes` (
  `id` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `localizacao` varchar(255) NOT NULL,
  `lat` decimal(10,8) NOT NULL,
  `lng` decimal(11,8) NOT NULL,
  `especialidades` text DEFAULT NULL,
  `horario_atendimento` varchar(100) DEFAULT NULL,
  `contato` varchar(100) DEFAULT NULL,
  `detalhes` text DEFAULT NULL,
  `atualizado_em` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `url_imagem` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `instituicoes`
--

INSERT INTO `instituicoes` (`id`, `nome`, `localizacao`, `lat`, `lng`, `especialidades`, `horario_atendimento`, `contato`, `detalhes`, `atualizado_em`, `url_imagem`) VALUES
(33, 'UPA Piracicamirim', 'Rua Rio Grande do Norte, 135', -22.73933500, -47.62728400, 'Urgência e Emergência', '24 horas', '3426-4973 / 3411-3100 / 3426-5973', 'Unidade de nível secundário com classificação de risco.', '2026-05-22 19:47:32', NULL),
(34, 'UPA Vila Cristina', 'Rua Dona Anésia, 950 ', -22.73428400, -47.64807100, 'Urgência e Emergência', '24 horas', '3434-2296 / 3434-9356 / 3402-6520', 'Unidade de nível secundário com classificação de risco.', '2026-05-22 19:48:33', NULL),
(35, 'UPA Vila Sônia', 'Rua Brigadeiro Eduardo Gomes, 106', -22.69550000, -47.63910000, 'Urgência e Emergência', '24 horas', '3415-1450 / 3425-3284 / 3425-3598', 'Unidade de nível secundário com classificação de risco.', '2026-05-22 19:47:32', NULL),
(36, 'UPA Vila Rezende', 'Avenida Conceição, 350', -22.70439300, -47.65867900, 'Urgência e Emergência', '24 horas', '3421-1439 / 3421-0676', 'Unidade de nível secundário com classificação de risco.', '2026-05-22 19:47:32', NULL),
(37, 'UBS Algodoal', 'Rua Gertrudes Barbosa Moretti, 81', -22.71182300, -47.66113400, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3421-1253', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(38, 'UBS Alvorada', 'Rua Sérgio Cardoso, 185', -22.74834200, -47.66318500, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3426-4647', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(39, 'UBS Parque Piracicaba/ Balbo', 'Rua Palmital, s/nº', -22.66210400, -47.64382500, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-1143 / 3415-4283', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(40, 'UBS Caxambu', 'Rua Engº Romano Coury, 513', -22.74751200, -47.61634200, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3411-3409 / 3411-4903', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(41, 'UBS Centro', 'Av. França, 227', -22.72145000, -47.64183000, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-6872', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(42, 'UBS Esplanada', 'Rua Augusto Furlan, 31', -22.75382000, -47.63612500, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-5073', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(43, 'UBS Independência', 'Rua Pedro Chiarini, 144', -22.74011800, -47.63721000, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3433-0148', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(44, 'UBS Jupiá', 'Rua João Eudóxio da Silva, s/nº', -22.71543000, -47.67614000, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3427-2933', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(45, 'UBS Pauliceia/Coreia', 'Rua Santa Helena, 334', -22.74108500, -47.65342100, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-0882', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(46, 'UBS Jd. Planalto', 'Rua Herculano Mônaco, 180', -22.75932000, -47.65681000, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3433-7678', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(47, 'UBS Tanquinho', 'Centro Rural de Tanquinho', -22.58521000, -47.62593000, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3431-1115', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(48, 'UBS Cecap', 'Av. Gustavo Adolfo Franco Bueno, s/n', -22.73041200, -47.59425000, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3414-1466', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(49, 'UBS Novo Horizonte', 'Rua Moacir Martins, 255', -22.74815400, -47.58914200, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-9655', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(50, 'UBS Paulista', 'Rua Basílio Machado, 2403', -22.73318000, -47.64024500, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-3135', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(51, 'UBS Piracicamirim', 'Rua Gonçalves Dias, 1070', -22.73812500, -47.62584100, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3426-1830 / 3411-2020', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(52, 'UBS Santa Terezinha', 'Rua Nicolau Zem, 220', -22.68412000, -47.64619000, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-2484 / 3425-7209', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(53, 'UBS Vila Cristina', 'Av. Raposo Tavares, 1851', -22.73852000, -47.65301200, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-4529', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(54, 'UBS Vila Rezende', 'Rua Santo Estevão, 394', -22.71035000, -47.65184000, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3421-8924 / 3413-5635', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(55, 'UBS Vila Sônia', 'Rua João Zem, 751', -22.68931200, -47.63614500, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-7450', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-05-22 19:51:44', NULL),
(56, 'USF 1º de Maio', 'Rua João Tedesco, 413', -22.74411200, -47.61102500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3411-1883', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(57, 'USF Algodoal', 'Rua Vitório Laerte Furlan, 947', -22.70815400, -47.66241000, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-4671', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(58, 'USF Anhumas', 'Rod. Luis Dias Gonzaga, 11, km 25', -22.90124500, -47.69812500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3438-4205', 'Unidade de Saúde da Família - Zona Rural.', '2026-05-22 19:55:28', NULL),
(59, 'USF Artemis I e II', 'Rua José Ferreira Filho, 1360 - Centro (Artemis)', -22.67384100, -47.77124200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3438-1211 / 3438-3107', 'Unidade de Saúde da Família - Distrito de Artemis.', '2026-05-22 19:55:28', NULL),
(60, 'USF Astúrias', 'Rua Sgto José Carlos Rodrigues, 498', -22.75912400, -47.61814500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3428-9919', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(61, 'USF Boa Esperança I', 'Rua Corcovado, 2.030', -22.68412500, -47.65314200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3415-3342', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(62, 'USF Boa Esperança II', 'Rua Cupuaçu, 340', -22.68102400, -47.65684100, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-5967', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(63, 'USF Bosque dos Lenheiros I', 'Rua das Seringueiras, 33', -22.68612400, -47.66914500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-3449', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(64, 'USF Bosque dos Lenheiros II', 'Rua Pau-Brasil, 326', -22.68314500, -47.66751200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-7200', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(65, 'USF Campestre', 'Av. Laranjal Paulista, 4.100', -22.76915200, -47.59812400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3426-0060', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(66, 'USF Cecap', 'Alameda Melvin Jones, 55', -22.73312400, -47.59614200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3424-2092', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(67, 'USF Chapadão I', 'Rua das Gralhas, 120', -22.69512400, -47.61814200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3424-3483', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(68, 'USF Chapadão II / Sol Nascente', 'Rua Embuguaçú, 71', -22.69812400, -47.62015400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3411-1578', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(69, 'USF Costa Rica', 'Rua Sofia, 80', -22.75124100, -47.59914200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3426-1714', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(70, 'USF Eldorado I', 'Av. Gustavo Adolfo Franco Bueno, s/n', -22.72912400, -47.59124500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3414-2734', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(71, 'USF Gran Park', 'Avenida Elias Gabriel da Silva, s/nº', -22.76814200, -47.58914500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '34151064', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(72, 'USF Eldorado II / Terra Rica', 'Rua Yolanda Pereira Delboux, nº 35', -22.72614200, -47.59318500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3424-2490', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(73, 'USF IAA I', 'Rua João Pedro Corrêa, 810', -22.67124500, -47.64312500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3415-1099', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(74, 'USF IAA II', 'Rua João Pedro Corrêa, 408', -22.67412500, -47.64518400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-3557', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(75, 'USF Ibitiruna', 'Rua Piracicaba, 10', -22.84124500, -47.81245000, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3438-4126', 'Unidade de Saúde da Família - Distrito de Ibitiruna.', '2026-05-22 19:55:28', NULL),
(76, 'USF Itapuã I', 'Rua Garça, 495', -22.75312400, -47.64912400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3432-5785', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(77, 'USF Itapuã II', 'Rua Cafelândia, 65 – Jd. Tóquio', -22.75614200, -47.65102400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-3732', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(78, 'USF Jaraguá I', 'Rua Prof. Mariano da Costa, 380', -22.73812400, -47.66215400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-9833', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(79, 'USF Jaraguá II', 'Rua Rafael Marques Cantinho, 441', -22.73614200, -47.66418500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3435-1686', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(80, 'USF Jardim das Flores / Minas Nova', 'Rua Izaltina Ferraz Ferreira Alves, 90', -22.75914200, -47.58612400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-1067', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(81, 'USF Jardim Gilda', 'Rua Mª de Lourdes F. Jacob, 130', -22.67912400, -47.66102500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-1569', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(82, 'USF Jardim Oriente', 'Avenida Luis Pereira Leite, s/nº', -22.76102400, -47.60124500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3411-2268', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(83, 'USF Jardim Primavera', 'Rua Cecílio Elias, s/nº', -22.69124500, -47.65914200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-0140', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(84, 'USF Jardim Vitória', 'Rua Av. Conchas, 550', -22.68412400, -47.63312400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3433-8196', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(85, 'USF Javari', 'Rua Caju, 61', -22.68912400, -47.62514200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-0223', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(86, 'USF Kobayat Líbano', 'Avenida Francisco Antonio Perin, 987', -22.75812400, -47.67102400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3402-7771', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(87, 'USF Mario Dedini I', 'Avenida Nadir Eraldo Stella, 137', -22.68712400, -47.61914200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3423-2006', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(88, 'USF Mario Dedini II', 'Rua Francisca Tegero Barbosa, 55', -22.68415400, -47.61614200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-3622', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(89, 'USF Monte Alegre', 'Via Comendador Pedro Morgante, 155', -22.74124500, -47.59312400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-9480', 'Unidade de Saúde da Família - Bairro Monte Alegre.', '2026-05-22 19:55:28', NULL),
(90, 'USF Monte Feliz', 'Rua Honduras, 124', -22.75124500, -47.61412500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '34288314', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(91, 'USF Monte Líbano I', 'Rua Caçapava, 255', -22.75012400, -47.62102500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-1755', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(92, 'USF Monte Líbano II', 'Rua Prof. Felinto de Brito, s/nº', -22.75314200, -47.62314500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-6817', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(93, 'USF Paineiras', 'Rua Eloy Costa Filho, 135', -22.67102400, -47.65914200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3435-4230', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(94, 'USF Parque Orlanda', 'Rua Trav. Sylvio Bruzantim, 53', -22.67412400, -47.63314500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-2088 / 7949', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(95, 'USF Santa Fé', 'Rua Profª. Laura F.de Campos Ferrari, nº 550', -22.76124500, -47.66914200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-5773', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(96, 'USF Santa Rita / Avencas', 'Rua Areiópolis, 250', -22.74812400, -47.57614200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3424-1776', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(97, 'USF Santa Rosa I', 'Rua José Jacir Moreti, 270', -22.70912400, -47.63102400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-7791', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(98, 'USF Santa Rosa II', 'Rua Milton Teixeira de Sá, 220', -22.70614200, -47.62914200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-2823', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(99, 'USF Santana', 'Rua São Jorge, s/nº', -22.78412400, -47.62142500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-0376', 'Unidade de Saúde da Família - Distrito de Santana/Santa Olímpia.', '2026-05-22 19:55:28', NULL),
(100, 'USF São Francisco', 'Rua Uchoa, 488', -22.71124500, -47.58914200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3424-1977', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(101, 'USF São Jorge', 'Rua Tambaú, 45', -22.74912400, -47.67612400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3423-2450', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(102, 'USF São José', 'Rua Demosthenes Santos Correia, 1233', -22.75312400, -47.67142500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3433-0414', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(103, 'USF Serra Verde', 'Rua Roberto Vaz dos Santos, 17', -22.76612400, -47.61914200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3428-1278', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(104, 'USF Tatuapé I', 'Rua Prof. Carlos Brasiliense Pinto, 405', -22.74102400, -47.66914500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3402-8926', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(105, 'USF Tatuapé II', 'Rua Godofredo Bulhões Ferreira Carvalho, 226', -22.74314200, -47.66712400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3433-4604', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(106, 'USF Tupi', 'Rua Piracicaba, s/n', -22.79124500, -47.53124500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3438-7185', 'Unidade de Saúde da Família - Distrito de Tupi.', '2026-05-22 19:55:28', NULL),
(107, 'USF Vem Viver', 'Rua Jacob Moschini, s/nº', -22.69812400, -47.59124200, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3415-1051', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(108, 'USF Vila Fátima', 'Rua João Alves de Almeida, 355', -22.71814200, -47.63312400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3421-8577', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL),
(109, 'USF Vila Industrial', 'Rua Cândido Portinari, 425', -22.72314200, -47.61814500, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-1851', 'Unidade de Saúde da Família - Atenção Básica.', '2026-05-22 19:55:28', NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `instituicoes`
--
ALTER TABLE `instituicoes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `instituicoes`
--
ALTER TABLE `instituicoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
