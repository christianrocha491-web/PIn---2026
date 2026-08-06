-- Consolida unidades que compartilham a mesma localização em uma única unidade
-- mantendo o registro com menor id e unindo os nomes com " e "

SET NAMES utf8mb4;

UPDATE instituicoes SET nome = 'Núcleo de Atendimento à Saúde do Idoso (NASI) SUL e Programa de Atenção Domiciliar (PAD) e Centro de Atenção em Reabilitação Especial (Fisioterapia)' WHERE id = 119;
DELETE FROM instituicoes WHERE id IN (120, 140);

UPDATE instituicoes SET nome = 'Vigilância Epidemiológica (VE) e Centro de Referência em Saúde do Trabalhador (CEREST) e Vigilância Sanitária Municipal (VISA)' WHERE id = 133;
DELETE FROM instituicoes WHERE id IN (134, 135);

UPDATE instituicoes SET nome = 'Centro de Especialidades Médicas e Serviço Social da Saúde e Farmácia Central' WHERE id = 117;
DELETE FROM instituicoes WHERE id IN (139, 148);

UPDATE instituicoes SET nome = 'UBS Cecap e USF Eldorado I' WHERE id = 48;
DELETE FROM instituicoes WHERE id IN (70);

UPDATE instituicoes SET nome = 'Central de Relacionamento com o Usuário SUS (Centrus) e S.A.C – Serviço de Avaliação e Controle' WHERE id = 137;
DELETE FROM instituicoes WHERE id IN (138);

UPDATE instituicoes SET nome = 'Centro de Atenção Psicossocial Bela Vista (CAPS II - Bela Vista) e Consultório na Rua' WHERE id = 128;
DELETE FROM instituicoes WHERE id IN (132);

UPDATE instituicoes SET nome = 'Policlínica Dr. Antônio Haddad Dib - Santa Teresinha e Farmácia Vila Sônia' WHERE id = 113;
DELETE FROM instituicoes WHERE id IN (168);

UPDATE instituicoes SET nome = 'Centro Especializado em Saúde da Mulher (CESM) e Centro de Atenção a Saúde do Adolescente de Piracicaba (CASAP)' WHERE id = 114;
DELETE FROM instituicoes WHERE id IN (115);
