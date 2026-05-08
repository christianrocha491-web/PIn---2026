-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 09/05/2026 às 01:21
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
CREATE DATABASE IF NOT EXISTS `pin2026` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pin2026`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `instituicoes`
--

DROP TABLE IF EXISTS `instituicoes`;
CREATE TABLE IF NOT EXISTS `instituicoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `localizacao` varchar(255) NOT NULL,
  `lat` decimal(10,8) NOT NULL,
  `lng` decimal(11,8) NOT NULL,
  `especialidades` text DEFAULT NULL,
  `horario_atendimento` varchar(100) DEFAULT NULL,
  `contato` varchar(100) DEFAULT NULL,
  `detalhes` text DEFAULT NULL,
  `atualizado_em` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `url_imagem` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `instituicoes`
--

INSERT INTO `instituicoes` (`id`, `nome`, `localizacao`, `lat`, `lng`, `especialidades`, `horario_atendimento`, `contato`, `detalhes`, `atualizado_em`, `url_imagem`) VALUES
(1, 'UBS Cidade Alta', 'Rua Benedito Passuti, 301 · 1.2km', -22.73050000, -47.64320000, 'Clínico Geral, Pediatria, Vacinação', '07:00 - 17:00', NULL, NULL, '2026-05-08 02:31:51', 'https://picsum.photos/id/221/500/300'),
(2, 'CRAB Vila Sônia', 'Rua João Zem, 450 · 3.5km', -22.70120000, -47.63210000, 'Pediatria, Dentista, Ginecologia', '07:00 - 19:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(3, 'UPA Piracicamirim', 'Rua Rio Grande do Norte, 135 · 3.8km', -22.73473100, -47.62584100, 'Urgência, Ortopedia, Raio-X', '24h', NULL, NULL, '2026-05-07 23:18:25', NULL),
(4, 'Santa Casa de Piracicaba', 'Rua Moraes Barros, 33 · 2.0km', -22.72330000, -47.64810000, 'Urgência, Cardiologia, UTI', '24h', NULL, NULL, '2026-05-07 23:18:25', NULL),
(5, 'CEO Piracicaba', 'Rua Boa Morte, 2020 · 2.8km', -22.72550000, -47.64100000, 'Dentista, Ortodontia', '08:00 - 17:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(6, 'CAPS Centro', 'Rua do Rosário, 900 · 1.8km', -22.72800000, -47.65100000, 'Psicologia, Psiquiatria', '08:00 - 18:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(7, 'CAPS Infantil', 'Rua Antônio Correa Barbosa, 200 · 3.2km', -22.72100000, -47.65500000, 'Psicologia, Psicopedagogia', '08:00 - 17:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(8, 'UBS Santa Terezinha', 'Av. Armando Sales de Oliveira, 150 · 4.7km', -22.68500000, -47.63500000, 'Clínico Geral, Ginecologia, Fisioterapia', '07:00 - 17:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(9, 'UBS Centro', 'Rua Moraes Barros, 480 · 2.1km', -22.72600000, -47.64700000, 'Clínico Geral, Vacinação', '07:00 - 17:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(10, 'Clínica de Fisioterapia Municipal', 'Av. Independência, 780 · 5.1km', -22.73800000, -47.63900000, 'Fisioterapia, Reabilitação', '07:00 - 18:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(11, 'Centro de Cardiologia Pira', 'Rua Tiradentes, 300 · 2.4km', -22.72900000, -47.64500000, 'Cardiologia, Ecocardiograma', '07:00 - 17:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(12, 'Núcleo de Nutrição Municipal', 'Rua Campos Salles, 600 · 3.0km', -22.73200000, -47.64000000, 'Nutrição, Dietética', '08:00 - 17:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(13, 'UPA Vila Rezende', 'Av. Luís de Queirós, 1500 · 5.2km', -22.71500000, -47.65200000, 'Urgência, Pediatria', '24h', NULL, NULL, '2026-05-07 23:18:25', NULL),
(14, 'UBS Nova América', 'Av. Independência, 580 · 5.3km', -22.73950000, -47.63850000, 'Pediatria, Clínico Geral', '07:00 - 17:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(15, 'CAPS ADmudei', 'Rua Visconde do Rio Branco, 1300 · 4.0km', -22.73500000, -47.64400000, 'Psicologia, Assistência Social', '08:00 - 18:00', NULL, NULL, '2026-05-08 01:16:20', ''),
(16, 'Posto de Vacinação Central', 'Rua do Rosário, 430 · 1.5km', -22.72700000, -47.64900000, 'Vacinação, Saúde Infantil', '08:00 - 17:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(17, 'Clínica de Ginecologia Municipal', 'Rua Benjamin Constant, 900 · 2.6km', -22.72400000, -47.64300000, 'Ginecologia, Obstetrícia, Pré-natal', '07:00 - 17:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(18, 'Centro de Ortopedia Pira', 'Av. Independência, 1200 · 4.0km', -22.74100000, -47.63600000, 'Ortopedia, Fisioterapia, Raio-X', '07:00 - 19:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(19, 'Farmácia Drogasil Centro', 'Rua do Rosário, 600 · 0.8km', -22.72750000, -47.64950000, 'Medicamentos, Farmácia, Cosméticos', '07:00 - 23:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(20, 'Farmácia São Paulo', 'Av. Independência, 500 · 1.2km', -22.73600000, -47.64100000, 'Medicamentos, Farmácia', '24h', NULL, NULL, '2026-05-07 23:18:25', NULL),
(21, 'Farmácia Pague Menos', 'Rua Moraes Barros, 200 · 0.6km', -22.72500000, -47.64750000, 'Medicamentos, Farmácia, Produtos Naturais', '07:00 - 22:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(22, 'Farmácia Popular Municipal', 'Av. Dr. Paulo de Moraes, 300 · 2.0km', -22.72200000, -47.65600000, 'Medicamentos, Farmácia, Genéricos', '08:00 - 18:00', NULL, NULL, '2026-05-07 23:18:25', NULL),
(23, 'CRAB Vila Rezende', 'Rua Santo Estevão, 394 - Vila Rezende', -22.70888270, -47.65724430, 'cfhvbnm', '7:00 - 8:00', '', '', '2026-05-08 03:02:34', 'https://picsum.photos/id/229/500/300'),
(24, 'CAPS II Vila Sônia ', 'rua abc', -22.70650000, -47.65900000, 'Psicologia, Psiquiatria, Oficinas Terapêuticas', '07:00 - 17:00', NULL, NULL, '2026-05-08 03:16:55', 'https://i.ibb.co/L5hY8mG/health-card-01.jpg'),
(25, 'Ambulatório Médico do Governo do São Paulo, Piracicaba', 'R. Riachuelo, 1850 - Jardim Elite, Piracicaba - SP, 13419-311', -22.73468298, -47.64266194, 'Local tem várias especialidades,mas somente com encaminhamento e marcado.  A unidade fez uma área com micro-ondas para os pacientes e acompanhantes usarem, achei uma ação muito bacana e diferenciada. Parabéns à todos. Estacionamento somente na rua e em frente tem uma lanchonete.', '06:30 - 22:00', NULL, NULL, '2026-05-08 03:22:08', 'https://i.ibb.co/9H1sW9K/health-card-02.jpg'),
(26, 'Ambulatório Médico do Governo do São Paulo, Piracicaba', 'R. Riachuelo, 1850 - Jardim Elite, Piracicaba - SP, 13419-311', -22.73400000, -47.64200000, 'Local tem várias especialidades,mas somente com encaminhamento e marcado.  A unidade fez uma área com micro-ondas para os pacientes e acompanhantes usarem, achei uma ação muito bacana e diferenciada. Parabéns à todos. Estacionamento somente na rua e em frente tem uma lanchonete.', '06:30 - 22:00', NULL, NULL, '2026-05-08 03:23:01', 'https://i.ibb.co/9H1sW9K/health-card-02.jpg'),
(27, 'Hospital Santa Isabel - Santa Casa de Piracicaba', 'Av. Independência, 953 - Alto, Piracicaba - SP, 13419-155', -22.73700000, -47.64300000, 'jhbnmnm, ', '09:00 - 14:00', NULL, NULL, '2026-05-08 03:30:48', 'https://i.ibb.co/xG7N2M9/health-card-03.jpg'),
(28, 'teste_testando-som', 'Rua eu odeio o if 123', -22.68080000, -47.67160000, 'kajffhakjh', NULL, NULL, 'fhgjbn', '2026-05-08 22:21:51', 'https://images.unsplash.com/photo-1587351021759-3e566b6af7cc?q=80&w=500&h=300&auto=format&fit=crop'),
(29, '', '', 0.00000000, 0.00000000, NULL, NULL, NULL, NULL, '2026-05-08 22:21:51', NULL),
(30, 'teste_testando-som', 'Rua eu odeio o if 123', -22.68000000, -47.67100000, 'kajffhakjh', NULL, NULL, 'fhgjbn', '2026-05-08 22:22:17', 'https://images.unsplash.com/photo-1587351021759-3e566b6af7cc?q=80&w=500&h=300&auto=format&fit=crop'),
(31, '', '', 0.00000000, 0.00000000, NULL, NULL, NULL, NULL, '2026-05-08 22:22:17', NULL),
(32, 'teste', 'rua eu odeio o if 124', -22.68000000, -47.67100000, 'fghjbnm', '07:00-08:00', NULL, 'hgbnm', '2026-05-08 22:24:27', 'https://images.unsplash.com/photo-1587351021759-3e566b6af7cc?q=80&w=500&h=300&auto=format&fit=crop');

-- --------------------------------------------------------

--
-- Estrutura para tabela `login`
--

DROP TABLE IF EXISTS `login`;
CREATE TABLE IF NOT EXISTS `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(191) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
