Resumo das alterações aplicadas pelo assistente (não intrusivo)

Escopo
- Objetivo: padronizar e reparar o widget de `Configurações` nas páginas da interface, sem modificar `mapa_definitivo.html`.
- Alterações projetadas para serem não intrusivas e reversíveis.

Arquivos alterados
- `js/settings-widget.js`: Unificadas inicialização e bindings; adicionado `dataset.bound` para evitar listeners duplicados; sliders atualizam variáveis CSS imediatamente e persistem via `Accessibility.setValue(...)` com debounce de 150ms.
- Páginas HTML (injetado script e chamada de inicialização do widget):
  - `index3.html` (base canônico, sem mudanças funcionais necessárias)
  - `login.html`
  - `criar_nova_senha.html`
  - `catalogo_uni.html`
  - `medicamentos.html`
  - `recuperar_senha.html`
  - `configuracoes.html`
  - `configuracoes.html` está aberta no editor neste momento.
- Não foi alterado: `mapa_definitivo.html`.

Principais correções
- Evitar travamento dos sliders:
  - Atualização visual imediata através de variáveis CSS (sem bloqueio de render);
  - Debounce (150ms) para chamadas de persistência no módulo `Accessibility`.
- Corrigida posição do botão de `Configurações` para inserir no mesmo contêiner flex do `header` e antes do `#auth-button` quando presente.
- Inicialização padronizada: `Settings.load()` → `Theme.init()` → `Theme.apply()` → `Accessibility.initialize()` (ou `init`), garantindo paridade com `index3.html`.

Como reverter
- Remover o script de inicialização dos arquivos HTML alterados (localizar `SettingsWidget.init(...)`) e restaurar uma cópia anterior de `js/settings-widget.js` do controle de versão.

Próximos passos sugeridos
- Testar localmente as páginas listadas (especial atenção aos sliders: tamanho de fonte, espaçamento, escala).
- Se houver regressões, eu posso reverter partes específicas ou ajustar o debounce/optimizações.

Gerado por: Assistente de código (ação cautelosa, somente adições não intrusivas).