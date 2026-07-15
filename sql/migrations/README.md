Migrações SQL — instruções

Arquivo principal:
- 2026_add_en_columns_and_examples.sql

Objetivo:
- Adicionar colunas `*_en` na tabela `instituicoes` para permitir retornos em inglês via `?lang=en`.
- Inserir exemplos de traduções para algumas entradas comuns.
- Preencher automaticamente gaps com os valores em português como fallback.

Como executar (local):
1) Faça backup do banco antes de migrar:

```powershell
mysqldump -u root -p pin2026 > ../backups/pin2026-backup-before-i18n.sql
```

2) Execute a migração:

```powershell
mysql -u root -p pin2026 < sql/migrations/2026_add_en_columns_and_examples.sql
```

3) Verifique as traduções:

```sql
SELECT id, nome, nome_en, especialidades, especialidades_en FROM instituicoes LIMIT 100;
```

Recomendações:
- Revise manualmente as linhas atualizadas por padrão (especialmente `especialidades_en`) e corrija termos ambíguos.
- Para traduções em escala, exporte os textos e use um fluxo de tradução (Google Translate API, DeepL, ou processo humano), depois reimporte com UPDATE por `id`.
- Se preferir um modelo escalável com várias línguas, crie uma tabela `translations` normalizada em vez de colunas por idioma.
