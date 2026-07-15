-- Migration: Add English translation columns to `instituicoes` and populate examples
-- Run with: mysql -u <user> -p pin2026 < 2026_add_en_columns_and_examples.sql

START TRANSACTION;

-- Add new columns (nullable) to hold English translations
ALTER TABLE instituicoes
  ADD COLUMN nome_en TEXT NULL,
  ADD COLUMN localizacao_en TEXT NULL,
  ADD COLUMN especialidades_en TEXT NULL,
  ADD COLUMN horario_atendimento_en TEXT NULL,
  ADD COLUMN detalhes_en TEXT NULL;

-- Example translations (update rows by pattern when exact names exist)
-- Ajuste as cláusulas WHERE conforme necessário para casar com seus dados reais.

-- Exemplos para nomes de unidades
UPDATE instituicoes SET nome_en = 'Mental Health Clinic' WHERE nome LIKE '%Ambulatório de Saúde Mental%';
UPDATE instituicoes SET nome_en = 'Orthopedics and Trauma Center' WHERE nome LIKE '%Central de Ortopedia e Traumatologia%';
UPDATE instituicoes SET nome_en = 'Clinic' WHERE nome LIKE '%Clínica%';
UPDATE instituicoes SET nome_en = 'Emergency' WHERE nome LIKE '%Urgência%';

-- Exemplos para especialidades (transformações simples)
UPDATE instituicoes SET especialidades_en = REPLACE(especialidades, 'Clínica', 'Clinic') WHERE especialidades LIKE '%Clínica%';
UPDATE instituicoes SET especialidades_en = REPLACE(especialidades, 'Urgência', 'Emergency') WHERE especialidades LIKE '%Urgência%';
UPDATE instituicoes SET especialidades_en = REPLACE(especialidades, 'Pediatria', 'Pediatrics') WHERE especialidades LIKE '%Pediatria%';
UPDATE instituicoes SET especialidades_en = REPLACE(especialidades, 'Cardiologia', 'Cardiology') WHERE especialidades LIKE '%Cardiologia%';

-- Exemplos para horários e detalhes (ajuste manual após revisão)
UPDATE instituicoes SET horario_atendimento_en = 'Mon-Fri 08:00-17:00' WHERE horario_atendimento LIKE '%08:%';

-- Small convenience: if any _en column is still NULL, fill with the PT value as fallback
UPDATE instituicoes SET nome_en = nome WHERE nome_en IS NULL;
UPDATE instituicoes SET localizacao_en = localizacao WHERE localizacao_en IS NULL;
UPDATE instituicoes SET especialidades_en = especialidades WHERE especialidades_en IS NULL;
UPDATE instituicoes SET horario_atendimento_en = horario_atendimento WHERE horario_atendimento_en IS NULL;
UPDATE instituicoes SET detalhes_en = detalhes WHERE detalhes_en IS NULL;

COMMIT;

-- Notes:
-- 1) Inspect results with: SELECT id,nome,nome_en,especialidades,especialidades_en FROM instituicoes LIMIT 50;
-- 2) For better quality translations, export rows and translate using a translator workflow or a service, then run UPDATE statements per id.
-- 3) Alternatively create a normalized translation table if you prefer not to add columns per language.
