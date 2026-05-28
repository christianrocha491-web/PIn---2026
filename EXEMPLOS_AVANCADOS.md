# 🚀 Exemplos Avançados e Customizações - PIN 2026

Guia com exemplos práticos para expandir o sistema de navegação.

---

## 📋 Índice

- [Adicionar Clustering de Marcadores](#adicionar-clustering)
- [Filtrar por Especialidade](#filtrar-por-especialidade)
- [Histórico de Rotas](#histórico-de-rotas)
- [Modo Noturno](#modo-noturno)
- [Compartilhar Rota via URL](#compartilhar-rota)
- [Integração com Banco de Dados Avançada](#integração-avançada)
- [Notificações de Proximidade](#notificações-proximidade)
- [Exportar Rota como GPX](#exportar-rota-gpx)

---

## Adicionar Clustering de Marcadores {#adicionar-clustering}

Agrupa múltiplos marcadores próximos quando zoom afastado.

### 1. Adicionar CDN no HTML

`navegacao.html` - Após Leaflet:

```html
<!-- Leaflet Cluster -->
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.4.1/MarkerCluster.Default.min.css" />
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.4.1/MarkerCluster.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.4.1/leaflet.markercluster.js"></script>
```

### 2. Modificar JavaScript

`js/navegacao.js` - Em `constructor()`:

```javascript
// Adicionar ao estado:
this.estado.cluster_group = null;
```

### 3. Criar Método de Clustering

`js/navegacao.js` - Novo método:

```javascript
/**
 * Configura clustering de marcadores
 */
configurar_clustering() {
    // Criar grupo de clusters
    this.estado.cluster_group = L.markerClusterGroup({
        maxClusterRadius: 80,
        showCoverageOnHover: true,
    });

    // Adicionar marcadores ao cluster
    this.estado.instituicoes.forEach((inst) => {
        const marker = L.marker([inst.latitude, inst.longitude]);
        marker.bindPopup(this.criar_popup_instituicao(inst));
        this.estado.cluster_group.addLayer(marker);
    });

    // Adicionar cluster ao mapa
    this.estado.mapa.addLayer(this.estado.cluster_group);
}
```

### 4. Chamar em `inicializar()`

```javascript
// Substitua plotar_marcadores_instituicoes por:
await this.carregar_instituicoes();
this.configurar_clustering();
this.atualizar_sidebar_instituicoes();
```

### Resultado
```
Zoom longe: Bolinhas grandes com números (ex: "5")
Zoom perto: Marcadores individuais
```

---

## Filtrar por Especialidade {#filtrar-por-especialidade}

Adicionar filtros visuais por tipo de instituição.

### 1. Adicionar Botões no HTML

`navegacao.html` - Na navbar:

```html
<div class="filter-buttons" style="display: flex; gap: 8px; margin-top: 8px;">
    <button class="filter-btn active" data-type="todos">
        Todas
    </button>
    <button class="filter-btn" data-type="urgencia">
        🚑 Urgência
    </button>
    <button class="filter-btn" data-type="basica">
        🏥 Básica
    </button>
    <button class="filter-btn" data-type="familia">
        👨‍👩‍👧 Família
    </button>
</div>
```

### 2. Adicionar CSS

`css/navegacao.css`:

```css
.filter-buttons {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
    padding: 8px 0;
}

.filter-btn {
    padding: 8px 12px;
    background: white;
    border: 2px solid var(--border-gray);
    border-radius: 20px;
    cursor: pointer;
    transition: var(--transition);
    font-size: 12px;
    font-weight: 600;
}

.filter-btn:hover {
    border-color: var(--primary-color);
}

.filter-btn.active {
    background: var(--primary-color);
    color: white;
    border-color: var(--primary-color);
}
```

### 3. Adicionar Método no JavaScript

`js/navegacao.js`:

```javascript
/**
 * Filtra instituições por especialidade
 */
filtrar_por_especialidade(tipo) {
    const items = document.querySelectorAll('.instituicao-item');
    const marcadores = this.estado.marcadores_instituicoes;

    items.forEach((item) => {
        const id = parseInt(item.dataset.id);
        const instituicao = this.estado.instituicoes.find((i) => i.id === id);

        let mostrar = true;
        if (tipo !== 'todos') {
            mostrar = this.verifica_tipo_especialidade(instituicao, tipo);
        }

        item.style.display = mostrar ? '' : 'none';

        // Mostrar/ocultar marcador
        const marcador = marcadores.get(id);
        if (marcador) {
            mostrar ? marcador.addTo(this.estado.mapa) : this.estado.mapa.removeLayer(marcador);
        }
    });
}

/**
 * Verifica tipo de especialidade
 */
verifica_tipo_especialidade(instituicao, tipo) {
    const especialidades = (instituicao.especialidades || '').toLowerCase();

    switch (tipo) {
        case 'urgencia':
            return especialidades.includes('urgência') || especialidades.includes('emergência');
        case 'basica':
            return especialidades.includes('atenção básica');
        case 'familia':
            return especialidades.includes('saúde da família');
        default:
            return true;
    }
}
```

### 4. Configurar Event Listeners

`js/navegacao.js` - Em `configurar_eventos()`:

```javascript
// Adicionar após search bar
document.querySelectorAll('.filter-btn').forEach((btn) => {
    btn.addEventListener('click', (e) => {
        // Remover active de todos
        document.querySelectorAll('.filter-btn').forEach((b) => {
            b.classList.remove('active');
        });
        // Adicionar ao clicado
        e.target.classList.add('active');
        // Filtrar
        this.filtrar_por_especialidade(e.target.dataset.type);
    });
});
```

---

## Histórico de Rotas {#histórico-de-rotas}

Salvar e exibir histórico de rotas anteriores.

### 1. Adicionar localStorage

`js/navegacao.js` - Em `constructor()`:

```javascript
this.estado.historico_rotas = JSON.parse(
    localStorage.getItem('historico_rotas') || '[]'
);
```

### 2. Salvar Rota

`js/navegacao.js` - Em `iniciar_rota()` após `desenhar_rota()`:

```javascript
// Salvar no histórico
const rota_salva = {
    id_instituicao,
    nome_instituicao: instituicao.nome,
    data: new Date().toLocaleString('pt-BR'),
    distancia: rota.distancia,
    duracao: rota.duracao,
};

this.estado.historico_rotas.unshift(rota_salva); // Adicionar no início
if (this.estado.historico_rotas.length > 10) {
    this.estado.historico_rotas.pop(); // Manter últimas 10
}

localStorage.setItem(
    'historico_rotas',
    JSON.stringify(this.estado.historico_rotas)
);
```

### 3. Exibir Histórico

```javascript
/**
 * Mostra histórico de rotas
 */
mostrar_historico() {
    const html = this.estado.historico_rotas
        .map(
            (rota, idx) => `
        <div class="historico-item">
            <strong>${rota.nome_instituicao}</strong><br/>
            <small>${rota.data}</small><br/>
            <small>${this.formatar_distancia(rota.distancia)} · ${this.formatar_duracao(rota.duracao)}</small>
        </div>
    `
        )
        .join('');

    console.log('Histórico de Rotas:', html);
}
```

---

## Modo Noturno {#modo-noturno}

Implementar tema dark mode com toggle.

### 1. Adicionar Botão

`navegacao.html` - Na navbar:

```html
<button id="theme-toggle" style="
    background: white;
    border: none;
    border-radius: 8px;
    padding: 8px 12px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
">
    🌙
</button>
```

### 2. Adicionar CSS

`css/navegacao.css` - Novo:

```css
/* Tema Noturno */
body.dark-theme {
    --text-primary: #e8e8e8;
    --text-secondary: #a0a0a0;
    --light-gray: #2a2a2a;
    --border-gray: #404040;
}

body.dark-theme .navbar,
body.dark-theme .sidebar,
body.dark-theme .route-panel,
body.dark-theme .popup-content {
    background: #1e1e1e;
}

body.dark-theme .leaflet-popup-content-wrapper {
    background: #1e1e1e !important;
    color: #e8e8e8;
}
```

### 3. JavaScript para Toggle

`js/navegacao.js`:

```javascript
// Em configurar_eventos():
const themeToggle = document.getElementById('theme-toggle');
const isDark = localStorage.getItem('dark-theme') === 'true';

if (isDark) {
    document.body.classList.add('dark-theme');
    themeToggle.textContent = '☀️';
}

themeToggle?.addEventListener('click', () => {
    document.body.classList.toggle('dark-theme');
    const isDark = document.body.classList.contains('dark-theme');
    localStorage.setItem('dark-theme', isDark);
    themeToggle.textContent = isDark ? '☀️' : '🌙';
});
```

---

## Compartilhar Rota via URL {#compartilhar-rota}

Gerar link que abre rota pré-calculada.

### 1. Gerar Link Compartilhável

`js/navegacao.js`:

```javascript
/**
 * Gera URL compartilhável da rota
 */
gerar_url_compartilhavel() {
    if (!this.estado.rota_ativa) {
        this.mostrar_toast('Nenhuma rota ativa', 'info');
        return;
    }

    const params = new URLSearchParams();
    params.set('destino_id', this.estado.rota_ativa.id_instituicao);
    params.set('tipo', 'rota');

    const url = window.location.origin + window.location.pathname + '?' + params.toString();
    
    // Copiar para clipboard
    navigator.clipboard.writeText(url).then(() => {
        this.mostrar_toast('Link copiado! 📋', 'success');
    });

    return url;
}
```

### 2. Processar Link ao Carregar

`js/navegacao.js` - Em `inicializar()`:

```javascript
// Após carregar instituições:
const params = new URLSearchParams(window.location.search);
if (params.get('tipo') === 'rota') {
    const id = parseInt(params.get('destino_id'));
    setTimeout(() => {
        this.iniciar_rota(id);
    }, 2000);
}
```

### 3. Adicionar Botão no Popup

`js/navegacao.js` - Em `criar_popup_instituicao()`:

```html
<button onclick="sistemaNavegacao.gerar_url_compartilhavel()" 
    style="background: #388e3c; color: white; border: none; 
           padding: 8px 12px; border-radius: 4px; cursor: pointer;">
    🔗 Compartilhar
</button>
```

---

## Integração Avançada com Banco de Dados {#integração-avançada}

### 1. API para Inserir Instituição

`api/criar_instituicao.php`:

```php
<?php
header('Content-Type: application/json');

$host = '127.0.0.1';
$user = 'root';
$pass = '';
$db = 'pin2026';

try {
    $pdo = new PDO("mysql:host={$host};dbname={$db};charset=utf8mb4", $user, $pass);

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $dados = json_decode(file_get_contents('php://input'), true);

        $sql = "INSERT INTO instituicoes 
                (nome, localizacao, lat, lng, especialidades, horario_atendimento, contato)
                VALUES (?, ?, ?, ?, ?, ?, ?)";

        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            $dados['nome'],
            $dados['localizacao'],
            $dados['lat'],
            $dados['lng'],
            $dados['especialidades'],
            $dados['horario_atendimento'],
            $dados['contato'],
        ]);

        echo json_encode(['success' => true, 'id' => $pdo->lastInsertId()]);
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>
```

### 2. Chamar via JavaScript

```javascript
/**
 * Insere nova instituição
 */
async inserir_instituicao(dados) {
    try {
        const response = await fetch('api/criar_instituicao.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(dados),
        });

        const resultado = await response.json();

        if (resultado.success) {
            // Recarregar instituições
            await this.carregar_instituicoes();
            this.plotar_marcadores_instituicoes();
            this.mostrar_toast('Instituição adicionada!', 'success');
        }
    } catch (erro) {
        this.mostrar_toast('Erro ao inserir', 'error');
    }
}

// Uso:
sistemaNavegacao.inserir_instituicao({
    nome: 'Nova UPA',
    localizacao: 'Rua X, 123',
    lat: -22.726,
    lng: -47.649,
    especialidades: 'Urgência e Emergência',
    horario_atendimento: '24 horas',
    contato: '3434-0000',
});
```

---

## Notificações de Proximidade {#notificações-proximidade}

Alertar quando usuário está perto do destino.

### 1. Monitorar Localização

`js/navegacao.js` - Em `iniciar_atualizacao_rota()`:

```javascript
/**
 * Inicia atualização periódica da rota com verificação de proximidade
 */
iniciar_atualizacao_rota() {
    if (this.estado.intervalo_atualizacao) {
        clearInterval(this.estado.intervalo_atualizacao);
    }

    this.estado.intervalo_atualizacao = setInterval(() => {
        if (navigator.geolocation && this.estado.rota_ativa) {
            navigator.geolocation.getCurrentPosition((posicao) => {
                const novaPos = {
                    lat: posicao.coords.latitude,
                    lng: posicao.coords.longitude,
                };

                // Verificar proximidade
                const distancia = this.calcular_distancia_pontos(
                    novaPos,
                    this.estado.rota_ativa.destino
                );

                if (distancia < 500) {
                    this.mostrar_toast('🎉 Você chegou próximo!', 'success');
                    this.parar_rota();
                } else if (distancia < 1000) {
                    this.mostrar_toast(`⚠️ Faltam ${Math.round(distancia)}m`, 'info');
                }
            });
        }
    }, 5000); // A cada 5 segundos
}

/**
 * Calcula distância entre dois pontos em metros (Haversine)
 */
calcular_distancia_pontos(p1, p2) {
    const R = 6371000; // Raio da Terra em metros
    const lat1 = (p1.lat * Math.PI) / 180;
    const lat2 = (p2.lat * Math.PI) / 180;
    const deltaLat = ((p2.lat - p1.lat) * Math.PI) / 180;
    const deltaLng = ((p2.lng - p1.lng) * Math.PI) / 180;

    const a =
        Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2) +
        Math.cos(lat1) * Math.cos(lat2) * Math.sin(deltaLng / 2) * Math.sin(deltaLng / 2);

    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return R * c;
}
```

---

## Exportar Rota como GPX {#exportar-rota-gpx}

Gerar arquivo GPX (formato GPS padrão).

### 1. Criar Função de Export

`js/navegacao.js`:

```javascript
/**
 * Exporta rota como arquivo GPX
 */
exportar_rota_gpx() {
    if (!this.estado.rota_ativa) {
        this.mostrar_toast('Nenhuma rota ativa', 'info');
        return;
    }

    const rota = this.estado.rota_ativa;
    const coordenadas = rota.rota.coordenadas;

    let gpx = `<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" xmlns="http://www.topografix.com/GPX/1/1">
    <metadata>
        <name>${rota.instituicao.nome}</name>
        <time>${new Date().toISOString()}</time>
    </metadata>
    <trk>
        <name>Rota para ${rota.instituicao.nome}</name>
        <trkseg>`;

    coordenadas.forEach(([lng, lat]) => {
        gpx += `\n            <trkpt lat="${lat}" lon="${lng}" />`;
    });

    gpx += `
        </trkseg>
    </trk>
</gpx>`;

    // Baixar arquivo
    const blob = new Blob([gpx], { type: 'application/gpx+xml' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `rota_${rota.instituicao.id}.gpx`;
    a.click();

    this.mostrar_toast('Rota exportada! 📥', 'success');
}
```

### 2. Adicionar Botão

```javascript
// Em mostrar_painel_rota():
<button onclick="sistemaNavegacao.exportar_rota_gpx()" 
    style="background: #f57c00; color: white; ..." >
    📥 Exportar GPX
</button>
```

---

## 📝 Mais Exemplos Disponíveis

- **Traduzir para outro idioma**: Usar `i18n` library
- **Adicionar marcadores de poi**: Restaurantes, farmácias, etc.
- **Integrar com WhatsApp API**: Compartilhar endereço
- **Analytics**: Rastrear rotas populares
- **PWA**: Offline mode com service workers
- **VoiceOver**: Navegação por voz

---

## 🤝 Contribuições

Feel free to expand this guide with more examples!

Happy coding! 🚀
