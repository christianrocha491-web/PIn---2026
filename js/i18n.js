const I18n = (function(){
    const translations = {
        en: {
            'nav.inicio': 'Home',
            'nav.ver_mapa': 'View Map',
            'nav.catalogo': 'Units Catalog',
            'nav.medicamentos': 'Medications',
            'header.title': 'Find care now.',
            'header.subtitle': 'Select a specialty to see the nearest units to you.',
            'search.placeholder': 'Search for units or specialties...',
            'button.sign_in': 'Sign In',
            'button.show_map': 'Show Map',
            'section.all_units': 'All available units',
            'filter.all': 'View All',
            'card.view_on_map': 'View on Map',
            'settings.title': 'Site Preferences',
            'settings.language': 'Language',
            'settings.theme': 'Theme',
            'settings.accessibility': 'Accessibility',
            'settings.reset': 'Reset Settings',
            'theme.default': 'Default',
            'theme.light': 'Light'
        },
        pt: {
            'nav.inicio': 'Início',
            'nav.ver_mapa': 'Ver Mapa',
            'nav.catalogo': 'Catálogo de Unidades',
            'nav.medicamentos': 'Anotar Medicamentos',
            'header.title': 'Encontre atendimento agora.',
            'header.subtitle': 'Selecione uma especialidade para ver as unidades mais próximas de você.',
            'search.placeholder': 'Buscar unidades ou especialidades...',
            'button.sign_in': 'Entrar',
            'button.show_map': 'Exibir Mapa',
            'section.all_units': 'Todas as unidades disponíveis',
            'filter.all': 'Ver Todos',
            'card.view_on_map': 'Ver no Mapa',
            'settings.title': 'Preferências do site',
            'settings.language': 'Idioma',
            'settings.theme': 'Tema',
            'settings.accessibility': 'Acessibilidade',
            'settings.reset': 'Redefinir configurações',
            'theme.default': 'Padrão',
            'theme.light': 'Claro'
        }
    };

    let current = 'pt';

    function t(key){
        return (translations[current] && translations[current][key]) || key;
    }

    function applyElement(el){
        const key = el.getAttribute('data-i18n');
        if(!key) return;
        if(el.tagName === 'INPUT' || el.tagName === 'TEXTAREA'){
            el.placeholder = t(key);
        } else {
            el.textContent = t(key);
        }
    }

    function applyLanguage(lang){
        current = lang || 'pt';
        document.querySelectorAll('[data-i18n]').forEach(applyElement);
        // special placeholders
        const search = document.getElementById('search-input');
        if(search) search.placeholder = t('search.placeholder');
        const authLink = document.querySelector('#auth-button a');
        if(authLink) authLink.textContent = t('button.sign_in');
        const mapLink = document.querySelector('a[href="mapa_definitivo.html"] span');
        if(mapLink) mapLink.textContent = t('button.show_map');
    }

    return { applyLanguage, t };
})();
