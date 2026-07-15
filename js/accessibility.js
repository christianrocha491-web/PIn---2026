const UnityAccessibility = (function(){
    const DEFAULTS = {
        readingMask: false,
        highContrast: false,
        readableFont: false,
        fontSize: 100,
        lineHeight: 100,
        letterSpacing: 100,
        scale: 100,
        textAlign: 'left'
    };

    let settings = Object.assign({}, DEFAULTS, Settings.accessibility);

    function initialize(){
        settings = Object.assign({}, DEFAULTS, Settings.accessibility);
        applyAll();
        bindUI();
    }

    function bindUI(){
        document.querySelectorAll('[data-accessibility]').forEach(el => {
            el.addEventListener('click', () => {
                const key = el.getAttribute('data-accessibility');
                if (['readingMask', 'highContrast', 'readableFont'].includes(key)) {
                    toggle(key);
                }
            });
        });

        ['fontSize','lineHeight','letterSpacing','scale'].forEach(key => {
            const el = document.getElementById('acc-' + key);
            if (!el) return;
            el.value = settings[key] || DEFAULTS[key];
            el.addEventListener('input', event => {
                settings[key] = Number(event.target.value);
                persist();
                applyAll();
            });
        });

        document.querySelectorAll('[data-align]').forEach(el => {
            el.addEventListener('click', () => {
                settings.textAlign = el.getAttribute('data-align') || 'left';
                persist();
                applyAll();
            });
        });

        updateControls();
    }

    function toggle(key){
        settings[key] = !settings[key];
        persist();
        applyAll();
    }

    function applyAll(){
        document.body.classList.toggle('reading-mask', !!settings.readingMask);
        document.body.classList.toggle('high-contrast', !!settings.highContrast);
        document.body.classList.toggle('readable-fonts', !!settings.readableFont);

        document.documentElement.style.setProperty('--acc-font-size', String(settings.fontSize));
        document.documentElement.style.setProperty('--acc-line-height', String(settings.lineHeight));
        document.documentElement.style.setProperty('--acc-letter-spacing', String(settings.letterSpacing));
        document.documentElement.style.setProperty('--acc-scale', String(settings.scale));

        document.body.classList.remove('align-left','align-center','align-right');
        document.body.classList.add('align-' + (settings.textAlign || 'left'));

        updateControls();
    }

    function persist(){
        Settings.accessibility = settings;
    }

    function updateControls(){
        document.querySelectorAll('[data-accessibility]').forEach(el => {
            const key = el.getAttribute('data-accessibility');
            if (['readingMask', 'highContrast', 'readableFont'].includes(key)) {
                el.classList.toggle('active', !!settings[key]);
                el.setAttribute('aria-pressed', String(!!settings[key]));
            }
        });

        document.querySelectorAll('[data-align]').forEach(el => {
            const align = el.getAttribute('data-align');
            el.classList.toggle('active', settings.textAlign === align);
            el.setAttribute('aria-pressed', String(settings.textAlign === align));
        });
    }

    function setValue(key, value){
        if (key in DEFAULTS) {
            settings[key] = value;
            persist();
            applyAll();
        }
    }

    function reset(){
        settings = Object.assign({}, DEFAULTS);
        persist();
        applyAll();
    }

    function getSettings(){
        return Object.assign({}, settings);
    }

    return {
        init: initialize,
        initialize,
        toggleFeature: toggle,
        setValue,
        reset,
        getSettings,
        settings
    };
})();

window.UnityAccessibility = UnityAccessibility;
window.Accessibility = UnityAccessibility;
