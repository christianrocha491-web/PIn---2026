const Theme = (function(){
    const THEMES = ['default','light'];

    function apply(theme){
        theme = THEMES.includes(theme) ? theme : 'default';
        document.documentElement.setAttribute('data-theme', theme);
        if (document.body) document.body.classList.toggle('theme-light', theme === 'light');
        Settings.theme = theme;
        updateThemeButtons();
    }

    function updateThemeButtons(){
        document.querySelectorAll('.settings-theme-btn').forEach(btn => {
            const value = btn.getAttribute('data-theme');
            btn.classList.toggle('active', Settings.theme === value);
            btn.setAttribute('aria-pressed', String(Settings.theme === value));
        });
    }

    function init(){ updateThemeButtons(); }

    return { apply, init, THEMES };
})();

window.Theme = Theme;
