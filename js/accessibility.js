const UnityAccessibility = (function(){
    const DEFAULTS = {
        readingMask: false,
        highContrast: false,
        readableFont: false,
        fontSize: 100,
        letterSpacing: 100,
        scale: 100,
        textAlign: 'default'
    };

    let settings = Object.assign({}, DEFAULTS);
    let initialized = false;
    let maskTop = null;
    let maskBottom = null;
    let maskY = Math.round(window.innerHeight / 2);
    let visualFrame = 0;
    const MASK_HALF_HEIGHT = 62;

    function initialize(){
        settings = Object.assign({}, DEFAULTS, Settings.accessibility);
        ensureReadingMask();
        applyAll();
        bindUI();

        if (!initialized) {
            document.addEventListener('mousemove', handlePointerMove, { passive: true });
            document.addEventListener('touchmove', handleTouchMove, { passive: true });
            window.addEventListener('resize', updateReadingMask, { passive: true });
            initialized = true;
        }
    }

    function bindUI(){
        document.querySelectorAll('[data-accessibility]').forEach(el => {
            if (el.dataset.accBound === '1') return;
            el.dataset.accBound = '1';
            el.addEventListener('click', () => {
                const key = el.getAttribute('data-accessibility');
                if (['readingMask', 'highContrast', 'readableFont'].includes(key)) toggle(key);
            });
        });

        ['fontSize','letterSpacing','scale'].forEach(key => {
            const el = document.getElementById('acc-' + key);
            if (!el) return;
            el.value = settings[key] || DEFAULTS[key];
            updateRangeOutput(key, el.value);
            if (el.dataset.accBound === '1') return;
            el.dataset.accBound = '1';

            // Durante o arraste, atualiza apenas o visual no próximo frame.
            // Evita gravar no localStorage e reprocessar todo o painel a cada pixel.
            el.addEventListener('input', event => {
                settings[key] = Number(event.target.value);
                updateRangeOutput(key, event.target.value);
                scheduleVisualApply();
            });

            // Persiste apenas quando o usuário termina a alteração.
            el.addEventListener('change', () => {
                persist();
                applyAll();
            });
        });

        document.querySelectorAll('[data-align]').forEach(el => {
            if (el.dataset.accBound === '1') return;
            el.dataset.accBound = '1';
            el.addEventListener('click', () => {
                settings.textAlign = el.getAttribute('data-align') || 'default';
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

    function applyVisualSettings(){
        // Calculado em JS para evitar calc() com multiplicação, que falhava em alguns navegadores.
        const combinedScale = (Number(settings.fontSize) * Number(settings.scale)) / 100;
        const letterSpacingEm = ((Number(settings.letterSpacing) - 100) / 100) * 0.06;
        document.documentElement.style.setProperty('--acc-root-font-size', `${combinedScale}%`);
        document.documentElement.style.setProperty('--acc-letter-spacing-value', `${letterSpacingEm.toFixed(4)}em`);
    }

    function scheduleVisualApply(){
        if (visualFrame) return;
        visualFrame = window.requestAnimationFrame(() => {
            visualFrame = 0;
            applyVisualSettings();
        });
    }

    function applyAll(){
        if (!document.body) return;

        document.body.classList.toggle('reading-mask', !!settings.readingMask);
        document.body.classList.toggle('high-contrast', !!settings.highContrast);
        document.body.classList.toggle('readable-fonts', !!settings.readableFont);

        applyVisualSettings();

        document.body.classList.remove('align-left','align-center','align-right');
        if (['left','center','right'].includes(settings.textAlign)) {
            document.body.classList.add('align-' + settings.textAlign);
        }

        ensureReadingMask();
        updateReadingMask();
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

        ['fontSize','letterSpacing','scale'].forEach(key => {
            const el = document.getElementById('acc-' + key);
            if (el && document.activeElement !== el) el.value = settings[key];
            updateRangeOutput(key, settings[key]);
        });
    }

    function updateRangeOutput(key, value) {
        const output = document.querySelector(`[data-range-value="${key}"]`);
        if (output) output.textContent = `${Math.round(Number(value))}%`;
    }

    function ensureReadingMask() {
        if (maskTop && maskBottom) return;
        maskTop = document.getElementById('reading-mask-top');
        maskBottom = document.getElementById('reading-mask-bottom');

        if (!maskTop) {
            maskTop = document.createElement('div');
            maskTop.id = 'reading-mask-top';
            maskTop.className = 'reading-mask-shade reading-mask-shade-top';
            maskTop.setAttribute('aria-hidden', 'true');
            document.body.appendChild(maskTop);
        }
        if (!maskBottom) {
            maskBottom = document.createElement('div');
            maskBottom.id = 'reading-mask-bottom';
            maskBottom.className = 'reading-mask-shade reading-mask-shade-bottom';
            maskBottom.setAttribute('aria-hidden', 'true');
            document.body.appendChild(maskBottom);
        }
    }

    function handlePointerMove(event) {
        maskY = event.clientY;
        updateReadingMask();
    }

    function handleTouchMove(event) {
        if (!event.touches || !event.touches[0]) return;
        maskY = event.touches[0].clientY;
        updateReadingMask();
    }

    function updateReadingMask() {
        if (!maskTop || !maskBottom) return;
        const enabled = !!settings.readingMask;
        maskTop.style.display = enabled ? 'block' : 'none';
        maskBottom.style.display = enabled ? 'block' : 'none';
        if (!enabled) return;

        const viewportHeight = window.innerHeight || document.documentElement.clientHeight;
        const center = Math.min(viewportHeight, Math.max(0, maskY));
        const topHeight = Math.max(0, center - MASK_HALF_HEIGHT);
        const bottomTop = Math.min(viewportHeight, center + MASK_HALF_HEIGHT);

        maskTop.style.height = `${topHeight}px`;
        maskBottom.style.top = `${bottomTop}px`;
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

    function getSettings(){ return Object.assign({}, settings); }

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
