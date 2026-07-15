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
            lineHeight: 100,
            letterSpacing: 100,
            scale: 100,
            textAlign: 'left'
        }
    };

    let state = JSON.parse(JSON.stringify(DEFAULTS));

    function deepMerge(target, source) {
        Object.keys(source).forEach(key => {
            const sourceValue = source[key];
            if (sourceValue && typeof sourceValue === 'object' && !Array.isArray(sourceValue)) {
                target[key] = deepMerge(target[key] || {}, sourceValue);
            } else {
                target[key] = sourceValue;
            }
        });
        return target;
    }

    function load(){
        return new Promise((resolve) => {
            try {
                const raw = localStorage.getItem(STORAGE_KEY);
                if (raw) {
                    const saved = JSON.parse(raw);
                    state = deepMerge(JSON.parse(JSON.stringify(DEFAULTS)), saved);
                }
            } catch (error) {
                console.warn('Settings load failed', error);
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
        get language() {
            return state.language;
        },
        set language(value) {
            state.language = value || 'pt';
            save();
        },
        get theme() {
            return state.theme;
        },
        set theme(value) {
            state.theme = ['default','light'].includes(value) ? value : 'default';
            save();
        },
        get accessibility() {
            return state.accessibility;
        },
        set accessibility(value) {
            state.accessibility = deepMerge(JSON.parse(JSON.stringify(DEFAULTS.accessibility)), value || {});
            save();
        },
        load,
        save,
        reset
    };
})();

window.Settings = Settings;
