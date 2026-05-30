/**
 * =====================================================
 * SISTEMA DE NAVEGAÇÃO INTERATIVA COM MAPA
 * Tecnologias: Leaflet.js, OpenStreetMap, OSRM, Geolocation API
 * =====================================================
 */

'use strict';

/**
 * Classe principal para gerenciar o sistema de navegação
 * Responsável por: mapa, marcadores, rotas, geolocalização
 */
class SistemaNavegacao {
    constructor() {
        // Configuração
        this.config = {
            zoom_inicial: 14,
            osrm_url: 'https://router.project-osrm.org/route/v1/driving',
            timeout_fetch: 10000,
            refresh_rota_intervalo: 5000, // ms
        };

        // Estado da aplicação
        this.estado = {
            mapa: null,
            usuario_localizacao: null,
            usuario_marcador: null,
            instituicoes: [],
            marcadores_instituicoes: new Map(),
            rota_ativa: null,
            controle_rota: null,
            intervalo_atualizacao: null,
            loading: false,
        };

        // Elementos do DOM
        this.elementos = {
            mapa_container: null,
            menu_toggle: null,
            sidebar: null,
            sidebar_close: null,
            route_panel: null,
            route_close: null,
            locate_button: null,
            search_bar: null,
            loading_overlay: null,
            toast_container: null,
        };

        // Inicializar a aplicação
        this.inicializar();
    }

    /**
     * Inicialização principal da aplicação
     */
    async inicializar() {
        console.log('🚀 Iniciando Sistema de Navegação...');

        try {
            // 1. Capturar elementos do DOM
            this.capturar_elementos_dom();

            // 2. Inicializar mapa Leaflet
            this.inicializar_mapa();

            // 3. Configurar event listeners
            this.configurar_eventos();

            // 4. Solicitar geolocalização do usuário
            await this.obter_localizacao_usuario();

            // 5. Carregar instituições do banco de dados
            await this.carregar_instituicoes();

            // 6. Adicionar marcadores das instituições ao mapa
            this.plotar_marcadores_instituicoes();

            // 7. Atualizar lista de instituições na sidebar
            this.atualizar_sidebar_instituicoes();

            console.log('✅ Sistema inicializado com sucesso!');
        } catch (erro) {
            console.error('❌ Erro ao inicializar:', erro);
            this.mostrar_toast('Erro ao inicializar o sistema', 'error');
        }
    }

    /**
     * Captura referências dos elementos do DOM
     */
    capturar_elementos_dom() {
        this.elementos = {
            mapa_container: document.getElementById('mapa'),
            menu_toggle: document.querySelector('.menu-toggle'),
            sidebar: document.querySelector('.sidebar'),
            sidebar_close: document.querySelector('.sidebar-close'),
            route_panel: document.querySelector('.route-panel'),
            route_close: document.querySelector('.route-close'),
            locate_button: document.querySelector('.locate-button'),
            search_bar: document.querySelector('.search-bar input'),
            loading_overlay: document.querySelector('.loading-overlay'),
            toast_container: document.querySelector('.toast-container'),
        };

        // Validar se todos os elementos foram encontrados
        if (!this.elementos.mapa_container) {
            throw new Error('Elemento #mapa não encontrado no DOM');
        }
    }

    /**
     * Inicializa o mapa com Leaflet + OpenStreetMap
     */
    inicializar_mapa() {
        console.log('🗺️  Inicializando Leaflet...');

        // Criar mapa centralizado em Piracicaba-SP
        const piracicaba = [-22.726226, -47.649373];
        this.estado.mapa = L.map(this.elementos.mapa_container).setView(
            piracicaba,
            this.config.zoom_inicial
        );

        // Adicionar tiles do OpenStreetMap
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors',
            maxZoom: 19,
            minZoom: 10,
        }).addTo(this.estado.mapa);

        // Garantir que o mapa seja renderizado corretamente após o layout final estar pronto
        this.estado.mapa.whenReady(() => {
            setTimeout(() => this.estado.mapa.invalidateSize(), 50);
        });

        // Customizar ícone padrão do Leaflet
        this.customizar_icones_padrao();
    }

    /**
     * Customiza os ícones do Leaflet para um visual melhor
     */
    customizar_icones_padrao() {
        // Ícone padrão customizado
        delete L.Icon.Default.prototype._getIconUrl;
        L.Icon.Default.mergeOptions({
            iconRetinaUrl:
                'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon-2x.png',
            iconUrl:
                'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon.png',
            shadowUrl:
                'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-shadow.png',
        });
    }

    /**
     * Configura todos os event listeners
     */
    configurar_eventos() {
        // Menu toggle (mobile)
        this.elementos.menu_toggle?.addEventListener('click', () => {
            this.elementos.sidebar.classList.toggle('active');
        });

        // Fechar sidebar
        this.elementos.sidebar_close?.addEventListener('click', () => {
            this.elementos.sidebar.classList.remove('active');
        });

        // Fechar route panel
        this.elementos.route_close?.addEventListener('click', () => {
            this.parar_rota();
        });

        // Botão de localização
        this.elementos.locate_button?.addEventListener('click', () => {
            this.centralizar_mapa_usuario();
        });

        // Busca de instituições
        this.elementos.search_bar?.addEventListener('input', (e) => {
            this.filtrar_instituicoes(e.target.value);
        });

        // Redesenhar mapa quando a janela for redimensionada
        window.addEventListener('resize', () => {
            if (this.estado.mapa) {
                this.estado.mapa.invalidateSize();
            }
        });

        // Fechar sidebar ao clicar fora (mobile)
        this.estado.mapa.on('click', () => {
            if (window.innerWidth <= 768) {
                this.elementos.sidebar.classList.remove('active');
            }
        });
    }

    /**
     * Obtém a localização do usuário via Geolocation API
     */
    async obter_localizacao_usuario() {
        console.log('📍 Solicitando permissão de localização...');

        return new Promise((resolve, reject) => {
            if (!navigator.geolocation) {
                this.mostrar_toast('Geolocalização não suportada neste navegador', 'error');
                reject(new Error('Geolocation API não disponível'));
                return;
            }

            const opcoes = {
                enableHighAccuracy: true,
                timeout: 10000,
                maximumAge: 0,
            };

            navigator.geolocation.getCurrentPosition(
                (posicao) => {
                    const { latitude, longitude } = posicao.coords;
                    this.estado.usuario_localizacao = { lat: latitude, lng: longitude };
                    console.log('✅ Localização obtida:', latitude, longitude);
                    this.adicionar_marcador_usuario(latitude, longitude);
                    this.centralizar_mapa_usuario();
                    this.mostrar_toast('Localização obtida com sucesso', 'success');
                    resolve();
                },
                (erro) => {
                    console.warn('⚠️  Erro ao obter localização:', erro.message);
                    this.mostrar_toast(
                        `Erro de localização: ${erro.message}. Usando localização padrão.`,
                        'info'
                    );
                    // Usar localização padrão (Piracicaba) se não conseguir obter
                    this.estado.usuario_localizacao = { lat: -22.726226, lng: -47.649373 };
                    this.adicionar_marcador_usuario(-22.726226, -47.649373);
                    resolve();
                },
                opcoes
            );
        });
    }

    /**
     * Adiciona marcador da localização atual do usuário ao mapa
     */
    adicionar_marcador_usuario(lat, lng) {
        // Remover marcador anterior se existir
        if (this.estado.usuario_marcador) {
            this.estado.mapa.removeLayer(this.estado.usuario_marcador);
        }

        // Criar ícone customizado para o usuário
        const icone_usuario = L.divIcon({
            html: `
                <div class="usuario-marcador" style="
                    width: 40px;
                    height: 40px;
                    background: linear-gradient(135deg, #1f77d2, #1565c0);
                    border: 3px solid white;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    box-shadow: 0 4px 12px rgba(31, 119, 210, 0.4);
                    animation: pulse 2s infinite;
                ">
                    <div style="
                        width: 12px;
                        height: 12px;
                        background: white;
                        border-radius: 50%;
                    "></div>
                </div>
                <style>
                    @keyframes pulse {
                        0%, 100% { box-shadow: 0 4px 12px rgba(31, 119, 210, 0.4); }
                        50% { box-shadow: 0 6px 20px rgba(31, 119, 210, 0.6); }
                    }
                </style>
            `,
            iconSize: [40, 40],
            className: 'leaflet-user-icon',
        });

        this.estado.usuario_marcador = L.marker([lat, lng], { icon: icone_usuario })
            .bindPopup('<p><strong>📍 Sua Localização Atual</strong></p>')
            .addTo(this.estado.mapa);
    }

    /**
     * Carrega todas as instituições do banco de dados via API
     */
    async carregar_instituicoes() {
        console.log('🏥 Carregando instituições do servidor...');
        this.mostrar_loading(true);

        try {
            const controller = new AbortController();
            const timeout = setTimeout(
                () => controller.abort(),
                this.config.timeout_fetch
            );

            const response = await fetch('api/get_instituicoes.php', {
                method: 'GET',
                signal: controller.signal,
            });

            clearTimeout(timeout);

            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }

            const dados = await response.json();

            if (!dados.success) {
                throw new Error(dados.message || 'Erro ao buscar instituições');
            }

            this.estado.instituicoes = dados.data || [];
            console.log(`✅ ${this.estado.instituicoes.length} instituições carregadas`);
            this.mostrar_toast(`${this.estado.instituicoes.length} instituições carregadas`, 'success');
        } catch (erro) {
            console.error('❌ Erro ao carregar instituições:', erro);
            this.mostrar_toast('Erro ao carregar instituições', 'error');
            this.estado.instituicoes = [];
        } finally {
            this.mostrar_loading(false);
        }
    }

    /**
     * Plota todos os marcadores das instituições no mapa
     */
    plotar_marcadores_instituicoes() {
        console.log('📍 Plotando marcadores das instituições...');

        // Limpar marcadores existentes
        this.estado.marcadores_instituicoes.forEach((layer) => {
            this.estado.mapa.removeLayer(layer);
        });
        this.estado.marcadores_instituicoes.clear();

        // Adicionar novo marcador para cada instituição
        this.estado.instituicoes.forEach((inst) => {
            this.adicionar_marcador_instituicao(inst);
        });

        console.log(`✅ ${this.estado.marcadores_instituicoes.size} marcadores plotados`);
    }

    /**
     * Adiciona um marcador individual de instituição
     */
    adicionar_marcador_instituicao(instituicao) {
        const { id, nome, latitude, longitude, endereco, especialidades } = instituicao;

        if (
            latitude == null ||
            longitude == null ||
            Number.isNaN(Number(latitude)) ||
            Number.isNaN(Number(longitude))
        ) {
            console.warn('⚠️ Instituto sem coordenadas válidas:', instituicao);
            return;
        }

        // Determinar cor do marcador baseado no tipo
        const cor_marcador = especialidades?.includes('Urgência') ? '#d32f2f' : '#388e3c';

        const icone = L.divIcon({
            html: `
                <div style="
                    width: 36px;
                    height: 36px;
                    background: ${cor_marcador};
                    border: 3px solid white;
                    border-radius: 50% 50% 50% 0;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    transform: rotate(-45deg);
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
                ">
                    <span style="
                        transform: rotate(45deg);
                        color: white;
                        font-weight: bold;
                        font-size: 16px;
                    ">🏥</span>
                </div>
            `,
            iconSize: [36, 36],
            popupAnchor: [0, -15],
            className: 'leaflet-institution-icon',
        });

        const marcador = L.marker([latitude, longitude], { icon: icone })
            .bindPopup(this.criar_popup_instituicao(instituicao))
            .on('click', () => {
                this.selecionar_instituicao(instituicao);
            })
            .addTo(this.estado.mapa);

        // Usar string como chave para evitar mismatch entre number/string
        this.estado.marcadores_instituicoes.set(String(id), marcador);
    }

    /**
     * Cria o conteúdo HTML do popup de uma instituição
     */
    criar_popup_instituicao(instituicao) {
        const {
            id,
            nome,
            endereco,
            especialidades,
            contato,
            horario_atendimento,
            detalhes,
            latitude,
            longitude,
        } = instituicao;

        return `
            <div class="popup-content">
                <div class="popup-header">
                    <div class="popup-nome">${this.escapar_html(nome)}</div>
                    <div class="popup-endereco">${this.escapar_html(endereco)}</div>
                </div>
                
                <div class="popup-info">
                    <strong>⏰ Atendimento:</strong><br/>
                    <span class="popup-horario">${this.escapar_html(horario_atendimento || 'Não informado')}</span>
                </div>

                ${
                    contato
                        ? `<div class="popup-info">
                    <strong>📞 Contato:</strong><br/>
                    ${this.escapar_html(contato)}
                </div>`
                        : ''
                }

                ${
                    especialidades
                        ? `<div class="popup-especialidades">
                    <strong>🔬 Especialidades:</strong><br/>
                    ${this.escapar_html(especialidades)}
                </div>`
                        : ''
                }

                ${
                    detalhes
                        ? `<div class="popup-info" style="font-style: italic; margin-top: 8px;">
                    ${this.escapar_html(detalhes.substring(0, 80))}...
                </div>`
                        : ''
                }

                <div class="popup-actions">
                    <button class="btn-iniciar" onclick="sistemaNavegacao.iniciar_rota(${id})">
                        🚀 Iniciar Rota
                    </button>
                    <button class="btn-google-maps" onclick="sistemaNavegacao.abrir_no_google_maps(${latitude}, ${longitude}, '${this.escapar_html(nome)}')">
                        🗺️  Maps
                    </button>
                </div>
            </div>
        `;
    }

    /**
     * Seleciona uma instituição na lista lateral
     */
    selecionar_instituicao(instituicao) {
        // Remover seleção anterior
        document
            .querySelectorAll('.instituicao-item')
            .forEach((el) => el.classList.remove('active'));

        // Adicionar classe ativa ao item da instituição
        const item = document.querySelector(
            `.instituicao-item[data-id="${instituicao.id}"]`
        );
        if (item) {
            item.classList.add('active');
            item.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }

        // Centralizar mapa na instituição
        this.estado.mapa.setView(
            [instituicao.latitude, instituicao.longitude],
            16
        );

        // Abrir popup do marcador
        const marcador = this.estado.marcadores_instituicoes.get(String(instituicao.id));
        if (marcador) {
            marcador.openPopup();
        }
    }

    /**
     * Inicia o cálculo de rota de um destino
     */
    async iniciar_rota(id_instituicao) {
        console.log('🛣️  Iniciando rota para instituição ID:', id_instituicao);

        if (!this.estado.usuario_localizacao) {
            this.mostrar_toast('Localização do usuário não disponível', 'error');
            return;
        }

        // Comparar IDs como string para aceitar tanto number quanto string
        const instituicao = this.estado.instituicoes.find((i) => String(i.id) === String(id_instituicao));
        if (!instituicao) {
            this.mostrar_toast('Instituição não encontrada', 'error');
            return;
        }

        this.mostrar_loading(true);

        try {
            // Buscar rota via OSRM
            const rota = await this.calcular_rota_osrm(
                [this.estado.usuario_localizacao.lng, this.estado.usuario_localizacao.lat],
                [instituicao.longitude, instituicao.latitude]
            );

            // Armazenar informações da rota ativa
            this.estado.rota_ativa = {
                id_instituicao,
                instituicao,
                rota,
                origem: this.estado.usuario_localizacao,
                destino: { lat: instituicao.latitude, lng: instituicao.longitude },
                tempo_inicio: Date.now(),
            };

            // Desenhar rota no mapa
            this.desenhar_rota(rota, instituicao);

            // Mostrar painel de rota
            this.mostrar_painel_rota(rota, instituicao);

            // Iniciar atualização periódica da rota
            this.iniciar_atualizacao_rota();

            this.mostrar_toast('Rota calculada com sucesso!', 'success');
        } catch (erro) {
            console.error('❌ Erro ao calcular rota:', erro);
            this.mostrar_toast(`Erro ao calcular rota: ${erro.message}`, 'error');
        } finally {
            this.mostrar_loading(false);
        }
    }

    /**
     * Calcula rota via OSRM (Open Source Routing Machine)
     * Returns: objeto com distance (m) e duration (s)
     */
    async calcular_rota_osrm(origem, destino) {
        // Formatar coordenadas: [lng, lat] para OSRM
        const coordenadas = `${origem[0]},${origem[1]};${destino[0]},${destino[1]}`;

        const url = `${this.config.osrm_url}/${coordenadas}?overview=full&geometries=geojson&steps=true&annotations=duration,distance`;

        try {
            const response = await Promise.race([
                fetch(url),
                new Promise((_, reject) =>
                    setTimeout(
                        () => reject(new Error('Timeout na requisição OSRM')),
                        this.config.timeout_fetch
                    )
                ),
            ]);

            if (!response.ok) {
                throw new Error(`HTTP ${response.status}`);
            }

            const dados = await response.json();

            if (dados.code !== 'Ok') {
                throw new Error(`OSRM Error: ${dados.message || dados.code}`);
            }

            if (!dados.routes || !dados.routes[0]) {
                throw new Error('Nenhuma rota encontrada');
            }

            const rota = dados.routes[0];

            if (!rota.geometry || !rota.geometry.coordinates) {
                throw new Error('Rota inválida: coordenadas não foram retornadas pelo OSRM');
            }

            return {
                coordenadas: rota.geometry.coordinates,
                distancia: rota.distance, // metros
                duracao: rota.duration, // segundos
                instrucoes: rota.legs,
            };
        } catch (erro) {
            throw new Error(`Falha ao calcular rota: ${erro.message}`);
        }
    }

    /**
     * Desenha a rota no mapa usando polyline
     */
    desenhar_rota(rota, instituicao) {
        // Remover rota anterior se existir
        if (this.estado.controle_rota) {
            this.estado.mapa.removeLayer(this.estado.controle_rota);
        }

        // Converter coordenadas para formato Leaflet [lat, lng]
        const pontos_rota = rota.coordenadas.map(([lng, lat]) => [lat, lng]);

        // Desenhar polyline
        this.estado.controle_rota = L.polyline(pontos_rota, {
            color: '#1f77d2',
            weight: 5,
            opacity: 0.8,
            lineCap: 'round',
            lineJoin: 'round',
            dashArray: '5, 5',
            animate: true,
        })
            .addTo(this.estado.mapa)
            .bindPopup(`
                <strong>${instituicao.nome}</strong><br/>
                Distância: ${this.formatar_distancia(rota.distancia)}<br/>
                Tempo estimado: ${this.formatar_duracao(rota.duracao)}
            `);

        // Ajustar zoom para mostrar toda a rota
        const bounds = L.latLngBounds(pontos_rota);
        this.estado.mapa.fitBounds(bounds.pad(0.1));
    }

    /**
     * Mostra o painel lateral com informações da rota
     */
    mostrar_painel_rota(rota, instituicao) {
        const panel = this.elementos.route_panel;
        const distancia_km = (rota.distancia / 1000).toFixed(1);
        const duracao_min = Math.round(rota.duracao / 60);

        // Atualizar conteúdo do painel
        const html_stats = `
            <div class="route-stats">
                <div class="route-stat">
                    <div class="route-stat-label">Distância</div>
                    <div class="route-stat-value">${distancia_km} km</div>
                </div>
                <div class="route-stat">
                    <div class="route-stat-label">Tempo</div>
                    <div class="route-stat-value">${duracao_min} min</div>
                </div>
            </div>
            <div class="route-destination">
                <div class="route-destination-label">Destino</div>
                <div class="route-destination-name">${this.escapar_html(instituicao.nome)}</div>
            </div>
        `;

        const info_section = panel.querySelector('.route-info');
        if (info_section) {
            info_section.innerHTML = html_stats;
        }

        // Mostrar painel
        panel.classList.add('active');
    }

    /**
     * Inicia atualização periódica da rota
     */
    iniciar_atualizacao_rota() {
        // Cancelar intervalo anterior se existir
        if (this.estado.intervalo_atualizacao) {
            clearInterval(this.estado.intervalo_atualizacao);
        }

        // TODO: Aqui você poderia fazer requisições periódicas para atualizar
        // a localização do usuário e recalcular a rota em tempo real
    }

    /**
     * Para a rota ativa e remove o painel
     */
    parar_rota() {
        console.log('❌ Parando rota ativa...');

        // Limpar intervalo
        if (this.estado.intervalo_atualizacao) {
            clearInterval(this.estado.intervalo_atualizacao);
            this.estado.intervalo_atualizacao = null;
        }

        // Remover polyline do mapa
        if (this.estado.controle_rota) {
            this.estado.mapa.removeLayer(this.estado.controle_rota);
            this.estado.controle_rota = null;
        }

        // Limpar estado da rota
        this.estado.rota_ativa = null;

        // Fechar painel de rota
        this.elementos.route_panel.classList.remove('active');

        // Recarregar marcadores
        this.plotar_marcadores_instituicoes();

        this.mostrar_toast('Rota cancelada', 'info');
    }

    /**
     * Centraliza o mapa na localização do usuário com animação
     */
    centralizar_mapa_usuario() {
        if (!this.estado.usuario_localizacao) {
            this.mostrar_toast('Localização do usuário não disponível', 'error');
            return;
        }

        this.estado.mapa.flyTo(
            [this.estado.usuario_localizacao.lat, this.estado.usuario_localizacao.lng],
            15,
            { duration: 1.5 }
        );

        this.mostrar_toast('Centralizando em sua localização...', 'info');
    }

    /**
     * Filtra instituições pela busca
     */
    filtrar_instituicoes(termo_busca) {
        const termo = termo_busca.toLowerCase().trim();
        const lista = document.querySelector('.sidebar-content');

        if (!lista) return;

        const items = lista.querySelectorAll('.instituicao-item');
        let visivel_count = 0;

        items.forEach((item) => {
            const nome = item.querySelector('.instituicao-item-nome')?.textContent?.toLowerCase() || '';
            const endereco = item.querySelector('.instituicao-item-endereco')?.textContent?.toLowerCase() || '';

            const matches = nome.includes(termo) || endereco.includes(termo);
            item.style.display = matches ? '' : 'none';

            if (matches) visivel_count++;
        });

        // Mostrar mensagem se nenhum resultado
        if (visivel_count == 0) {
            this.mostrar_toast(`Nenhuma instituição encontrada para "${termo_busca}"`, 'info');
        }
    }

    /**
     * Abre o Google Maps com a localização
     */
    abrir_no_google_maps(lat, lng, nome) {
        const url = `https://www.google.com/maps/search/${encodeURIComponent(nome)}/@${lat},${lng},16z`;
        window.open(url, '_blank');
    }

    /**
     * Atualiza o HTML da sidebar com lista de instituições
     */
    atualizar_sidebar_instituicoes() {
        const sidebar_content = document.querySelector('.sidebar-content');
        if (!sidebar_content) return;

        if (this.estado.instituicoes.length === 0) {
            sidebar_content.innerHTML = `
                <div style="padding: 16px; text-align: center; color: #5f6368;">
                    <p>Nenhuma instituição encontrada.</p>
                </div>
            `;
            return;
        }

        sidebar_content.innerHTML = '';

        this.estado.instituicoes.forEach((inst) => {
            const item = document.createElement('div');
            item.className = 'instituicao-item';
            item.dataset.id = inst.id;

            item.innerHTML = `
                <div class="instituicao-item-nome">${this.escapar_html(inst.nome)}</div>
                <div class="instituicao-item-endereco">${this.escapar_html(inst.endereco)}</div>
            `;

            item.addEventListener('click', () => {
                this.selecionar_instituicao(inst);
            });

            sidebar_content.appendChild(item);
        });
    }

    /**
     * Mostra/oculta overlay de carregamento
     */
    mostrar_loading(ativo) {
        this.estado.loading = ativo;
        if (ativo) {
            this.elementos.loading_overlay?.classList.add('active');
        } else {
            this.elementos.loading_overlay?.classList.remove('active');
        }
    }

    /**
     * Mostra notificação toast
     */
    mostrar_toast(mensagem, tipo = 'info') {
        const toast = document.createElement('div');
        toast.className = `toast ${tipo} fade-in`;

        const icones = {
            success: '✅',
            error: '❌',
            info: 'ℹ️',
        };

        toast.innerHTML = `
            <span class="toast-icon">${icones[tipo] || '💬'}</span>
            <span class="toast-message">${this.escapar_html(mensagem)}</span>
        `;

        this.elementos.toast_container?.appendChild(toast);

        // Auto-remover após 4 segundos
        setTimeout(() => {
            toast.style.animation = 'slideIn 0.3s reverse';
            setTimeout(() => toast.remove(), 300);
        }, 4000);
    }

    /**
     * Formata distância em metros para km
     */
    formatar_distancia(metros) {
        if (metros < 1000) {
            return `${Math.round(metros)} m`;
        }
        return `${(metros / 1000).toFixed(1)} km`;
    }

    /**
     * Formata duração em segundos para min:seg
     */
    formatar_duracao(segundos) {
        const minutos = Math.floor(segundos / 60);
        const segs = Math.round(segundos % 60);
        if (minutos === 0) {
            return `${segs}s`;
        }
        return `${minutos}min ${segs}s`;
    }

    /**
     * Escapa caracteres especiais HTML para prevenir XSS
     */
    escapar_html(texto) {
        if (!texto) return '';
        const div = document.createElement('div');
        div.textContent = texto;
        return div.innerHTML;
    }
}

/**
 * Instância global do sistema
 */
let sistemaNavegacao;

/**
 * Inicializa o sistema quando o DOM está pronto
 */
document.addEventListener('DOMContentLoaded', () => {
    sistemaNavegacao = new SistemaNavegacao();
});

/**
 * Handle de erro global
 */
window.addEventListener('error', (event) => {
    console.error('❌ Erro não tratado:', event.error);
});

/**
 * Log de visibilidade da página
 */
document.addEventListener('visibilitychange', () => {
    if (document.hidden) {
        console.log('👋 Aba saiu de foco');
    } else {
        console.log('👀 Aba voltou ao foco');
    }
});
