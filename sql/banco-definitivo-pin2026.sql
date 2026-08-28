-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11/06/2026 às 21:54
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.1.25

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
(33, 'UPA Piracicamirim', 'Rua Rio Grande do Norte, 135', -22.73941996, -47.62725644, 'Urgência e Emergência', 'Atendimento 24 horas', '3426-4973 / 3411-3100 / 3426-5973', 'Unidade de nível secundário com classificação de risco.', '2026-08-27 00:00:00', NULL),
(34, 'UPA Vila Cristina', 'Rua Dona Anésia, 950 – Jaraguá', -22.74121340, -47.66741519, 'Urgência e Emergência', 'Atendimento 24 horas', '3434-2296 / 3434-9356 / 3402-6520', 'Unidade de nível secundário com classificação de risco.', '2026-08-27 00:00:00', NULL),
(35, 'UPA Vila Sônia', 'Rua Brigadeiro Eduardo Gomes, 106', -22.67109363, -47.69317037, 'Urgência e Emergência', 'Atendimento 24 horas', '3415-1450 / 3425-3284 / 3425-3598', 'Unidade de nível secundário com classificação de risco.', '2026-08-27 00:00:00', NULL),
(36, 'UPA Vila Rezende', 'Avenida Conceição, 350', -22.70518758, -47.65695764, 'Urgência e Emergência', 'Atendimento 24 horas', '3421-1439 / 3421-0676', 'Unidade de nível secundário com classificação de risco.', '2026-08-27 00:00:00', NULL),
(37, 'UBS Algodoal', 'Rua Gertrudes Barbosa Moretti, 81', -22.69530317, -47.66662047, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3421-1253', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(38, 'UBS Alvorada', 'Rua Sérgio Cardoso, 185', -22.76043330, -47.61437300, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3426-4647', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(39, 'UBS Parque Piracicaba/ Balbo', 'Rua Palmital, s/nº', -22.67895908, -47.70354381, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-1143 / 3415-4283', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(40, 'UBS Caxambu', 'Rua Engenheiro Agrônomo Romano Coury, 513', -22.74909274, -47.63621219, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3411-3409 / 3411-4903', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(41, 'UBS Centro', 'Av. França, 227', -22.72068406, -47.64271851, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-6872', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(42, 'UBS Esplanada', 'Rua Augusto Furlan, 31', -22.74566288, -47.65488596, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-5073', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(43, 'UBS Independência', 'Travessa Olegário Mariano, 327 – Vila Monteiro', -22.72578111, -47.63221818, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3433-0148', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(44, 'UBS Jupiá', 'Rua João Eudóxio da Silva, s/nº', -22.70862016, -47.68479167, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3427-2933', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(45, 'UBS Pauliceia/Coreia', 'Rua Santa Helena, 334', -22.75082576, -47.64531043, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-0882', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(46, 'UBS Jd. Planalto', 'Rua Herculano Mônaco, 180', -22.74134526, -47.67221606, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3433-7678', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(47, 'UBS Tanquinho', 'Rua Américo Faganello, s/nº – Tanquinho', -22.56970010, -47.60744410, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3431-1115', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(48, 'UBS Cecap e USF Eldorado I', 'Av. Gustavo Adolfo Franco Bueno, s/nº – Eldorado I', -22.77409210, -47.59710709, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3414-1466', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(49, 'UBS Novo Horizonte', 'Rua Moacir Martins, 255', -22.76057460, -47.67571795, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-9655', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(50, 'UBS Paulista', 'Rua Basílio Machado, 2403', -22.73674776, -47.65567926, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-3135', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(51, 'UBS Piracicamirim', 'Rua Gonçalves Dias, 1070', -22.73823921, -47.62596204, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3426-1830 / 3411-2020', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(52, 'UBS Santa Terezinha', 'Rua Nicolau Zem, 220', -22.67952398, -47.68336984, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-2484 / 3425-7209', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(53, 'UBS Vila Cristina', 'Av. Raposo Tavares, 1851', -22.74481563, -47.66336928, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-4529', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(54, 'UBS Vila Rezende', 'Rua Santo Estevão, 394', -22.70885244, -47.65724670, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3421-8924 / 3413-5635', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(55, 'UBS Vila Sônia', 'Atendimento transferido para UBS Balbo (Rua Palmital, s/nº) durante reforma', -22.67895908, -47.70354381, 'Atenção Básica (Clínica Médica, Ginecologia, Pediatria, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-7450', 'Unidade Básica de Saúde da Atenção Básica do município de Piracicaba.', '2026-08-27 00:00:00', NULL),
(56, 'USF 1º de Maio', 'Rua Augusto Gomes da Silva, s/nº – Água Branca', -22.75425680, -47.63061659, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3411-1883', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(57, 'USF Algodoal', 'Rua Vitório Laerte Furlan, 947', -22.69335588, -47.66553991, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-4671', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(58, 'USF Anhumas', 'Rod. Luis Dias Gonzaga, 11, km 25', -22.83782628, -47.92395475, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3438-4205', 'Unidade de Saúde da Família - Zona Rural.', '2026-08-27 00:00:00', NULL),
(59, 'USF Artemis I e II', 'Av. Fioravante Cenedese, 881 – Ártemis', -22.68219574, -47.77327123, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3438-1211 / 3438-3107', 'Unidade de Saúde da Família - Distrito de Artemis.', '2026-08-27 00:00:00', NULL),
(60, 'USF Astúrias', 'Rua Sargento José Carlos Rodrigues, 498', -22.75730867, -47.62734158, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3428-9919', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(61, 'USF Boa Esperança I', 'Av. Corcovado, 2030 – Maria Cláudia', -22.67042520, -47.70079802, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3415-3342', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(62, 'USF Boa Esperança II', 'Rua Cupuaçu, 340', -22.67361961, -47.70480660, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-5967', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(63, 'USF Bosque dos Lenheiros I', 'Rua das Seringueiras, 33', -22.66813369, -47.65772746, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-3449', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(64, 'USF Bosque dos Lenheiros II', 'Rua Pau-Brasil, 326', -22.66902040, -47.66013929, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-7200', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(65, 'USF Campestre', 'Av. Laranjal Paulista, 4.100', -22.78479509, -47.67450182, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3426-0060', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(66, 'USF Cecap', 'Alameda Melvin Jones, 55', -22.77292940, -47.59579029, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3424-2092', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(67, 'USF Chapadão I', 'Rua das Gralhas, 120', -22.75729947, -47.60162025, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3424-3483', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(68, 'USF Chapadão II / Sol Nascente', 'Rua Embuguaçú, 71', -22.76037496, -47.61022999, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3411-1578', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(69, 'USF Costa Rica', 'Rua Sofia, 80', -22.76500553, -47.65505017, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3426-1714', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(71, 'USF Gran Park', 'Avenida Elias Gabriel da Silva, s/nº', -22.68328200, -47.72440637, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '34151064', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(72, 'USF Eldorado II / Terra Rica', 'Rua Yolanda Pereira Delboux, nº 35', -22.76947570, -47.60351294, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3424-2490', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(73, 'USF IAA I', 'Rua João Pedro Corrêa, 810', -22.66976932, -47.67557942, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3415-1099', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(74, 'USF IAA II', 'Rua João Pedro Corrêa, 408', -22.67249390, -47.67172730, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-3557', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(75, 'USF Ibitiruna', 'Rua Piracicaba, 10', -22.77470660, -47.96325950, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3438-4126', 'Unidade de Saúde da Família - Distrito de Ibitiruna.', '2026-08-27 00:00:00', NULL),
(76, 'USF Itapuã I', 'Rua Garça, 495', -22.75484403, -47.66493370, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3432-5785', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(77, 'USF Itapuã II', 'Rua Cafelândia, 88 – Jd. Tóquio', -22.75507676, -47.66024453, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-3732', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(78, 'USF Jaraguá I', 'Rua Prof. Mariano da Costa, 380', -22.73913980, -47.66820565, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-9833', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(79, 'USF Jaraguá II', 'Av. Nove de Julho, 863 – Jaraguá', -22.73374637, -47.66468981, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3435-1686', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(80, 'USF Jardim das Flores / Minas Nova', 'Rua Izaltina Ferraz Ferreira Alves, 90', -22.76033065, -47.65426341, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-1067', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(81, 'USF Jardim Gilda', 'Rua Maria de Lourdes F. Jacob, 130', -22.66343259, -47.65694408, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-1569', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(82, 'USF Jardim Oriente', 'Avenida Luis Pereira Leite, s/nº', -22.77201613, -47.62413469, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3411-2268', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(83, 'USF Jardim Primavera', 'Rua Cecílio Elias, s/nº', -22.69456637, -47.65345004, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-0140', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(84, 'USF Jardim Vitória', 'Av. Conchas, 550 – Jardim Vitória', -22.74988935, -47.68364797, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3433-8196', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(85, 'USF Javari', 'Rua Anízio Caetano da Silva, 345 – Monte Rey', -22.67008627, -47.71019944, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-0223', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(86, 'USF Kobayat Líbano', 'Av. Frei Francisco Antonio Perin, 987', -22.75536911, -47.67694834, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3402-7771', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(87, 'USF Mario Dedini I', 'Avenida Nadir Eraldo Stella, 137', -22.68056559, -47.66278457, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3423-2006', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(88, 'USF Mario Dedini II', 'Rua Francisca Tegero Barbosa, 55', -22.67459232, -47.65826475, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-3622', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(89, 'USF Monte Alegre', 'Via Comendador Pedro Morgante, 155', -22.71138769, -47.63064240, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-9480', 'Unidade de Saúde da Família - Bairro Monte Alegre.', '2026-08-27 00:00:00', NULL),
(90, 'USF Monte Feliz', 'Rua Honduras, 124', -22.77193669, -47.63431082, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '34288314', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(91, 'USF Monte Líbano I', 'Rua Caçapava, 255', -22.75568740, -47.65149011, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3434-1755', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(92, 'USF Monte Líbano II', 'Rua Prof. Felinto de Brito, 334 – Jardim São Paulo', -22.75266973, -47.65602525, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-6817', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(93, 'USF Paineiras', 'Rua Bofete, 40 – São Jorge', -22.74594395, -47.67987197, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3435-4230', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(94, 'USF Parque Orlanda', 'Rua Trav. Sylvio Bruzantim, 53', -22.66375637, -47.69170379, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-2088 / 7949', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(95, 'USF Santa Fé', 'Rua Profª. Laura F.de Campos Ferrari, nº 550', -22.76398027, -47.67646877, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3422-5773', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(96, 'USF Santa Rita / Avencas', 'Rua Areiópolis, 250', -22.76353242, -47.58998175, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3424-1776', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(97, 'USF Santa Rosa I', 'Rua José Jacir Moretti, 270', -22.68618811, -47.63603815, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-7791', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(98, 'USF Santa Rosa II', 'Rua Milton Teixeira de Sá, 220', -22.67996626, -47.63066417, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-2823', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(99, 'USF Santana', 'Rua São Paulo, 20', -22.62548880, -47.72972400, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3425-0376', 'Unidade de Saúde da Família - Distrito de Santana/Santa Olímpia.', '2026-08-28 00:00:00', NULL),
(100, 'USF São Francisco', 'Rua Uchoa, 488', -22.76875459, -47.59006836, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3424-1977', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(101, 'USF São Jorge', 'Rua Tambaú, 45', -22.66575190, -47.62408900, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3423-2450', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(102, 'USF São José', 'Rua Demosthenes Santos Correia, 1233', -22.74362807, -47.66798229, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3433-0414', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(103, 'USF Serra Verde', 'Rua Roberto Vaz dos Santos, 17', -22.76380738, -47.62187358, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3428-1278', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(104, 'USF Tatuapé I', 'Rua Prof. Carlos Brasiliense Pinto, 405', -22.75039409, -47.66108110, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3402-8926', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(105, 'USF Tatuapé II', 'Rua Godofredo Bulhões Ferreira Carvalho, 226', -22.74877124, -47.66205430, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3433-4604', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(106, 'USF Tupi', 'Rua Piracicaba, s/n', -22.74286252, -47.52657214, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3438-7185', 'Unidade de Saúde da Família - Distrito de Tupi.', '2026-08-27 00:00:00', NULL),
(107, 'USF Vem Viver', 'Rua Jacob Moschini, s/nº', -22.66569391, -47.70745787, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3415-1051', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(108, 'USF Vila Fátima', 'Rua João Alves de Almeida, 355', -22.69108580, -47.65714010, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3421-8577', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(109, 'USF Vila Industrial', 'Rua Cândido Portinari, 425', -22.67923715, -47.66684877, 'Saúde da Família (Médico Generalista, Enfermagem, Agentes Comunitários, Odontologia)', 'Segunda a sexta-feira, das 7h às 16h', '3413-1851', 'Unidade de Saúde da Família - Atenção Básica.', '2026-08-27 00:00:00', NULL),
(110, 'Central de Ortopedia e Traumatologia (COT)', 'Rua Luis de Camões, 3000 ', -22.73328809, -47.62923187, 'Traumas Ortopédicos, Urgências e Emergências Ortopédicas', '24 horas', '(19) 3434-0324 / 3434-7823', 'Pronto-socorro específico com garantia de atendimento ortopédico imediato para pacientes do SUS.', '2026-08-28 00:00:00', 'img/ChatGPT Image 28 de ago. de 2026, 14_09_48 (2).png'),
(111, 'Serviço de Atendimento Móvel de Urgência (SAMU)', 'Av. Dr. Paulo de Moraes, 2000 – Paulista', -22.73718705, -47.65160590, 'Atendimento Pré-Hospitalar Móvel de Urgência e Emergência (Clínica, Cirúrgica, Traumática, Obstétrica, Pediátrica e Psiquiátrica)', '24 horas', '192', 'Serviço móvel regulado com o objetivo de prestar socorro rápido à vítima após ocorrências de urgência ou emergência.', '2026-08-27 00:00:00', NULL),
(112, 'Serviço de Urgência Bucal (SUB)', 'Av. Independência, 2600/2626 – Centro', -22.72675794, -47.63438610, 'Urgência Odontológica, Alívio Imediato da Dor, Traumas e Acidentes Bucais', 'Segunda a sexta das 7h às 21h; Sábados, domingos e feriados das 8h às 16h', '(19) 3402-2328', 'Serviço de atenção em saúde bucal focado no pronto atendimento de intercorrências odontológicas e traumas.', '2026-08-27 00:00:00', NULL),
(113, 'Policlínica Dr. Antônio Haddad Dib - Santa Teresinha e Farmácia Vila Sônia', 'Rua Dino Bueno, 565 – Vila Sônia', -22.67106619, -47.69294275, 'Cirurgia Plástica, Pequenas Cirurgias, Geriatria, Pneumologia Infantil, Cardiologia Pediátrica, Reumatologia Infantil, Espirometria, Eletroencefalograma, Endoscopia e Colonoscopia', 'Segunda a sexta-feira, das 7h às 17h', '3425-3712 / 3425-3782', 'Unidade de especialidades cirúrgicas, ambulatoriais, exames especializados, além do Núcleo do Idoso (NASI Norte) e Pediatria.', '2026-08-27 00:00:00', NULL),
(114, 'Centro Especializado em Saúde da Mulher (CESM) e Centro de Atenção a Saúde do Adolescente de Piracicaba (CASAP)', 'Rua Santa Cruz, 2043 – Paulista', -22.73605746, -47.64950745, 'Mastologia, Ginecologia, Rastreio de Câncer, Planejamento Familiar e Exames Ginecológicos', 'Segunda a sexta-feira, das 7h às 16h', '3434-6966 / 3402-9202', 'Centro especializado no atendimento e prevenção da saúde feminina.', '2026-08-28 00:00:00', 'img/ChatGPT Image 28 de ago. de 2026, 14_09_48 (1).png'),
(116, 'Centro de Atenção às Doenças Metabólicas (CADME)', 'Travessa Prof. Newton de Almeida Mello, s/n – Centro', -22.72845245, -47.65002163, 'Endocrinologia, Diabetes Tipo 1 e 2, Diabetes Gestacional, Tratamento de Úlceras e Feridas Vasculares/Diabéticas, Cirurgia Vascular', 'Segunda a sexta-feira, das 7h às 18h', '3422-2719', 'Central de atendimento a síndromes metabólicas e ao Programa de Úlceras e Feridas (PUF) com curativos de alta tecnologia.', '2026-08-27 00:00:00', 'img/CADME.png'),
(117, 'Centro de Especialidades Médicas e Serviço Social da Saúde e Farmácia Central', 'Travessa Newton de Almeida Mello, s/n – Centro', -22.72865713, -47.65021209, 'Consultas Médicas Especializadas Multidisciplinares, Hematologia (Hemoglobinopatias/Doença Falciforme), Ambulatório Transexualizador (Hormonioterapia)', 'Segunda a sexta-feira, das 7h às 19h', '3434-7600', 'Hub centralizador de médicos especialistas das mais diversas áreas e suporte a processos de transgenitalização/mastectomia.', '2026-08-27 00:00:00', NULL),
(118, 'Clínica de Olhos', 'Rua Alferes José Caetano, 1453 – Centro', -22.72862294, -47.65251552, 'Oftalmologia Geral, Consultas e Avaliações Oftalmológicas, Encaminhamento para Cirurgias Oculares', 'Segunda a sexta-feira, das 7h às 17h', '3434-3042', 'Unidade exclusiva para cuidados com a saúde visual e encaminhamentos cirúrgicos oftalmológicos.', '2026-08-28 00:00:00', 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (9).png'),
(119, 'Núcleo de Atendimento à Saúde do Idoso (NASI) SUL e Programa de Atenção Domiciliar (PAD) e Centro de Atenção em Reabilitação Especial (Fisioterapia)', 'Avenida Piracicamirim, 3139 – Piracicamirim', -22.73725843, -47.63105000, 'Geriatria, Reabilitação Geriátrica, Tratamento de Demências Neurológicas, Prevenção de Quedas e Manejo de Polifarmácia', 'Segunda a sexta-feira, das 09h às 16h', '3402-1762', 'Ambulatório especializado na manutenção da capacidade funcional e assistência multiprofissional à população idosa da região sul.', '2026-08-27 00:00:00', NULL),
(121, 'Coordenadoria de Programas de Alimentação e Nutrição (CPAN)', 'Avenida Independência, 3105 – Alemães', -22.72249767, -47.63336976, 'Nutrição Clínica Especializada, Ambulatório de Nutrição, Acompanhamento Materno-Infantil e Incentivo ao Aleitamento Materno', 'Segunda a sexta-feira, das 7h às 17h', '3434-4566', 'Responsável pelo diagnóstico nutricional do SUS, programas de suplementação alimentar e coordenação do Comitê de Aleitamento.', '2026-08-27 00:00:00', 'img/CPAN.png'),
(122, 'Centro de Especialidades Odontológicas (CEO I)', 'Avenida Independência, 2600 - Vila Monteiro', -22.72676705, -47.63443496, 'Diagnóstico de Câncer de Boca, Periodontia (Gengivas), Cirurgia Bucomaxilofacial, Endodontia (Canal), Odontopediatria, Prótese Dentária, Atendimento a Pacientes Especiais', 'Segunda a sexta-feira, das 07h às 17h', '3433-3934 / 3433-3850', 'Unidade de média complexidade odontológica do SUS voltada a tratamentos especializados.', '2026-08-28 00:00:00', 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (7).png'),
(123, 'Centro de Especialidades Odontológicas (CEO II / CEO FOP)', 'Rua José Nardo, 177 – Morumbi', -22.72844271, -47.62156377, 'Diagnóstico de Câncer de Boca, Periodontia, Cirurgia Oral, Endodontia, Odontopediatria, Próteses e Atendimento a Pacientes Especiais', 'Segunda a sexta-feira, das 07h às 16h', '3412-3772', 'Unidade de especialidades odontológicas mantida em parceria com a Faculdade de Odontologia de Piracicaba (FOP/UNICAMP).', '2026-08-28 00:00:00', 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (8).png'),
(124, 'Pacto pela Redução do Óbito Infantil de Piracicaba', 'Rua Ipiranga, 639 – Centro', -22.72714200, -47.65102400, 'Apoio ao Pré-Natal de Alto Risco, Monitoramento Telefônico de Gestantes, Medicina Preventiva Materno-Infantil', 'Segunda a sexta-feira, das 07h30 às 17h', '3436-0511', 'Programa focado na redução e prevenção de óbitos infantis evitáveis em crianças de até 1 ano.', '2026-05-23 02:52:46', NULL),
(125, 'Centro de Doenças Infectocontagiosas (CEDIC)', 'Rua do Trabalho, 634 – Vila Independência', -22.71750199, -47.63160633, 'Infectologia, Tratamento de IST/AIDS e Hepatites Virais, Hanseníase, Tuberculose, Profilaxia Pré-Exposição (PrEP) e Pós-Exposição (PEP) ao HIV', 'Segunda a sexta-feira, das 07h às 17h', '3437-7800', 'Unidade de referência em vigilância, testagem sigilosa (CTA), assistência especializada (SAE) e Farmácia Especializada de Medicamentos Estratégicos (UDM).', '2026-08-28 00:00:00', 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (6).png'),
(126, 'Centro de Atenção Psicossocial Álcool e Drogas (CAPSad)', 'Avenida Dr. Paulo de Moraes, 1703 - Paulista', -22.73557492, -47.65389918, 'Tratamento de Transtornos por Uso de Substâncias Psicoativas, Dependência Química, Abuso de Álcool e Drogas', 'Segunda a sexta-feira, das 7h às 17h', '3411-6520', 'Unidade de saúde mental voltada ao cuidado e reinserção social de usuários com uso abusivo de substâncias. Acolhimento de casos novos: seg a qui (7h-11h e 13h-16h) e sex (13h-16h).', '2026-08-28 00:00:00', 'img/ChatGPT Image 28 de ago. de 2026, 14_09_48 (3).png'),
(127, 'Ambulatório de Saúde Mental - Vila Cristina', 'Rua Dr. Antônio Augusto de Barros Penteado, 422 – Jardim Elite', -22.73897546, -47.64011549, 'Psiquiatria, Psicologia Clínica, Transtornos Mentais Severos e Persistentes, Transtornos Neuróticos, Psicoses, Prevenção e Ideação Suicida', 'Segunda a sexta-feira, das 7h às 17h', '3402-3028 / 3413-4285', 'Atendimento ambulatorial referenciado para a população da Região Oeste da cidade. Acolhimento de novos casos: seg a sex, das 7h às 11h.', '2026-08-27 00:00:00', NULL),
(128, 'Centro de Atenção Psicossocial Bela Vista (CAPS II - Bela Vista) e Consultório na Rua', 'Rua Bela Vista, 665 – Vila Independência', -22.71729488, -47.63092663, 'Psiquiatria, Transtornos Mentais Severos e Persistentes, Psicoses, Transtornos Neuróticos Graves, Prevenção e Ideação Suicida', 'Segunda a sexta-feira, das 7h às 17h', '3432-9964 / 3433-0312', 'Atendimento intensivo de saúde mental para as Regiões Centro, Sul e Leste. Acolhimento de novos casos: seg, ter, qui e sex (7h-11h e 13h-16h) e qua (13h-16h).', '2026-08-27 00:00:00', NULL),
(129, 'Centro de Atenção Psicossocial CAPS II Girassol - Região Norte', 'Rua das Ametistas, 210 – Mário Dedini', -22.68282958, -47.65975809, 'Psiquiatria, Acompanhamento Psicológico, Transtornos Mentais Severos, Esquizofrenia, Transtornos Psicóticos, Intervenção em Crises Suicidas', 'Segunda a sexta-feira, das 7h às 17h', '3415-3343', 'Equipe multiprofissional com foco na população da Região Norte. Acolhimento de novos casos: seg, qua e qui (7h-11h e 13h-16h), ter (13h-16h) e sex (7h-11h).', '2026-08-27 00:00:00', 'img/CAPSIIGIRASSOL.png'),
(130, 'Centro de Atenção Psicossocial Infantojuvenil (CAPS-IJ)', 'Rua Floriano Carraro, 425 – Nova Piracicaba', -22.71630294, -47.66244581, 'Psiquiatria Infantil e Juvenil, Psicologia da Infância e Adolescência, Transtornos Mentais Graves na Infância, Tratamento Infantojuvenil contra Drogadição (5 a 18 anos)', 'Segunda a sexta-feira, das 7h às 17h', '3422-3905 / 3413-1515', 'Equipe especializada no tratamento de crianças e jovens com sofrimento mental acentuado. Acolhimento de casos novos: seg e qui (7h-11h e 13h-16h), ter, qua e sex (7h-11h).', '2026-08-27 00:00:00', 'img/CAPSIJ.png'),
(131, 'Residência Terapêutica (RT)', 'Rua Morais Barros, 1625 – Centro', -22.72814200, -47.64614200, 'Moradia Assistida, Reabilitação Psicossocial, Reinserção Social de Pacientes Psiquiátricos Egressos', '24 horas', '3411-3707', 'Dispositivo residencial de acolhimento permanente para ex-moradores de hospitais psiquiátricos de longa permanência (capacidade para 10 moradores).', '2026-05-23 02:58:30', NULL),
(133, 'Vigilância Epidemiológica (VE) e Centro de Referência em Saúde do Trabalhador (CEREST) e Vigilância Sanitária Municipal (VISA)', 'Rua do Trabalho, 634 – Vila Independência', -22.71754464, -47.63165740, 'Imunização Municipal, Controle de Doenças de Notificação Compulsória, Vigilância de Óbitos, Epidemiologia e Protocolos de Saúde Coletiva', 'Segunda a sexta-feira, das 7h às 17h', '3437-7800', 'Gestão central de imunobiológicos, controle de surtos, coleta e processamento de bancos de dados vitais (SIM/SINASC) e Programa Dupla Dose de Amor.', '2026-08-27 00:00:00', 'img/VIGILANCIA.png'),
(134, 'Centro de Referência em Saúde do Trabalhador (CEREST)', 'Rua do Trabalho, 634 – Vila Independência', -22.71754464, -47.63165740, 'Medicina do Trabalho, Perícia de Nexo Causal Ocupacional, Investigação de Doenças Ocupacionais, Fiscalização de Ambientes Laborais, Notificação de Acidentes de Trabalho', 'Segunda a sexta-feira, das 7h às 16h', '3437-7800', 'Serviço regional focado na intervenção de riscos em indústrias e comércios e suporte técnico aos municípios de abrangência.', '2026-08-27 00:00:00', 'img/VIGILANCIA.png'),
(135, 'Vigilância Sanitária Municipal (VISA)', 'Rua do Trabalho, 634 – Vila Independência', -22.71751610, -47.63171257, 'Inspeção Sanitária, Controle de Qualidade da Água (PROAGUA), Fiscalização de Serviços de Saúde, Regulação de Alimentos, Bebidas e Medicamentos', 'Segunda a sexta-feira, das 7h às 16h', '3437-7800', 'Atua na prevenção de riscos à saúde pública por meio de vistorias, emissão de licenças, orientações técnicas e contenção de surtos alimentares ou hospitalares.', '2026-08-27 00:00:00', 'img/VIGILANCIA.png'),
(136, 'Centro de Controle de Zoonoses (CCZ)', 'Rua Dionísio Dal Picolo, próximo ao nº 39 – Jupiá', -22.71353923, -47.68323055, 'Vacinação Antirrábica, Controle de Arboviroses (Dengue, Zika, Chikungunya), Manejo de Vetores e Pragas (Sinantrópicos), Castração de Cães e Gatos, Bem-Estar Animal', 'Segunda a sexta-feira, das 7h às 16h', '3427-3008 / 3427-3460', 'Engloba o Programa Municipal de Combate ao Aedes (PMCA) com arrastões e vistorias de campo, além do Canil/Gatil Municipal.', '2026-08-28 00:00:00', 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (4).png'),
(137, 'Central de Relacionamento com o Usuário SUS (Centrus) e S.A.C – Serviço de Avaliação e Controle', 'Centro Cívico – Rua Antônio Corrêa Barbosa, 2233, 2º andar', -22.72864653, -47.66439948, 'Agendamento e Regulação de Consultas, Confirmação de Exames SUS, Redução de Absenteísmo na Rede Pública', 'Segunda a sexta-feira, das 7h30 às 15h30', '3403-1000', 'Central de atendimento ativo e receptivo por via telefônica dedicada a otimizar a agenda médica e guias do paciente do SUS.', '2026-08-27 00:00:00', NULL),
(141, 'Laboratório Municipal Central', 'Rua Dom Pedro I, 817 – Centro', -22.72872318, -47.65054261, 'Análises Clínicas (Sangue, Urina, Fezes e Fluidos Corporais), Exames Laboratoriais, Processamento de Biópsias e Peças de Tecidos (Patologia Diagnóstica)', 'Segunda a sexta-feira, das 7h às 16h', '3437-7620 / 3437-7631', 'Laboratório centralizado integrado (atrás do Mercado Municipal) que processa as coletas de toda a atenção básica, especializada e UPAs do município.', '2026-08-27 00:00:00', NULL),
(142, 'Centro de Diagnóstico de Imagem (CDI)', 'Avenida Independência, 2600 / 2626 - Vila Monteiro', -22.72674676, -47.63443807, 'Ultrassonografia Geral, Ultrassonografia Obstétrica, Diagnóstico por Imagem e Ultrassom Diagnóstico', 'Segunda a sexta-feira, das 7h às 17h', '3422-6617 / 3422-0703', 'Unidade médica dedicada exclusivamente a exames agendados de ultrassonografia estruturada.', '2026-08-28 00:00:00', 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (5).png'),
(143, 'Farmácia Alvorada', 'Rua Sérgio Cardoso, 175 – Jardim Alvorada', -22.76043330, -47.61437300, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3411-4194', 'Unidades de Referência para Atendimento: UBS Alvorada, USF Sol Nascente, USF Chapadão.', '2026-08-27 00:00:00', NULL),
(144, 'Farmácia Anhumas – Zona Rural', 'Estrada Rosa Francelina de Abreu, 10 – Anhumas', -22.83541900, -47.92635650, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segundas, quartas e sextas-feiras, das 8h às 12h e das 13h às 16h', '3438-4205', 'Unidades de Referência para Atendimento: UBS Anhumas.', '2026-08-27 00:00:00', NULL),
(145, 'Farmácia Ártemis', 'Av. Fioravante Cenedese, 881 – Ártemis', -22.68219574, -47.77327123, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 12h e das 13h às 16h', '3438-3107', 'Unidades de Referência para Atendimento: USF Artemis I, USF Artemis II.', '2026-08-27 00:00:00', NULL),
(146, 'Farmácia Caxambu', 'Rua Henrique Rochelle, 85 – Caxambu', -22.74908470, -47.63523230, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3426-5658', 'Unidades de Referência para Atendimento: UBS Caxambu, USF Asturias, USF 1º de Maio.', '2026-08-27 00:00:00', NULL),
(147, 'Farmácia Cecap', 'Alameda Melvin Jones, 55 – CECAP', -22.77292940, -47.59579029, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3414-2430', 'Unidades de Referência para Atendimento: USF Cecap, USF Eldorado I, USF Eldorado II, USF Santa Rita, USF São Francisco, UBS Cecap (antigo Crab).', '2026-08-27 00:00:00', NULL),
(148, 'Farmácia Central', 'Travessa Newton de Almeida Mello, S/N – Centro', -22.72865713, -47.65021209, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3433-2376', 'Unidades de Referência para Atendimento: UBS Centro, USF Saúde em Campo – Monte Alegre.', '2026-08-27 00:00:00', NULL),
(149, 'Farmácia Costa Rica', 'Rua Sofia, 80 – Costa Rica', -22.76500553, -47.65505017, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 12h e das 13h às 16h', '3411-4255', 'Unidades de Referência para Atendimento: USF Campestre, USF Costa Rica.', '2026-08-27 00:00:00', NULL),
(150, 'Farmácia Coreia (Pauliceia)', 'Rua Santa Helena, 334 – Paulicéia', -22.75082576, -47.64531043, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 12h e das 13h às 16h', '3433-8682', 'Unidades de Referência para Atendimento: UBS Pauliceia.', '2026-08-27 00:00:00', NULL),
(151, 'Farmácia UBS Mario Dedini (antigo Crab)', 'Rua Nadir Eraldo Stella, 137 – Mario Dedini', -22.68056559, -47.66278457, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3413-4245', 'Unidades de Referência para Atendimento: USF Mario Dedini I, USF Mario Dedini II, USF Bosque dos Lenheiros I, USF Bosque dos Lenheiros II, USF Vila Industrial, USF Jardim Gilda.', '2026-08-27 00:00:00', NULL),
(152, 'Farmácia UBS Vila Sônia (antigo Crab)', 'Rua Palmital, s/nº – Parque Piracicaba (Balbo)', -22.67895908, -47.70354381, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3413-4508', 'Unidades de Referência para Atendimento: UBS Vila Sônia, USF Parque Orlanda, USF Boa Esperança I, USF Santana, USF Vem Viver.', '2026-08-27 00:00:00', NULL),
(153, 'Farmácia Esplanada', 'Rua Augusto Furlan, 31 – Jardim Esplanada', -22.74566288, -47.65488596, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3422-7923', 'Unidades de Referência para Atendimento: UBS Esplanada, UBS Paulista (antigo Crab).', '2026-08-27 00:00:00', NULL),
(154, 'Farmácia Ibitiruna – Zona Rural', 'Rua Piracicaba, 10 – Ibitiruna', -22.77470660, -47.96325950, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Terças e quintas-feiras, das 8h30 às 12h e das 13h às 15h30', '3438-4126', 'Unidades de Referência para Atendimento: UBS Ibitiruna.', '2026-08-27 00:00:00', NULL),
(155, 'Farmácia Jaraguá', 'Rua Prof. Mariano da Costa, 380 – Jaraguá', -22.73913980, -47.66820565, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3432-1385', 'Unidades de Referência para Atendimento: USF Jaraguá I, USF Jaraguá II, USF São José.', '2026-08-27 00:00:00', NULL),
(156, 'Farmácia Jardim Oriente', 'Avenida Luis Pereira Leite, 2351 – Jardim Oriente', -22.77201613, -47.62413469, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Terças e quintas-feiras, das 7h às 12h e das 13h às 16h', '3426-6182', 'Unidades de Referência para Atendimento: USF Jardim Oriente, USF Serra Verde, USF Monte Feliz.', '2026-08-27 00:00:00', NULL),
(157, 'Farmácia Jardim São Paulo', 'Rua Felinto de Brito, 378 – Monte Líbano', -22.75380920, -47.65466390, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3422-6876', 'Unidades de Referência para Atendimento: USF Monte Libano I, USF Monte Libano II, USF Jardim das Flores, USF Itapuã I, USF Itapuã II.', '2026-08-27 00:00:00', NULL),
(158, 'Farmácia Jupiá', 'Rua João Eudóxio da Silva, S/N – Jupiá', -22.70862016, -47.68479167, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Terças e quintas-feiras, das 7h às 12h e das 13h às 16h', '3427-2865', 'Unidade de Referência para Atendimento: UBS Jupiá.', '2026-08-27 00:00:00', NULL),
(159, 'Farmácia Novo Horizonte', 'Rua Moacir Martins, 255 – Novo Horizonte', -22.76057460, -47.67571795, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3425-3232', 'Unidade de Referência para Atendimento: UBS Novo Horizonte, USF Kobayat Libano, USF Santa Fé.', '2026-08-27 00:00:00', NULL),
(160, 'Farmácia Piracicamirim', 'Rua Rio Grande do Norte, 135 – Piracicamirim', -22.73941996, -47.62725644, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3426-1668', 'Unidade de Referência para Atendimento: UBS Piracicamirim (Antigo Crab), UBS Independência.', '2026-08-27 00:00:00', NULL),
(161, 'Farmácia Planalto', 'Rua Herculano Mônaco, 180 – Planalto', -22.74134526, -47.67221606, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3434-7100', 'Unidade de Referência para Atendimento: UBS Planalto, USF Paineiras, USF Jardim Vitória.', '2026-08-27 00:00:00', NULL),
(162, 'Farmácia Santa Terezinha', 'Rua Nicolau Zem, 220 – Santa Terezinha', -22.67952398, -47.68336984, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3415-3373', 'Unidade de Referência para Atendimento: UBS Santa Terezinha (Antigo Crab), USF IAA I, USF IAA II.', '2026-08-27 00:00:00', NULL),
(163, 'Farmácia Tanquinho', 'Rua Américo Faganello, S/N – Tanquinho', -22.56970010, -47.60744410, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 8h às 12h', '3431-1115', 'Unidade de Referência para Atendimento: UBS Tanquinho.', '2026-08-27 00:00:00', NULL),
(164, 'Farmácia Tupi', 'Rua Piracicaba, S/N – Tupi', -22.74286252, -47.52657214, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 12h e das 13h às 16h', '3438-7454', 'Unidade de Referência para Atendimento: USF Tupi.', '2026-08-27 00:00:00', NULL),
(165, 'Farmácia Vila Cristina', 'Rua Presidente Wenceslau Braz, 59 – Vila Cristina', -22.74644830, -47.66314120, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3435-1853', 'Unidade de Referência para Atendimento: UBS Vila Cristina, USF Tatuapé I, USF Tatuapé II.', '2026-08-27 00:00:00', NULL),
(166, 'Farmácia Jardim Primavera', 'Rua Cecílio Elias, s/nº – Jardim Primavera', -22.69456637, -47.65345004, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3413-7907', 'Unidade de Referência para Atendimento: USF Vila Fátima, USF Jardim Primavera.', '2026-08-27 00:00:00', NULL),
(167, 'Farmácia Vila Rezende', 'Avenida Conceição, 300 – Vila Rezende', -22.70361610, -47.65931210, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Todos os dias, das 7h às 16h', '3421-3879', 'Unidade de Referência para Atendimento: USF Saúde Em Campo – Parque São Jorge, UBS Algodoal, UBS Vila Rezende (Antigo Crab), USF Santa Rosa I, USF Santa Rosa II, USF Algodoal.', '2026-08-27 00:00:00', NULL),
(168, 'Farmácia Vila Sônia', 'Rua Dino Bueno, 565 – Vila Sônia', -22.67106619, -47.69294275, 'Dispensação de Medicamentos Básicos, Farmácia Municipal', 'Segunda a sexta-feira, das 7h às 16h', '3415-3405', 'Unidade de Referência para Atendimento: UBS Parque Piracicaba, USF Boa Esperança II, USF Gran Park, USF Javari.', '2026-08-27 00:00:00', NULL),
(169, 'Farmácia Alto Custo', 'Av. Dr. Paulo de Moraes, 2073 – Centro', -22.73725649, -47.65043572, 'Dispensação de Medicamentos de Alto Custo (Componente Especializado), Protocolos PCDT', 'Segunda a sexta-feira, das 7h às 16h', '3422-3151', 'Dispensa gratuitamente medicamentos selecionados pelo Estado e Ministério da Saúde, mediante abertura de processo e auditoria para patologias do PCDT.', '2026-08-27 00:00:00', NULL),
(170, 'Farmácia do Cedic', 'Rua do Trabalho, 634 – Vila Independência', -22.71750199, -47.63160633, 'Medicamentos Estratégicos, Antirretrovirais (HIV/AIDS), Tratamento de ISTs, Hepatites Virais, Tuberculose e Hanseníase', 'Segunda a sexta-feira, das 7h às 16h45', '3437-7504', 'Dispensa medicamentos gratuitos do Componente Estratégico do SUS para programas de doenças infectocontagiosas e sexualmente transmissíveis.', '2026-08-27 00:00:00', NULL),
(171, 'Hospital Dia (AME)', 'Rua Riachuelo, 1850 – Bairro Alto', -22.73500810, -47.64234040, 'Cirurgias Eletivas, Otorrinolaringologia, Dermatologia, Oftalmologia, Ortopedia', 'Segunda a sexta-feira, das 7h às 19h', '3437-4950', 'Ambulatório Médico de Especialidades focado em cirurgias eletivas agendadas e não urgentes. Gerenciado pela Funcamp/Unicamp em vínculo com o Estado de SP.', '2026-08-28 00:00:00', 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (10).png'),
(173, 'Hospital Regional de Piracicaba Zilda Arns (HRP)', 'Rua Antônio Elias, 1000 – Bairro Santa Rita', -22.76106000, -47.58400000, 'Otorrinolaringologia, Oftalmologia, Ortopedia, Cirurgia Geral, Clínica Médica, Medicina Intensiva, Cardiologia, Infectologia, Ressonância Magnética, Tomografia', 'Atendimento Ambulatorial Agendado (Sem Pronto Atendimento)', '(19) 3052-4650 / 3052-4651', 'Assistência complementar regional via CROSS (sem pronto atendimento). Possui 82 leitos (42 enfermaria / 40 UTI) e centro cirúrgico. Gerido pela Unicamp/Fascamp.', '2026-08-27 00:00:00', NULL);
INSERT INTO `instituicoes` (`id`, `nome`, `localizacao`, `lat`, `lng`, `especialidades`, `horario_atendimento`, `contato`, `detalhes`, `atualizado_em`, `url_imagem`) VALUES
(174, 'Irmandade da Santa Casa de Misericórdia de Piracicaba', 'Av. Independência, 953 ', -22.73727533, -47.64339955, 'Anestestistas\r\nCardiologia\r\nCirurgia cardíaca\r\nCirurgia geral\r\nCirurgia oncológica\r\nCirurgia pediátrica\r\nCirurgia plástica\r\nCirurgia torácica\r\nClinica médica\r\nDermatologia\r\nEndocrinologia\r\nEndosocopia\r\nGeriatria\r\nGinecologia e obstetrícia\r\nGinecologia oncológica\r\nHematologia\r\nHepatologia\r\nInfectologia\r\nNefrologia\r\nNeurocirurgia\r\nNeurologia\r\nNeuropediatria\r\nOftalmologia\r\nOncologia\r\nOrtopedia\r\nOtorrinolaringologia\r\nPediatria\r\nPneumologia\r\nPsiquiatria\r\nRadiologia\r\nReumatologia\r\nUrologia\r\nVascular', 'Atendimento 24 horas', '(19) 3417-5000', 'A Secretaria Municipal de Saúde tem contrato de prestação\r\nde serviços com a Santa Casa garante, anualmente, o aumento no número de internações,\r\nconsultas, cirurgias e outros procedimentos médicos para usuários do\r\nSUS.', '2026-08-27 00:00:00', NULL),
(175, 'Hospital dos Fornecedores de Cana - HFC Saúde', 'Av. Barão de Valença, 716 ', -22.71216712, -47.65767734, 'Cardiologia, Dermatologia, Endocrinologia, Geriatria, Pediatria, Cirurgia Geral, Cirurgia de Cabeça e Pescoço, Cirurgia Plástica e Cirurgia Vascular, HFC Onco (Oncologia) e HFC Nefro (Nefrologia).', 'Atendimento 24 horas.', '(19)3403-2800', NULL, '2026-08-27 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `email` varchar(191) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `token_hash` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token_hash`, `expires_at`, `created_at`) VALUES
(4, 'christianrocha491@gmail.com', 'b464c4ee2be1b5c21ab4863e1c8a7d4b65b932620b885e6414e623e07100fe30', '2026-05-28 20:22:24', '2026-05-28 19:22:24'),
(5, 'raekwon@gmail.com', '687d4a59e2ceb43159bc4fffa990ca3f05c4e4ec7c2ae115149e277c27942851', '2026-05-28 20:23:54', '2026-05-28 19:23:54'),
(6, 'christianrocha491@gmail.com', 'f68e096688a5011f390a8773e1b4e906577979f01d00eca3fe494af1de658714', '2026-06-11 20:08:58', '2026-06-11 19:08:58'),
(7, 'christianrocha491@gmail.com', '678e7b812bd7686eed424bd67aedbc9ae8371de1e19332bd1423809d80161379', '2026-06-11 22:43:51', '2026-06-11 21:43:51');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `data_cadastro`) VALUES
(13, 'Christian Barbosa Rocha', 'christianrocha491@gmail.com', '$2y$10$S/vccr2tX6Yp2ON6FBNAo.Ai7NOFp1NaaKl72a76lfM/X6lz2kdGq', '2026-05-28 17:12:21'),
(14, 'raelcon', 'raekwon@gmail.com', '$2y$10$Sgdm5iZBxXd6ebMovykCz.bOkXYw5MZ1IKubDCV6jFqchpmkOiEg.', '2026-05-28 17:23:31'),
(15, 'joao', 'joao@gmail.com', '$2y$10$q/gLlScu6Ag92ZWLjdeh9O/CFoeLG8S2uGOrQorAYUUhGTx1YLn/C', '2026-05-30 01:15:22');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `instituicoes`
--
ALTER TABLE `instituicoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `instituicoes`
--
ALTER TABLE `instituicoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;

--
-- AUTO_INCREMENT de tabela `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
