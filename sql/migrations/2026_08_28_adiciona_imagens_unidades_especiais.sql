-- Adiciona imagens específicas aos cards das unidades especiais sem imagem.
SET NAMES utf8mb4;
START TRANSACTION;

UPDATE instituicoes SET url_imagem = 'img/ChatGPT Image 28 de ago. de 2026, 14_09_48 (2).png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 110;
UPDATE instituicoes SET url_imagem = 'img/ChatGPT Image 28 de ago. de 2026, 14_09_48 (1).png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 114;
UPDATE instituicoes SET url_imagem = 'img/CADME.png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 116;
UPDATE instituicoes SET url_imagem = 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (9).png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 118;
UPDATE instituicoes SET url_imagem = 'img/CPAN.png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 121;
UPDATE instituicoes SET url_imagem = 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (7).png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 122;
UPDATE instituicoes SET url_imagem = 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (8).png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 123;
UPDATE instituicoes SET url_imagem = 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (6).png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 125;
UPDATE instituicoes SET url_imagem = 'img/ChatGPT Image 28 de ago. de 2026, 14_09_48 (3).png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 126;
UPDATE instituicoes SET url_imagem = 'img/CAPSIIGIRASSOL.png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 129;
UPDATE instituicoes SET url_imagem = 'img/CAPSIJ.png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 130;
UPDATE instituicoes SET url_imagem = 'img/VIGILANCIA.png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 133;
UPDATE instituicoes SET url_imagem = 'img/VIGILANCIA.png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 134;
UPDATE instituicoes SET url_imagem = 'img/VIGILANCIA.png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 135;
UPDATE instituicoes SET url_imagem = 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (4).png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 136;
UPDATE instituicoes SET url_imagem = 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (5).png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 142;
UPDATE instituicoes SET url_imagem = 'img/ChatGPT Image 28 de ago. de 2026, 14_09_49 (10).png', atualizado_em = '2026-08-28 00:00:00' WHERE id = 171;

COMMIT;
