const App = (function(){
    const iconesPorEspecialidade = {
        'clinica': 'ph-stethoscope',
        'pediatria': 'ph-baby',
        'dentista': 'ph-tooth',
        'urgencia': 'ph-first-aid',
        'psicologia': 'ph-brain',
        'fisioterapia': 'ph-person-simple-run',
        'vacinacao': 'ph-syringe',
        'ginecologia': 'ph-gender-female',
        'cardiologia': 'ph-heartbeat',
        'ortopedia': 'ph-bone',
        'nutricao': 'ph-fork-knife',
        'farmacia': 'ph-pill',
        'odontologia': 'ph-tooth'
    };
    const coresPorEspecialidade = {
        'clinica': 'text-blue-400',
        'pediatria': 'text-cyan-400',
        'dentista': 'text-emerald-400',
        'urgencia': 'text-red-400',
        'psicologia': 'text-purple-400',
        'fisioterapia': 'text-orange-400',
        'vacinacao': 'text-teal-400',
        'ginecologia': 'text-pink-400',
        'cardiologia': 'text-rose-400',
        'ortopedia': 'text-yellow-400',
        'nutricao': 'text-lime-400',
        'farmacia': 'text-green-400',
        'odontologia': 'text-emerald-400'
    };
    const labelsPorEspecialidade = {
        'clinica': {pt:'Clínica', en:'Clinic'},
        'pediatria': {pt:'Pediatria', en:'Pediatrics'},
        'dentista': {pt:'Dentista', en:'Dentist'},
        'urgencia': {pt:'Urgência', en:'Emergency'},
        'psicologia': {pt:'Psicologia', en:'Psychology'},
        'fisioterapia': {pt:'Fisioterapia', en:'Physiotherapy'},
        'vacinacao': {pt:'Vacinação', en:'Vaccination'},
        'ginecologia': {pt:'Ginecologia', en:'Gynecology'},
        'cardiologia': {pt:'Cardiologia', en:'Cardiology'},
        'ortopedia': {pt:'Ortopedia', en:'Orthopedics'},
        'nutricao': {pt:'Nutrição', en:'Nutrition'},
        'farmacia': {pt:'Farmácia', en:'Pharmacy'},
        'odontologia': {pt:'Odontologia', en:'Odontology'}
    };

    const coresPorCategoria = {
        'UBS': 'bg-blue-500/20 text-blue-200 border-blue-500/30',
        'USF': 'bg-emerald-500/15 text-emerald-200 border-emerald-500/30',
        'UPA / Urgência': 'bg-rose-500/15 text-rose-200 border-rose-500/30',
        'Farmácia': 'bg-lime-500/15 text-lime-200 border-lime-500/30',
        'COTE': 'bg-violet-500/15 text-violet-200 border-violet-500/30',
        'SAMU': 'bg-orange-500/15 text-orange-200 border-orange-500/30',
        'Urgência Bucal': 'bg-amber-500/15 text-amber-200 border-amber-500/30',
        'Serviços Especializados': 'bg-sky-500/15 text-sky-200 border-sky-500/30',
        'Programas e Apoio': 'bg-slate-500/15 text-slate-200 border-slate-500/30',
        'Outros Serviços': 'bg-slate-700/15 text-slate-200 border-slate-700/30'
    };

    const imagensPorCategoria = {
        'UBS': 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=900&q=80',
        'USF': 'https://images.unsplash.com/photo-1631217b5f35-c903400b2315?auto=format&fit=crop&w=900&q=80',
        'UPA / Urgência': 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=900&q=80',
        'Farmácia': 'https://images.unsplash.com/photo-1552318949-67b8c6bea38a?auto=format&fit=crop&w=900&q=80',
        'COTE': 'https://images.unsplash.com/photo-1633356122544-f134324ef6db?auto=format&fit=crop&w=900&q=80',
        'SAMU': 'https://images.unsplash.com/photo-1587745416684-47e87dc00e57?auto=format&fit=crop&w=900&q=80',
        'Urgência Bucal': 'https://images.unsplash.com/photo-1606811841689-23def461ba6f?auto=format&fit=crop&w=900&q=80',
        'Serviços Especializados': 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=900&q=80',
        'Programas e Apoio': 'https://images.unsplash.com/photo-1590909691063-dd70bb236b86?auto=format&fit=crop&w=900&q=80',
        'Outros Serviços': 'https://images.unsplash.com/photo-1576091160675-112163c7f1ca?auto=format&fit=crop&w=900&q=80'
    };

    function definirCategoria(unidade) {
        const nome = normalizarTexto(unidade.nome || '');
        const especialidades = normalizarTexto(unidade.especialidades || '');
        const localizacao = normalizarTexto(unidade.localizacao || unidade.endereco || '');

        if (nome.includes('cote')) return 'COTE';
        if (nome.includes('samu')) return 'SAMU';
        if (nome.includes('sub')) return 'Urgência Bucal';
        if (nome.includes('upa') || especialidades.includes('urgencia') || especialidades.includes('emergencia')) return 'UPA / Urgência';
        if (nome.includes('farmacia')) return 'Farmácia';
        if (nome.includes('ubs')) return 'UBS';
        if (nome.includes('usf')) return 'USF';
        if (nome.includes('laboratorio') || nome.includes('laboratório') || nome.includes('cedic') || nome.includes('nasi') || nome.includes('fisioterapia') || nome.includes('reabilit') || nome.includes('capsad') || nome.includes('cerest') || nome.includes('visa') || nome.includes('servico social') || nome.includes('sa c') || nome.includes('pade') || nome.includes('consultorio na rua')) return 'Serviços Especializados';
        if (nome.includes('programa') || nome.includes('pad') || nome.includes('nucleo') || nome.includes('centro de referencia') || nome.includes('centro de atencao') || nome.includes('servico social') || nome.includes('vigilancia')) return 'Programas e Apoio';
        if (especialidades.includes('odontologia') || especialidades.includes('dentista')) return 'Urgência Bucal';
        if (especialidades.includes('farmacia') || especialidades.includes('medicamentos')) return 'Farmácia';
        return 'Outros Serviços';
    }

    function obterImagemPorCategoria(categoria) {
        return imagensPorCategoria[categoria] || 'https://images.unsplash.com/photo-1491897554428-130a60dd4757?auto=format&fit=crop&w=900&q=80';
    }

    let unidades = [];
    let filtrosDisponiveis = [];
    let filtroAtivo = 'todos';
    let currentUser = null;

    function normalizarTexto(texto) {
        return String(texto || '')
            .toLowerCase()
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .replace(/[^a-z0-9\s]/g, ' ')
            .replace(/\s+/g, ' ')
            .trim();
    }

    function extrairEspecialidades(texto) {
        const textoNormalizado = normalizarTexto(texto);
        const regras = [
            { key: 'clinica', padroes: ['clinica', 'clinico', 'clinica medica', 'clinica medica'] },
            { key: 'ginecologia', padroes: ['ginecologia'] },
            { key: 'pediatria', padroes: ['pediatria'] },
            { key: 'odontologia', padroes: ['odontologia', 'odontologica'] },
            { key: 'urgencia', padroes: ['urgencia', 'emergencia'] },
            { key: 'psicologia', padroes: ['psicologia'] },
            { key: 'fisioterapia', padroes: ['fisioterapia'] },
            { key: 'vacinacao', padroes: ['vacinacao', 'vacina'] },
            { key: 'cardiologia', padroes: ['cardiologia'] },
            { key: 'ortopedia', padroes: ['ortopedia'] },
            { key: 'nutricao', padroes: ['nutricao'] },
            { key: 'farmacia', padroes: ['farmacia'] },
            { key: 'dentista', padroes: ['dentista', 'dentaria', 'dental'] }
        ];

        return regras
            .filter(regra => regra.padroes.some(p => textoNormalizado.includes(p)))
            .map(regra => regra.key);
    }

    async function carregarDadosDoBanco(){
        try{
            const lang = 'pt'; // Portuguese only
            const response = await fetch(`get_unidades.php?lang=${lang}`);
            if(!response.ok) throw new Error('Erro na requisição');
            let dados = await response.json();
            // Support older API format and new
            if(dados.success && dados.data) dados = dados.data;
            unidades = dados.map(u=>{
                const espRaw = u.especialidades || '';
                const listaEsp = extrairEspecialidades(espRaw);
                const tags = listaEsp.map(chave=>{
                    const lbl = labelsPorEspecialidade[chave];
                    return lbl ? lbl.pt : chave;
                });
                const categoria = definirCategoria(u);
                return {
                    nome: u.nome || 'Unidade sem nome',
                    endereco: u.localizacao || u.endereco || 'Endereço não informado',
                    nota: 4.8,
                    aberto: true,
                    badge: u.horario_atendimento || u.horario || '',
                    tags,
                    esp: listaEsp,
                    categoria,
                    img: obterImagemPorCategoria(categoria),
                    lat: u.lat || u.latitude,
                    lng: u.lng || u.longitude
                };
            });

            const contagemEspecialidades = {};
            unidades.forEach(u=>{ u.esp.forEach(e=>{ contagemEspecialidades[e] = (contagemEspecialidades[e]||0)+1; }); });
            filtrosDisponiveis = Object.entries(contagemEspecialidades).filter(([,c])=>c>=2).map(([k])=>({ key:k, label:(labelsPorEspecialidade[k]?labelsPorEspecialidade[k].pt:k), icon: iconesPorEspecialidade[k]||'ph-tag', color: coresPorEspecialidade[k]||'text-slate-300' })).sort((a,b)=>a.label.localeCompare(b.label));

            renderFiltros(); aplicarFiltros();
        }catch(e){ console.error(e); }
    }

    function checkLogin(){
        const user = sessionStorage.getItem('currentUser');
        if(user){ currentUser = JSON.parse(user); updateAuthUI(); }
    }

    function updateAuthUI(){
        const authButton = document.getElementById('auth-button');
        const userGreeting = document.getElementById('user-greeting');
        if(currentUser && userGreeting){ authButton.classList.add('hidden'); userGreeting.classList.remove('hidden'); document.getElementById('user-name').textContent = currentUser.nome.split(' ')[0]; document.getElementById('user-initial').textContent = currentUser.nome.charAt(0).toUpperCase(); }
    }

    function handleLogout(){ sessionStorage.removeItem('currentUser'); window.location.reload(); }

    function toggleSettingsPanel(){
        const panel = document.getElementById('settings-panel');
        const button = document.getElementById('settings-toggle');
        const isOpen = panel.classList.toggle('open');
        panel.classList.toggle('hidden', !isOpen);
        button.setAttribute('aria-expanded', isOpen);
    }

    function setTheme(theme){
        Theme.apply(theme);
    }

    function renderFiltros(){
        const c = document.getElementById('filtros-container'); if(!c) return; c.innerHTML='';
        const botoes = [ { key:'todos', label:'Ver Todos', icon:'ph-squares-four', color:'text-white' }, ...filtrosDisponiveis ];
        botoes.forEach(e=>{ const ativo = filtroAtivo===e.key; const btn = document.createElement('button'); btn.className = `category-card min-w-[110px] glass p-5 rounded-2xl flex flex-col items-center gap-3 transition-all border ${ativo ? 'active border-blue-500/50 bg-blue-500/10' : 'border-transparent'}`; btn.innerHTML = `<i class="ph ${e.icon} text-3xl ${e.color}"></i><span class="text-sm font-medium">${e.label}</span>`; btn.onclick = ()=>{ filtroAtivo = e.key; renderFiltros(); aplicarFiltros(); }; c.appendChild(btn); });
    }

    function aplicarFiltros(){
        const termo = (document.getElementById('search-input')?.value || '').toLowerCase().trim();
        const resultado = unidades.filter(u=>{ const matchEsp = filtroAtivo==='todos' || u.esp.includes(filtroAtivo); const matchSearch = !termo || u.nome.toLowerCase().includes(termo) || u.tags.some(t=>t.toLowerCase().includes(termo)); return matchEsp && matchSearch; });
        renderCards(resultado, getFavorites());
    }

    function getFavorites(){ if(!currentUser) return []; return JSON.parse(localStorage.getItem(`fav-${currentUser.email}`)) || []; }
    function toggleFavorite(nome){ if(!currentUser){ window.location.href='login.html'; return; } let favs = getFavorites(); favs = favs.includes(nome)?favs.filter(f=>f!==nome):[...favs,nome]; localStorage.setItem(`fav-${currentUser.email}`, JSON.stringify(favs)); aplicarFiltros(); }

    function renderCards(lista, favs=[]){
        const c = document.getElementById('cards-container');
        const nr = document.getElementById('no-results');
        if(!c) return;
        c.innerHTML = '';
        if(!lista.length){ nr.classList.remove('hidden'); return; }
        nr.classList.add('hidden');

        lista.forEach(u=>{
            const isFav = favs.includes(u.nome);
            const categoryChipClass = coresPorCategoria[u.categoria] || 'bg-slate-900/70 text-white border-white/10';
            const div = document.createElement('div');
            div.className = 'unit-card group relative glass rounded-3xl overflow-hidden transition-all hover:ring-2 hover:ring-blue-500/50';
            div.innerHTML = `
                <div class="h-48 bg-slate-800 relative">
                    <img src="${u.img}" class="w-full h-full object-cover opacity-70" alt="${u.nome}">
                    <div class="absolute inset-0 bg-gradient-to-t from-slate-950/90 via-slate-950/20 to-transparent"></div>
                    <div class="absolute top-4 left-4 rounded-full border px-3 py-1 text-[11px] font-semibold ${categoryChipClass}">${u.categoria}</div>
                    <div class="absolute top-4 right-4 bg-white/10 p-2 rounded-full" aria-label="favoritar">
                        <button class="fav-btn" type="button">
                            <i class="ph ${isFav ? 'ph-fill ph-heart text-red-500' : 'ph ph-heart text-white'} text-lg"></i>
                        </button>
                    </div>
                    <div class="absolute bottom-4 left-4 bg-blue-600 text-white text-[10px] font-bold px-2 py-1 rounded">${u.badge}</div>
                </div>
                <div class="p-6">
                    <h3 class="font-bold text-xl">${u.nome}</h3>
                    <p class="text-slate-400 text-sm mb-4">${u.endereco}</p>
                    <div class="flex flex-wrap gap-2">${u.tags.map(t=>`<span class="text-[10px] bg-slate-700 px-2 py-1 rounded text-slate-300">${t}</span>`).join('')}</div>
                    <a href="mapa_definitivo.html?lat=${u.lat}&lng=${u.lng}" class="mt-6 w-full py-3 bg-white/5 border border-white/10 rounded-xl font-semibold flex items-center justify-center gap-2 text-white no-underline">
                        <i class="ph ph-map-trifold"></i> Ver no Mapa
                    </a>
                </div>`;
            c.appendChild(div);
            const favBtn = div.querySelector('.fav-btn');
            if(favBtn){ favBtn.addEventListener('click', ()=>{ toggleFavorite(u.nome); // refresh UI for current results
                const updatedFavs = getFavorites(); renderCards(lista, updatedFavs); }); }
        });
    }

    function openSidebar(){ document.getElementById('sidebar-overlay').classList.replace('opacity-0','opacity-100'); document.getElementById('sidebar-overlay').classList.remove('pointer-events-none'); document.getElementById('sidebar-drawer').classList.replace('-translate-x-full','translate-x-0'); }
    function closeSidebar(){ document.getElementById('sidebar-overlay').classList.replace('opacity-100','opacity-0'); document.getElementById('sidebar-overlay').classList.add('pointer-events-none'); document.getElementById('sidebar-drawer').classList.replace('translate-x-0','-translate-x-full'); }

    function resetSettings(){
        Settings.reset();
        location.reload();
    }

    async function start(){
        await Settings.load();
        Theme.init();
        Theme.apply(Settings.theme);
        if (window.UnityAccessibility) {
            UnityAccessibility.initialize();
        } else if (window.Accessibility) {
            Accessibility.init();
        }
        if (window.I18n) {
            I18n.applyLanguage(Settings.language);
        }
        checkLogin();
        renderFiltros();
        carregarDadosDoBanco();
        bindUI();
    }

    function bindUI(){
        document.getElementById('settings-toggle').addEventListener('click', toggleSettingsPanel);
        document.querySelectorAll('[data-theme]').forEach(btn => {
            btn.addEventListener('click', () => {
                Theme.apply(btn.getAttribute('data-theme'));
            });
        });
        document.getElementById('reset-settings')?.addEventListener('click', resetSettings);
        document.getElementById('search-input')?.addEventListener('input', aplicarFiltros);
    }

    // Expose some helpers globally for existing inline handlers and compatibility
    window.toggleSettingsPanel = toggleSettingsPanel;
    window.openSidebar = openSidebar;
    window.closeSidebar = closeSidebar;
    window.handleLogout = handleLogout;
    window.toggleFavorite = toggleFavorite;
    window.aplicarFiltros = aplicarFiltros;
    window.resetSettings = resetSettings;

    return { start, setTheme };
})();
