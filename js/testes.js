/**
 * =====================================================
 * TESTES E VALIDAÇÃO - Sistema de Navegação PIN 2026
 * =====================================================
 * 
 * Execute este arquivo no console (F12 > Console) para validar
 * a instalação e funcionamento do sistema
 */

/**
 * Suite de testes para validação
 */
class TestesSistemaNavegacao {
    constructor() {
        this.resultados = [];
    }

    /**
     * Executa todos os testes
     */
    async executar_todos() {
        console.log('🧪 Iniciando suite de testes...\n');

        // Testes básicos
        this.teste_dom();
        this.teste_leaflet();
        this.teste_geolocation_api();

        // Testes assíncronos
        await this.teste_api_instituicoes();
        await this.teste_osrm();
        await this.teste_sistema_navegacao();

        // Resumo
        this.mostrar_resumo();
    }

    /**
     * Teste 1: DOM está pronto?
     */
    teste_dom() {
        try {
            const elementos = [
                { id: 'mapa', nome: 'Container do mapa' },
                { selector: '.navbar', nome: 'Navbar' },
                { selector: '.sidebar', nome: 'Sidebar' },
                { selector: '.route-panel', nome: 'Painel de rota' },
                { selector: '.locate-button', nome: 'Botão de localização' },
            ];

            elementos.forEach((elem) => {
                let el = null;
                if (elem.id) {
                    el = document.getElementById(elem.id);
                } else if (elem.selector) {
                    el = document.querySelector(elem.selector);
                }

                if (el) {
                    this.passar(`✅ DOM: ${elem.nome} encontrado`);
                } else {
                    this.falhar(`❌ DOM: ${elem.nome} NÃO encontrado`);
                }
            });
        } catch (e) {
            this.falhar(`❌ DOM: Erro na validação - ${e.message}`);
        }
    }

    /**
     * Teste 2: Leaflet está carregado?
     */
    teste_leaflet() {
        try {
            if (typeof L !== 'undefined') {
                this.passar(`✅ Leaflet: Biblioteca carregada (v${L.version})`);
            } else {
                this.falhar('❌ Leaflet: Biblioteca NÃO carregada');
                return;
            }

            if (typeof L.map === 'function') {
                this.passar('✅ Leaflet: Método L.map disponível');
            } else {
                this.falhar('❌ Leaflet: Método L.map indisponível');
            }

            if (typeof L.marker === 'function') {
                this.passar('✅ Leaflet: Método L.marker disponível');
            } else {
                this.falhar('❌ Leaflet: Método L.marker indisponível');
            }

            if (typeof L.polyline === 'function') {
                this.passar('✅ Leaflet: Método L.polyline disponível');
            } else {
                this.falhar('❌ Leaflet: Método L.polyline indisponível');
            }
        } catch (e) {
            this.falhar(`❌ Leaflet: Erro - ${e.message}`);
        }
    }

    /**
     * Teste 3: Geolocation API está disponível?
     */
    teste_geolocation_api() {
        try {
            if (navigator.geolocation) {
                this.passar('✅ Geolocation API: Disponível no navegador');
            } else {
                this.falhar('❌ Geolocation API: NÃO disponível');
            }

            // Verificar HTTPS
            if (window.location.protocol === 'https:') {
                this.passar('✅ HTTPS: Ativado (requerido para geolocation)');
            } else if (window.location.hostname === 'localhost') {
                this.passar('✅ Localhost: Geolocation permitido em desenvolvimento');
            } else {
                this.falhar('⚠️  HTTP: HTTPS requerido em produção para geolocation');
            }
        } catch (e) {
            this.falhar(`❌ Geolocation API: Erro - ${e.message}`);
        }
    }

    /**
     * Teste 4: API de instituições funciona?
     */
    async teste_api_instituicoes() {
        try {
            console.log('\n⏳ Testando API de instituições...');

            const response = await Promise.race([
                fetch('api/get_instituicoes.php'),
                new Promise((_, reject) =>
                    setTimeout(() => reject(new Error('Timeout')), 5000)
                ),
            ]);

            if (!response.ok) {
                this.falhar(`❌ API: HTTP ${response.status}`);
                return;
            }

            const dados = await response.json();

            if (dados.success) {
                this.passar(`✅ API: ${dados.total} instituições carregadas`);
            } else {
                this.falhar(`❌ API: ${dados.message}`);
                return;
            }

            // Validar estrutura dos dados
            if (Array.isArray(dados.data) && dados.data.length > 0) {
                const primeira = dados.data[0];
                const campos_requeridos = ['id', 'nome', 'latitude', 'longitude', 'endereco'];

                campos_requeridos.forEach((campo) => {
                    if (primeira.hasOwnProperty(campo)) {
                        this.passar(`✅ API: Campo '${campo}' presente`);
                    } else {
                        this.falhar(`❌ API: Campo '${campo}' ausente`);
                    }
                });
            } else {
                this.falhar('❌ API: Nenhuma instituição retornada');
            }
        } catch (e) {
            this.falhar(`❌ API: Erro - ${e.message}`);
        }
    }

    /**
     * Teste 5: OSRM funciona?
     */
    async teste_osrm() {
        try {
            console.log('\n⏳ Testando OSRM...');

            // Coordenadas de teste (Piracicaba)
            const url =
                'https://router.project-osrm.org/route/v1/driving/-47.649,-22.726;-47.627,-22.739?overview=full';

            const response = await Promise.race([
                fetch(url),
                new Promise((_, reject) =>
                    setTimeout(() => reject(new Error('Timeout')), 5000)
                ),
            ]);

            if (!response.ok) {
                this.falhar(`❌ OSRM: HTTP ${response.status}`);
                return;
            }

            const dados = await response.json();

            if (dados.code === 'Ok' && dados.routes && dados.routes.length > 0) {
                const rota = dados.routes[0];
                this.passar(
                    `✅ OSRM: Rota calculada (${(rota.distance / 1000).toFixed(1)}km, ${Math.round(rota.duration / 60)}min)`
                );
            } else {
                this.falhar(`❌ OSRM: ${dados.message || dados.code}`);
            }
        } catch (e) {
            this.falhar(`❌ OSRM: Erro - ${e.message}`);
        }
    }

    /**
     * Teste 6: Sistema de Navegação está pronto?
     */
    async teste_sistema_navegacao() {
        try {
            console.log('\n⏳ Testando Sistema de Navegação...');

            if (typeof sistemaNavegacao === 'undefined') {
                this.falhar('❌ Sistema: Objeto sistemaNavegacao não definido');
                return;
            }

            this.passar('✅ Sistema: Objeto sistemaNavegacao disponível');

            // Verificar instância
            if (sistemaNavegacao instanceof SistemaNavegacao) {
                this.passar('✅ Sistema: Instância correta de SistemaNavegacao');
            } else {
                this.falhar('❌ Sistema: Tipo incorreto');
            }

            // Verificar métodos principais
            const metodos = [
                'inicializar',
                'carregar_instituicoes',
                'iniciar_rota',
                'plotar_marcadores_instituicoes',
                'mostrar_toast',
            ];

            metodos.forEach((metodo) => {
                if (typeof sistemaNavegacao[metodo] === 'function') {
                    this.passar(`✅ Sistema: Método ${metodo}() presente`);
                } else {
                    this.falhar(`❌ Sistema: Método ${metodo}() ausente`);
                }
            });

            // Verificar estado
            if (sistemaNavegacao.estado && sistemaNavegacao.estado.mapa) {
                this.passar('✅ Sistema: Mapa inicializado');
            } else {
                this.falhar('❌ Sistema: Mapa não inicializado');
            }

            if (sistemaNavegacao.estado.instituicoes.length > 0) {
                this.passar(
                    `✅ Sistema: ${sistemaNavegacao.estado.instituicoes.length} instituições carregadas`
                );
            } else {
                this.falhar('❌ Sistema: Nenhuma instituição carregada');
            }

            if (sistemaNavegacao.estado.usuario_localizacao) {
                const { lat, lng } = sistemaNavegacao.estado.usuario_localizacao;
                this.passar(
                    `✅ Sistema: Localização do usuário disponível (${lat.toFixed(3)}, ${lng.toFixed(3)})`
                );
            } else {
                this.falhar('❌ Sistema: Localização do usuário não disponível');
            }
        } catch (e) {
            this.falhar(`❌ Sistema: Erro - ${e.message}`);
        }
    }

    /**
     * Registra teste bem-sucedido
     */
    passar(mensagem) {
        console.log(mensagem);
        this.resultados.push({ status: 'pass', mensagem });
    }

    /**
     * Registra teste falhado
     */
    falhar(mensagem) {
        console.error(mensagem);
        this.resultados.push({ status: 'fail', mensagem });
    }

    /**
     * Mostra resumo dos testes
     */
    mostrar_resumo() {
        console.log('\n\n========================================');
        console.log('📊 RESUMO DOS TESTES');
        console.log('========================================');

        const total = this.resultados.length;
        const aprovados = this.resultados.filter((r) => r.status === 'pass').length;
        const falhados = this.resultados.filter((r) => r.status === 'fail').length;
        const percentual = ((aprovados / total) * 100).toFixed(1);

        console.log(`\n✅ Aprovados: ${aprovados}`);
        console.log(`❌ Falhados: ${falhados}`);
        console.log(`📈 Taxa de sucesso: ${percentual}%\n`);

        if (falhados === 0) {
            console.log('🎉 Todos os testes passaram! Sistema pronto para uso.\n');
        } else {
            console.log('⚠️  Alguns testes falharam. Verifique os erros acima.\n');
            console.log('DICAS DE RESOLUÇÃO:');
            this.resultados
                .filter((r) => r.status === 'fail')
                .forEach((r) => {
                    console.log(`  • ${r.mensagem}`);
                });
            console.log();
        }

        console.log('========================================\n');
    }
}

/**
 * Executa testes automaticamente
 */
async function executar_testes() {
    const testes = new TestesSistemaNavegacao();
    await testes.executar_todos();
}

/**
 * Testes de performance
 */
function teste_performance() {
    console.log('\n📊 TESTE DE PERFORMANCE\n');

    // Tempo de carregamento
    if (window.performance && window.performance.timing) {
        const timing = window.performance.timing;
        const loadTime = timing.loadEventEnd - timing.navigationStart;
        const domReady = timing.domInteractive - timing.navigationStart;

        console.log(`⏱️  Tempo total de carregamento: ${loadTime}ms`);
        console.log(`⏱️  DOM pronto em: ${domReady}ms`);

        if (loadTime < 3000) {
            console.log('✅ Performance: Excelente (< 3s)');
        } else if (loadTime < 5000) {
            console.log('⚠️  Performance: Aceitável (3-5s)');
        } else {
            console.log('❌ Performance: Lenta (> 5s)');
        }
    }

    // Memória (Chrome)
    if (performance.memory) {
        const memory = performance.memory;
        console.log(
            `💾 Memória utilizada: ${(memory.usedJSHeapSize / 1048576).toFixed(1)}MB`
        );
        console.log(
            `💾 Limite de memória: ${(memory.jsHeapSizeLimit / 1048576).toFixed(1)}MB`
        );
    }

    // Marcadores no mapa
    if (typeof sistemaNavegacao !== 'undefined') {
        const total_marcadores = sistemaNavegacao.estado.marcadores_instituicoes.size;
        console.log(`📍 Marcadores plotados: ${total_marcadores}`);
    }

    console.log();
}

/**
 * Teste de integração manual
 */
async function teste_integracao_manual() {
    console.log('\n🔄 TESTE DE INTEGRAÇÃO MANUAL\n');

    if (typeof sistemaNavegacao === 'undefined') {
        console.log('❌ Sistema não inicializado');
        return;
    }

    // Teste 1: Buscar instituição
    console.log('1️⃣  Buscando primeira instituição...');
    const inst = sistemaNavegacao.estado.instituicoes[0];
    if (inst) {
        console.log(`   ✅ Encontrada: ${inst.nome}`);
    }

    // Teste 2: Simular clique em instituição
    console.log('2️⃣  Simulando seleção de instituição...');
    if (inst) {
        sistemaNavegacao.selecionar_instituicao(inst);
        console.log('   ✅ Instituição selecionada');
    }

    // Teste 3: Filtrar instituições
    console.log('3️⃣  Testando filtro de busca...');
    sistemaNavegacao.filtrar_instituicoes('UPA');
    console.log('   ✅ Filtro aplicado');

    // Teste 4: Toast
    console.log('4️⃣  Testando notificação...');
    sistemaNavegacao.mostrar_toast('Teste de notificação ✅', 'success');
    console.log('   ✅ Toast exibido');

    console.log('\n✅ Testes de integração concluídos!\n');
}

/**
 * Instruções de uso
 */
function ajuda_testes() {
    console.log(`
╔════════════════════════════════════════════════════════════╗
║        TESTES DO SISTEMA DE NAVEGAÇÃO - PIN 2026         ║
╚════════════════════════════════════════════════════════════╝

COMANDOS DISPONÍVEIS:

1. 🧪 Executar todos os testes:
   >>> executar_testes()

2. 📊 Teste de performance:
   >>> teste_performance()

3. 🔄 Teste de integração manual:
   >>> teste_integracao_manual()

4. 💡 Mostrar esta ajuda:
   >>> ajuda_testes()

5. 🔍 Inspecionar sistema:
   >>> console.log(sistemaNavegacao)

6. 📍 Inspecionar estado:
   >>> console.log(sistemaNavegacao.estado)

7. 🗺️  Inspecionar mapa:
   >>> console.log(sistemaNavegacao.estado.mapa)

════════════════════════════════════════════════════════════

EXEMPLOS DE USO:

// Centralizar no usuário
sistemaNavegacao.centralizar_mapa_usuario();

// Buscar instituição
sistemaNavegacao.filtrar_instituicoes('UPA');

// Iniciar rota (use ID real)
sistemaNavegacao.iniciar_rota(33);

// Mostrar notificação
sistemaNavegacao.mostrar_toast('Mensagem', 'info');

════════════════════════════════════════════════════════════
    `);
}

/**
 * Auto-executar testes ao carregar (comentado por padrão)
 */
// Descomente a linha abaixo para executar testes automaticamente:
// window.addEventListener('load', () => { setTimeout(() => executar_testes(), 2000); });

console.log('%c🧪 Sistema de Testes PIN 2026 Carregado', 'color: #1f77d2; font-weight: bold; font-size: 14px;');
console.log(
    '%cDigite "ajuda_testes()" para ver comandos disponíveis',
    'color: #5f6368; font-size: 12px;'
);
