(function(){
    const PANEL_ID = 'settings-panel';
    const BUTTON_ID = 'settings-toggle';

    function gearIcon(){
        return '<svg viewBox="0 0 24 24" width="20" height="20" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.7 1.7 0 0 0 .34 1.88l.06.06-2.83 2.83-.06-.06A1.7 1.7 0 0 0 15 19.4a1.7 1.7 0 0 0-1 .6 1.7 1.7 0 0 0-.4 1.1V21h-4v-.09A1.7 1.7 0 0 0 8.6 19.4a1.7 1.7 0 0 0-1.88.34l-.06.06-2.83-2.83.06-.06A1.7 1.7 0 0 0 4.6 15a1.7 1.7 0 0 0-.6-1 1.7 1.7 0 0 0-1.1-.4H3v-4h.09A1.7 1.7 0 0 0 4.6 8.6a1.7 1.7 0 0 0-.34-1.88l-.06-.06 2.83-2.83.06.06A1.7 1.7 0 0 0 9 4.6a1.7 1.7 0 0 0 1-.6 1.7 1.7 0 0 0 .4-1.1V3h4v.09A1.7 1.7 0 0 0 15.4 4.6a1.7 1.7 0 0 0 1.88-.34l.06-.06 2.83 2.83-.06.06A1.7 1.7 0 0 0 19.4 9c.13.36.34.7.6 1 .3.3.7.44 1.1.4H21v4h-.09a1.7 1.7 0 0 0-1.51.6Z"></path></svg>';
    }

    function buildUI(){
        if (document.getElementById(BUTTON_ID)) return;
        if (document.body && document.body.hasAttribute('data-settings-inline')) return;

        const wrapper = document.createElement('div');
        wrapper.id = 'site-settings';
        wrapper.className = 'site-settings';
        wrapper.innerHTML = `
            <button id="${BUTTON_ID}" class="site-settings-button" type="button" aria-expanded="false" aria-controls="${PANEL_ID}" aria-label="Abrir configurações">
                ${gearIcon()}
            </button>
            <section id="${PANEL_ID}" class="settings-panel hidden" aria-label="Configurações do site">
                <div class="settings-panel-header">
                    <div>
                        <p class="settings-eyebrow">Configurações</p>
                        <h2>Preferências do site</h2>
                    </div>
                    <button class="settings-close" type="button" aria-label="Fechar configurações">×</button>
                </div>

                <div class="settings-section">
                    <p class="settings-section-title">Tema</p>
                    <div class="settings-grid settings-grid-2">
                        <button type="button" data-theme="default" class="settings-theme-btn">Escuro</button>
                        <button type="button" data-theme="light" class="settings-theme-btn">Claro suave</button>
                    </div>
                </div>

                <div class="settings-section">
                    <p class="settings-section-title">Acessibilidade</p>
                    <div class="settings-grid settings-grid-2">
                        <button type="button" data-accessibility="readingMask" class="settings-toggle-btn">Máscara de leitura</button>
                        <button type="button" data-accessibility="highContrast" class="settings-toggle-btn">Alto contraste</button>
                        <button type="button" data-accessibility="readableFont" class="settings-toggle-btn">Fonte legível</button>
                    </div>

                    <div class="settings-range-list">
                        <label class="settings-range-row" for="acc-fontSize">
                            <span>Tamanho da fonte</span><output data-range-value="fontSize">100%</output>
                        </label>
                        <input id="acc-fontSize" type="range" min="80" max="160" value="100">

                        <label class="settings-range-row" for="acc-letterSpacing">
                            <span>Espaçamento das letras</span><output data-range-value="letterSpacing">100%</output>
                        </label>
                        <input id="acc-letterSpacing" type="range" min="80" max="200" value="100">

                        <label class="settings-range-row" for="acc-scale">
                            <span>Escala da interface</span><output data-range-value="scale">100%</output>
                        </label>
                        <input id="acc-scale" type="range" min="80" max="140" value="100">
                    </div>
                </div>

                <div class="settings-section">
                    <p class="settings-section-title">Alinhamento do conteúdo</p>
                    <div class="settings-grid settings-grid-3">
                        <button type="button" data-align="left" class="settings-action-btn">Esquerda</button>
                        <button type="button" data-align="center" class="settings-action-btn">Centro</button>
                        <button type="button" data-align="right" class="settings-action-btn">Direita</button>
                    </div>
                </div>

                <div class="settings-footer">
                    <button type="button" id="reset-settings" class="settings-reset">Redefinir configurações</button>
                </div>
            </section>`;

        mountInHeader(wrapper);
        bindPanelUI(wrapper);
    }

    function mountInHeader(wrapper){
        const catalogSlot = document.getElementById('settings-slot-catalog');
        if (catalogSlot && catalogSlot.parentElement) {
            catalogSlot.replaceWith(wrapper);
            return;
        }

        const markedAuthGroup = document.querySelector('[data-settings-auth-group]');
        const authButton = document.getElementById('auth-button');
        if (markedAuthGroup && authButton && authButton.parentElement === markedAuthGroup) {
            markedAuthGroup.insertBefore(wrapper, authButton);
            return;
        }

        if (authButton && authButton.parentElement) {
            authButton.parentElement.insertBefore(wrapper, authButton);
            return;
        }

        const homeSearch = document.getElementById('search-input');
        if (homeSearch) {
            const header = homeSearch.closest('header');
            if (header) {
                header.appendChild(wrapper);
                return;
            }
        }

        const catalogSearch = document.getElementById('searchInput');
        if (catalogSearch) {
            const row = catalogSearch.closest('.flex.items-center.gap-3');
            if (row) {
                row.appendChild(wrapper);
                return;
            }
        }

        const mapSearch = document.getElementById('map-search');
        if (mapSearch) {
            const header = mapSearch.closest('header');
            const rightGroup = header ? header.querySelector(':scope > .flex.items-center.gap-4:last-child') : null;
            if (rightGroup) {
                rightGroup.insertBefore(wrapper, rightGroup.firstChild);
                return;
            }
        }

        const simpleHeader = document.querySelector('header');
        if (simpleHeader) {
            const spacer = Array.from(simpleHeader.children).find(el => el.classList && el.classList.contains('w-8') && !el.children.length);
            if (spacer) {
                spacer.replaceWith(wrapper);
                return;
            }
            simpleHeader.appendChild(wrapper);
            return;
        }

        const navbar = document.querySelector('.navbar');
        if (navbar) {
            navbar.appendChild(wrapper);
            return;
        }

        // Fallback só para páginas sem qualquer barra superior.
        wrapper.classList.add('site-settings-fallback');
        document.body.appendChild(wrapper);
    }

    function bindPanelUI(wrapper){
        const button = wrapper.querySelector('#' + BUTTON_ID);
        const panel = wrapper.querySelector('#' + PANEL_ID);
        const close = wrapper.querySelector('.settings-close');

        function setOpen(open){
            panel.classList.toggle('hidden', !open);
            panel.classList.toggle('open', open);
            button.setAttribute('aria-expanded', String(open));
        }

        button.addEventListener('click', event => {
            event.stopPropagation();
            setOpen(!panel.classList.contains('open'));
        });
        close.addEventListener('click', () => setOpen(false));
        panel.addEventListener('click', event => event.stopPropagation());
        document.addEventListener('click', () => setOpen(false));
        document.addEventListener('keydown', event => {
            if (event.key === 'Escape') setOpen(false);
        });
    }

    // Liga os botões de tema e o botão de redefinir onde quer que estejam no
    // documento — dentro do widget flutuante (a maioria das páginas) ou
    // direto no conteúdo da página (configuracoes.html, que tem os controles
    // fixos em vez do popup). Guardado por dataset pra nunca ligar 2x o
    // mesmo elemento.
    function bindGlobalControls(){
        document.querySelectorAll('[data-theme]').forEach(btn => {
            if (btn.dataset.themeBound === '1') return;
            btn.dataset.themeBound = '1';
            btn.addEventListener('click', () => Theme.apply(btn.getAttribute('data-theme')));
        });

        document.querySelectorAll('#reset-settings').forEach(btn => {
            if (btn.dataset.resetBound === '1') return;
            btn.dataset.resetBound = '1';
            btn.addEventListener('click', () => {
                Settings.reset();
                Theme.apply(Settings.theme);
                if (window.UnityAccessibility) UnityAccessibility.initialize();
                if (window.I18n) I18n.applyLanguage(Settings.language);
            });
        });
    }

    async function initializeSettings(){
        await Settings.load();
        Theme.apply(Settings.theme);
        if (window.UnityAccessibility) UnityAccessibility.initialize();
        if (window.I18n) I18n.applyLanguage(Settings.language);
        bindGlobalControls();
    }

    function start(){
        buildUI();
        initializeSettings();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', start, { once: true });
    } else {
        start();
    }
})();