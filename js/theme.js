const Theme = (function(){
    const THEMES = ['default','light'];

    function apply(theme){
        theme = THEMES.includes(theme) ? theme : 'default';
        document.documentElement.setAttribute('data-theme', theme);
        document.body.classList.toggle('theme-light', theme === 'light');
        Settings.theme = theme;
        updateThemeButtons();
    }

    function updateThemeButtons(){
        document.querySelectorAll('.settings-theme-btn').forEach(btn => {
            const v = btn.getAttribute('data-theme');
            btn.classList.toggle('active', Settings.theme === v);
            btn.setAttribute('aria-pressed', String(Settings.theme === v));
        });
    }

    function init(){
        updateThemeButtons();
    }

    return { apply, init, THEMES };
})();

window.Theme = Theme;
