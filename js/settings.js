const Settings = (function(){
    const STORAGE_KEY = 'saudepira-settings-v1';
    const DEFAULTS = {
        language: 'pt',
        theme: 'default',
        accessibility: {
            readingMask: false,
            highContrast: false,
            readableFont: false,
            fontSize: 100,
            letterSpacing: 100,
            scale: 100,
            textAlign: 'default'
        }
    };

    let state = JSON.parse(JSON.stringify(DEFAULTS));

    function normalizeAccessibility(value) {
        const source = value && typeof value === 'object' ? value : {};
        return {
            readingMask: !!source.readingMask,
            highContrast: !!source.highContrast,
            readableFont: !!source.readableFont,
            fontSize: clampNumber(source.fontSize, 80, 160, DEFAULTS.accessibility.fontSize),
            letterSpacing: clampNumber(source.letterSpacing, 80, 200, DEFAULTS.accessibility.letterSpacing),
            scale: clampNumber(source.scale, 80, 140, DEFAULTS.accessibility.scale),
            textAlign: ['default', 'left', 'center', 'right'].includes(source.textAlign) ? source.textAlign : 'default'
        };
    }

    function clampNumber(value, min, max, fallback) {
        const number = Number(value);
        if (!Number.isFinite(number)) return fallback;
        return Math.min(max, Math.max(min, number));
    }

    function load(){
        return new Promise((resolve) => {
            try {
                const raw = localStorage.getItem(STORAGE_KEY);
                if (raw) {
                    const saved = JSON.parse(raw);
                    state = {
                        language: saved.language || DEFAULTS.language,
                        theme: ['default', 'light'].includes(saved.theme) ? saved.theme : DEFAULTS.theme,
                        accessibility: normalizeAccessibility(saved.accessibility)
                    };
                    // Regrava para remover opções antigas, como "lineHeight".
                    save();
                }
            } catch (error) {
                console.warn('Settings load failed', error);
                state = JSON.parse(JSON.stringify(DEFAULTS));
            }
            resolve();
        });
    }

    function save(){
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(state));
        } catch (error) {
            console.warn('Settings save failed', error);
        }
    }

    function reset(){
        state = JSON.parse(JSON.stringify(DEFAULTS));
        save();
    }

    return {
        get language() { return state.language; },
        set language(value) {
            state.language = value || 'pt';
            save();
        },
        get theme() { return state.theme; },
        set theme(value) {
            state.theme = ['default','light'].includes(value) ? value : 'default';
            save();
        },
        get accessibility() { return Object.assign({}, state.accessibility); },
        set accessibility(value) {
            state.accessibility = normalizeAccessibility(value);
            save();
        },
        load,
        save,
        reset
    };
})();

window.Settings = Settings;
