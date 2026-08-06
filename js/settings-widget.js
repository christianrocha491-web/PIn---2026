const SettingsWidget = (function() {
    const template = `
<div id="settings-widget" class="settings-widget">
    <button id="settings-toggle" type="button" class="bg-slate-800/80 hover:bg-slate-700 px-4 py-2 rounded-full text-slate-200 transition-colors flex items-center gap-2 flex-shrink-0" aria-expanded="false" aria-controls="settings-panel" aria-label="Abrir configurações">
        <i class="ph ph-gear text-lg" aria-hidden="true"></i>
    </button>
    <div id="settings-panel" class="settings-widget-panel hidden glass" role="dialog" aria-modal="false" aria-labelledby="settings-panel-title">
        <div class="settings-widget-panel-header">
            <div>
                <p class="settings-widget-panel-label">Configurações</p>
                <h3 id="settings-panel-title" class="settings-widget-panel-title">Preferências do site</h3>
            </div>
            <button type="button" class="settings-widget-close" aria-label="Fechar configurações">
                <i class="ph ph-x"></i>
            </button>
        </div>
        <div class="settings-widget-panel-body">
            <div class="settings-widget-section">
                <p class="settings-widget-section-title">Tema</p>
                <div class="settings-widget-button-row">
                    <button type="button" data-theme="default" class="settings-theme-btn">Padrão</button>
                    <button type="button" data-theme="light" class="settings-theme-btn">Claro</button>
                </div>
            </div>
            <div class="settings-widget-section">
                <p class="settings-widget-section-title">Acessibilidade</p>
                <div class="settings-widget-button-column">
                    <button type="button" data-accessibility="readingMask" class="settings-toggle-btn">Máscara de leitura</button>
                    <button type="button" data-accessibility="highContrast" class="settings-toggle-btn">Alto contraste</button>
                    <button type="button" data-accessibility="readableFont" class="settings-toggle-btn">Fonte legível</button>
                </div>
                <div class="settings-widget-slider-group">
                    <label for="acc-fontSize">Tamanho da fonte</label>
                    <input id="acc-fontSize" type="range" min="80" max="160" value="100">
                    <label for="acc-lineHeight">Altura da linha</label>
                    <input id="acc-lineHeight" type="range" min="80" max="200" value="100">
                    <label for="acc-letterSpacing">Espaçamento entre letras</label>
                    <input id="acc-letterSpacing" type="range" min="80" max="200" value="100">
                    <label for="acc-scale">Dimensionamento do conteúdo</label>
                    <input id="acc-scale" type="range" min="80" max="140" value="100">
                </div>
                <div class="settings-widget-button-row">
                    <button type="button" data-align="left" class="settings-action-btn">Alinhar à esquerda</button>
                    <button type="button" data-align="center" class="settings-action-btn">Centralizar</button>
                    <button type="button" data-align="right" class="settings-action-btn">Alinhar à direita</button>
                </div>
            </div>
            <div class="settings-widget-panel-footer">
                <button type="button" id="reset-settings" class="settings-widget-reset">Redefinir configurações</button>
            </div>
        </div>
    </div>
</div>
`;

    const style = `
#settings-widget {
    position: relative;
    display: inline-flex;
    align-items: center;
    gap: 0.75rem;
    margin-left: auto;
    z-index: 100;
}

.settings-widget-host {
    position: relative;
}

#settings-widget .settings-widget-toggle {
    border: none;
    background: rgba(15, 23, 42, 0.9);
    color: #f8fafc;
    border-radius: 9999px;
    padding: 0.75rem 1rem;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    cursor: pointer;
    transition: background 0.2s ease, transform 0.2s ease;
    font-size: 1rem;
}

#settings-widget .settings-widget-toggle:hover {
    background: rgba(51, 65, 85, 0.95);
}

#settings-widget .settings-widget-icon {
    font-size: 1.1rem;
}

#settings-widget .settings-widget-panel {
    position: absolute;
    top: 100%;
    right: 0;
    width: min(360px, calc(100vw - 2rem));
    background: rgba(15, 23, 42, 0.98);
    backdrop-filter: blur(24px);
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 1.5rem;
    box-shadow: 0 28px 90px rgba(0, 0, 0, 0.3);
    z-index: 60;
    transform-origin: top right;
    opacity: 0;
    pointer-events: none;
    transform: scale(0.95);
    transition: opacity 0.2s ease, transform 0.2s ease;
}

#settings-widget .settings-widget-panel.open {
    opacity: 1;
    pointer-events: auto;
    transform: scale(1);
}

#settings-widget .settings-widget-panel.hidden {
    display: none !important;
}

#settings-widget .settings-widget-panel-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 1rem;
    padding: 1rem 1rem 0.75rem;
    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

#settings-widget .settings-widget-panel-label {
    margin: 0 0 0.25rem;
    font-size: 0.7rem;
    letter-spacing: 0.22em;
    text-transform: uppercase;
    color: #94a3b8;
}

#settings-widget .settings-widget-panel-title {
    margin: 0;
    font-size: 1rem;
    color: #ffffff;
    font-weight: 700;
}

#settings-widget .settings-widget-close {
    border: none;
    background: transparent;
    color: #cbd5e1;
    cursor: pointer;
    font-size: 1.1rem;
    padding: 0.4rem;
    line-height: 1;
}

#settings-widget .settings-widget-panel-body {
    padding: 1rem;
    display: grid;
    gap: 1rem;
}

#settings-widget .settings-widget-section {
    display: grid;
    gap: 0.75rem;
}

#settings-widget .settings-widget-section-title {
    margin: 0;
    font-size: 0.85rem;
    color: #cbd5e1;
    text-transform: uppercase;
    letter-spacing: 0.12em;
}

#settings-widget .settings-widget-button-row,
#settings-widget .settings-widget-button-column {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

#settings-widget .settings-widget-button-column {
    display: grid;
    grid-template-columns: 1fr;
}

#settings-widget .settings-theme-btn,
#settings-widget .settings-toggle-btn,
#settings-widget .settings-action-btn,
#settings-widget .settings-widget-reset {
    border: 1px solid rgba(255, 255, 255, 0.08);
    background: rgba(255, 255, 255, 0.04);
    color: #e2e8f0;
    border-radius: 1rem;
    cursor: pointer;
    padding: 0.75rem 0.85rem;
    font-size: 0.85rem;
    transition: background 0.2s ease, border-color 0.2s ease, color 0.2s ease;
}

#settings-widget .settings-theme-btn.active,
#settings-widget .settings-toggle-btn.active,
#settings-widget .settings-action-btn.active {
    background: rgba(59, 130, 246, 0.15);
    border-color: rgba(59, 130, 246, 0.4);
    color: #f8fafc;
}

#settings-widget .settings-widget-button-row {
    justify-content: flex-start;
}

#settings-widget input[type="range"] {
    width: 100%;
    accent-color: #3b82f6;
}

#settings-widget label {
    margin: 0;
    font-size: 0.75rem;
    color: #94a3b8;
}

#settings-widget .settings-widget-slider-group {
    display: grid;
    gap: 0.75rem;
}

#settings-widget .settings-widget-panel-footer {
    padding: 0 1rem 1rem;
}

#settings-widget .settings-widget-reset {
    width: 100%;
    background: transparent;
}

html {
    font-size: calc(var(--acc-font-size, 100) * var(--acc-scale, 100) / 100 * 1%);
}

body {
    line-height: calc(var(--acc-line-height, 100) / 100);
    letter-spacing: calc((var(--acc-letter-spacing, 100) - 100) * 0.05px);
}

body.theme-light {
    background-color: #f8fafc !important;
    color: #0f172a !important;
}

body.theme-light .glass {
    background: #ffffff !important;
    border-color: #e2e8f0 !important;
    color: #0f172a !important;
}

body.theme-light header {
    background: rgba(248,250,252,0.95) !important;
}

body.theme-light .text-white {
    color: #0f172a !important;
}

body.theme-light .text-slate-400 {
    color: #64748b !important;
}

body.theme-light .bg-slate-800\/50 {
    background-color: rgba(226,232,240,0.35) !important;
}

body.high-contrast {
    background-color: #050505 !important;
    color: #f8fafc !important;
}

body.high-contrast .glass,
body.high-contrast header,
body.high-contrast .settings-widget-panel,
body.high-contrast .category-card {
    background-color: #0b1120 !important;
    border-color: #ffffff !important;
    color: #f8fafc !important;
}

body.high-contrast .text-slate-400,
body.high-contrast .text-slate-300,
body.high-contrast .text-white {
    color: #dbeafe !important;
}

body.readable-fonts {
    font-family: 'Inter', Arial, Helvetica, sans-serif !important;
}

body.reading-mask main,
body.reading-mask .glass,
body.reading-mask .unit-card,
body.reading-mask .settings-widget-panel,
body.reading-mask .category-card {
    filter: saturate(1.05) brightness(1.08);
}

body.align-left main {
    text-align: left;
}

body.align-center main {
    text-align: center;
}

body.align-right main {
    text-align: right;
}

@media (max-width: 520px) {
    #settings-widget .settings-widget-panel {
        right: 50%;
        left: 50%;
        transform: translateX(50%);
        width: calc(100vw - 24px);
    }
}
`;

    function injectStyles() {
        if (document.getElementById('settings-widget-styles')) return;
        const styleElement = document.createElement('style');
        styleElement.id = 'settings-widget-styles';
        styleElement.textContent = style;
        document.head.appendChild(styleElement);
    }

    function bindEvents() {
        const toggleButton = document.getElementById('settings-toggle');
        const closeButton = document.querySelector('#settings-widget .settings-widget-close');
        const panel = document.getElementById('settings-panel');

        if (toggleButton) {
            toggleButton.addEventListener('click', (event) => {
                event.stopPropagation();
                toggleSettingsPanel();
            });
        }

        if (closeButton) {
            closeButton.addEventListener('click', (event) => {
                event.stopPropagation();
                closeSettingsPanel();
            });
        }

        document.addEventListener('click', (event) => {
            if (!document.getElementById('settings-widget')) return;
            if (!document.getElementById('settings-widget').contains(event.target)) {
                closeSettingsPanel();
            }
        });

        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape') {
                closeSettingsPanel();
            }
        });

        document.querySelectorAll('#settings-widget [data-theme]').forEach((button) => {
            if (button.dataset.bound) return;
            button.dataset.bound = '1';
            button.addEventListener('click', () => {
                if (window.Theme) {
                    Theme.apply(button.getAttribute('data-theme'));
                    updateThemeButtons();
                }
            });
        });

        // Guarded bindings for accessibility buttons (avoid duplicate handlers)
        document.querySelectorAll('#settings-widget [data-accessibility]').forEach((button) => {
            if (button.dataset.bound) return;
            button.dataset.bound = '1';
            button.addEventListener('click', () => {
                if (window.Accessibility && typeof Accessibility.toggleFeature === 'function') {
                    Accessibility.toggleFeature(button.getAttribute('data-accessibility'));
                    updateAccessibilityButtons();
                }
            });
        });

        // Guarded bindings for alignment buttons
        document.querySelectorAll('#settings-widget [data-align]').forEach((button) => {
            if (button.dataset.bound) return;
            button.dataset.bound = '1';
            button.addEventListener('click', () => {
                if (window.Accessibility && typeof Accessibility.setValue === 'function') {
                    Accessibility.setValue('textAlign', button.getAttribute('data-align'));
                    updateAccessibilityButtons();
                }
            });
        });

        // Guarded bindings for range inputs (font size, line height, etc.)
        document.querySelectorAll('#settings-widget input[type="range"]').forEach((input) => {
            if (input.dataset.bound) return;
            input.dataset.bound = '1';
            input.addEventListener('input', () => {
                const key = input.id.replace('acc-', '');
                const val = Number(input.value);

                // Immediate visual update via CSS variables to avoid UI jank
                try {
                    if (key === 'fontSize') document.documentElement.style.setProperty('--acc-font-size', String(val));
                    if (key === 'lineHeight') document.documentElement.style.setProperty('--acc-line-height', String(val));
                    if (key === 'letterSpacing') document.documentElement.style.setProperty('--acc-letter-spacing', String(val));
                    if (key === 'scale') document.documentElement.style.setProperty('--acc-scale', String(val));
                } catch (e) {
                    // ignore
                }

                // Debounce persistence and full apply to reduce repeated heavy ops
                if (input._debounceTimer) clearTimeout(input._debounceTimer);
                input._debounceTimer = setTimeout(() => {
                    if (window.Accessibility && typeof Accessibility.setValue === 'function') {
                        Accessibility.setValue(key, val);
                        updateAccessibilityButtons();
                    }
                }, 150);
            });
        });

        document.getElementById('reset-settings')?.addEventListener('click', () => {
            if (window.Settings) {
                Settings.reset();
            }
            if (window.Theme) {
                Theme.apply(Settings.theme || 'default');
            }
            if (window.Accessibility && typeof Accessibility.reset === 'function') {
                Accessibility.reset();
            }
            updateThemeButtons();
            updateAccessibilityButtons();
        });
    }

    function toggleSettingsPanel() {
        const panel = document.getElementById('settings-panel');
        const toggleButton = document.getElementById('settings-toggle');
        if (!panel || !toggleButton) return;

        const wasHidden = panel.classList.contains('hidden');
        panel.classList.toggle('hidden', !wasHidden);
        panel.classList.toggle('open', wasHidden);
        toggleButton.setAttribute('aria-expanded', String(wasHidden));
    }

    function closeSettingsPanel() {
        const panel = document.getElementById('settings-panel');
        const toggleButton = document.getElementById('settings-toggle');
        if (!panel || !toggleButton) return;

        panel.classList.add('hidden');
        panel.classList.remove('open');
        toggleButton.setAttribute('aria-expanded', 'false');
    }

    function updateThemeButtons() {
        document.querySelectorAll('#settings-widget [data-theme]').forEach((button) => {
            const theme = button.getAttribute('data-theme');
            const active = window.Settings ? Settings.theme === theme : false;
            button.classList.toggle('active', active);
            button.setAttribute('aria-pressed', String(active));
        });
    }

    function updateAccessibilityButtons() {
        const settings = window.Settings ? Settings.accessibility : null;
        if (!settings) return;

        document.querySelectorAll('#settings-widget [data-accessibility]').forEach((button) => {
            const key = button.getAttribute('data-accessibility');
            const active = !!settings[key];
            button.classList.toggle('active', active);
            button.setAttribute('aria-pressed', String(active));
        });

        document.querySelectorAll('#settings-widget [data-align]').forEach((button) => {
            const align = button.getAttribute('data-align');
            const active = settings.textAlign === align;
            button.classList.toggle('active', active);
            button.setAttribute('aria-pressed', String(active));
        });

        const elFont = document.getElementById('acc-fontSize'); if (elFont) elFont.value = String(settings.fontSize || 100);
        const elLine = document.getElementById('acc-lineHeight'); if (elLine) elLine.value = String(settings.lineHeight || 100);
        const elLetter = document.getElementById('acc-letterSpacing'); if (elLetter) elLetter.value = String(settings.letterSpacing || 100);
        const elScale = document.getElementById('acc-scale'); if (elScale) elScale.value = String(settings.scale || 100);
    }

    function initialize(options = {}) {
        injectStyles();

        const hostSelector = options.hostSelector || 'header, .navbar';
        const host = document.querySelector(hostSelector);
        if (!host) return;
        if (document.getElementById('settings-widget')) return;

        const flexChild = Array.from(host.children).find((child) => {
            if (!child.classList) return false;
            return Array.from(child.classList).some((cls) => cls === 'flex' || cls.startsWith('flex-'));
        });
        const container = flexChild || host;

        if (!container.classList.contains('settings-widget-host')) {
            container.classList.add('settings-widget-host');
        }

        const authButton = container.querySelector('#auth-button');
        if (authButton) {
            authButton.insertAdjacentHTML('beforebegin', template);
        } else {
            container.insertAdjacentHTML('beforeend', template);
        }
        bindEvents();

        async function initializeSettings() {
            if (window.Settings && typeof Settings.load === 'function') {
                await Settings.load();
            }

            if (window.Theme) {
                if (typeof Theme.init === 'function') {
                    Theme.init();
                }
                Theme.apply(Settings?.theme || 'default');
            }

            if (window.Accessibility) {
                if (typeof Accessibility.initialize === 'function') {
                    Accessibility.initialize();
                } else if (typeof Accessibility.init === 'function') {
                    Accessibility.init();
                }
            }

            updateThemeButtons();
            updateAccessibilityButtons();
        }

        initializeSettings();
    }

    return {
        init: initialize,
        toggleSettingsPanel,
        closeSettingsPanel
    };
})();

window.SettingsWidget = SettingsWidget;
