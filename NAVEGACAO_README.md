# 🗺️ Sistema de Navegação Interativa - PIN 2026

Sistema completo de navegação com mapa interativo similar ao Google Maps, desenvolvido com Leaflet, OpenStreetMap e OSRM.

## 📋 Índice

- [Características](#características)
- [Estrutura de Pastas](#estrutura-de-pastas)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Instalação e Configuração](#instalação-e-configuração)
- [Como Usar](#como-usar)
- [APIs e Endpoints](#apis-e-endpoints)
- [Arquitetura](#arquitetura)
- [Tratamento de Erros](#tratamento-de-erros)
- [Otimizações e Performance](#otimizações-e-performance)
- [Boas Práticas](#boas-práticas)
- [Troubleshooting](#troubleshooting)

---

## ✨ Características

✅ **Mapa Interativo Completo**
- Baseado em OpenStreetMap (gratuito e sem limitações)
- Interface responsiva e moderna
- Zoom, pan e rotação suave

✅ **Geolocalização em Tempo Real**
- Detecta localização do usuário automaticamente
- Marcador visual com animação
- Fallback para localização padrão

✅ **Busca e Filtro**
- Busca por nome de instituição
- Filtro por especialidade
- Busca em tempo real

✅ **Roteamento Dinâmico**
- Cálculo de rotas via OSRM (gratuito)
- Desenho da rota no mapa
- Distância e tempo estimado
- Suporte a múltiplas rotas

✅ **Interface Moderna**
- Design inspirado no Google Maps
- Sidebar com lista de instituições
- Painel de rota com informações
- Notificações tipo toast
- Totalmente responsivo (mobile-first)

✅ **Performance Otimizada**
- Carregamento assíncrono de dados
- Cache inteligente
- Lazy loading de marcadores
- Timeout em requisições

---

## 📁 Estrutura de Pastas

```
PIn---2026/
│
├── navegacao.html                 # Interface principal (HTML)
├── css/
│   └── navegacao.css              # Estilos (CSS completo)
├── js/
│   └── navegacao.js               # Lógica principal (JavaScript)
├── api/
│   └── get_instituicoes.php       # API REST para buscar instituições
├── img/
│   └── [imagens das instituições] # (opcional)
└── README.md                      # Esta documentação
```

### Descrição dos Arquivos

| Arquivo | Descrição |
|---------|-----------|
| `navegacao.html` | Página principal com estrutura HTML e CDNs |
| `css/navegacao.css` | Estilos CSS (1200+ linhas, design responsivo) |
| `js/navegacao.js` | Classe `SistemaNavegacao` com toda lógica |
| `api/get_instituicoes.php` | API REST para buscar instituições do banco |

---

## 🛠️ Tecnologias Utilizadas

### Frontend
- **Leaflet.js** v1.9.4 - Biblioteca de mapa interativo
- **HTML5** - Estrutura
- **CSS3** - Estilos (Flexbox, Grid, Animations)
- **JavaScript ES6+** - Lógica (Classes, Promises, Async/Await)

### Backend
- **PHP 8.2+** - API REST
- **PDO** - Conexão com banco de dados
- **MySQL/MariaDB** - Armazenamento de instituições

### Serviços Externos
- **OpenStreetMap** - Mapa base (gratuito)
- **OSRM** (Open Source Routing Machine) - Cálculo de rotas (gratuito)
- **Geolocation API** - Localização do navegador (nativa)

### CDNs Utilizados
```html
<!-- Leaflet -->
https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/

<!-- Leaflet Routing Machine -->
https://cdn.jsdelivr.net/npm/leaflet-routing-machine@3.2.12/
```

---

## 🚀 Instalação e Configuração

### Pré-requisitos
- ✅ PHP 7.4+
- ✅ MySQL/MariaDB com banco `pin2026`
- ✅ XAMPP ou servidor web local
- ✅ Navegador moderno (Chrome, Firefox, Safari, Edge)

### Passo 1: Preparar Banco de Dados

Certifique-se que a tabela `instituicoes` existe (já vem no SQL):

```sql
CREATE TABLE `instituicoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `localizacao` varchar(255) NOT NULL,
  `lat` decimal(10,8) NOT NULL,
  `lng` decimal(11,8) NOT NULL,
  `especialidades` text,
  `horario_atendimento` varchar(100),
  `contato` varchar(100),
  `detalhes` text,
  `atualizado_em` timestamp DEFAULT CURRENT_TIMESTAMP,
  `url_imagem` varchar(255),
  PRIMARY KEY (`id`),
  KEY `idx_coords` (`lat`, `lng`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### Passo 2: Configurar Conexão com Banco

Edit `api/get_instituicoes.php` se necessário alterar:

```php
$host = '127.0.0.1';      // Host do banco
$user = 'root';            // Usuário do banco
$pass = '';                // Senha do banco
$db = 'pin2026';           // Nome do banco
```

### Passo 3: Copiar Arquivos

1. Coloque `navegacao.html`, `css/`, `js/` e `api/` no diretório do projeto
2. Caminhos finais:
   - `c:\xampp\htdocs\teste_pin\PIn---2026\navegacao.html`
   - `c:\xampp\htdocs\teste_pin\PIn---2026\css\navegacao.css`
   - `c:\xampp\htdocs\teste_pin\PIn---2026\js\navegacao.js`
   - `c:\xampp\htdocs\teste_pin\PIn---2026\api\get_instituicoes.php`

### Passo 4: Acessar no Navegador

```
http://localhost/teste_pin/PIn---2026/navegacao.html
```

---

## 📖 Como Usar

### Fluxo Principal

1. **Carregamento**: Sistema pede permissão de localização
2. **Mapa**: Mapa centraliza na localização do usuário (ou Piracicaba)
3. **Instituições**: Marcadores aparecem no mapa
4. **Busca**: Use a barra superior para filtrar instituições
5. **Seleção**: Clique em um marcador ou na lista lateral
6. **Popup**: Veja detalhes e clique "🚀 Iniciar Rota"
7. **Navegação**: Rota aparece no mapa com informações

### Funcionalidades

#### 🔍 Busca de Instituições
```javascript
// Automático ao digitar na barra de busca
// Filtra por nome e endereço
```

#### 📍 Geolocalização
```javascript
// Automático ao carregar
// Botão flutuante para recentrar
// Localização em tempo real
```

#### 🛣️ Cálculo de Rota
```javascript
// Click em instituição → Popup
// Clique no botão "Iniciar"
// Rota é calculada via OSRM
// Distância + tempo estimado
```

#### 🗺️ Integração Google Maps
```javascript
// Botão "🗺️ Maps" no popup
// Abre Google Maps em nova aba
// Coordenadas + nome da instituição
```

---

## 🔌 APIs e Endpoints

### GET /api/get_instituicoes.php

Retorna todas as instituições cadastradas em JSON.

**Requisição:**
```bash
GET http://localhost/teste_pin/PIn---2026/api/get_instituicoes.php
```

**Resposta (Sucesso):**
```json
{
  "success": true,
  "total": 42,
  "data": [
    {
      "id": 33,
      "nome": "UPA Piracicamirim",
      "endereco": "Rua Rio Grande do Norte, 135",
      "latitude": -22.73933500,
      "longitude": -47.62728400,
      "especialidades": "Urgência e Emergência",
      "horario_atendimento": "24 horas",
      "contato": "3426-4973",
      "detalhes": "Unidade de nível secundário...",
      "url_imagem": null,
      "atualizado_em": "2026-05-22 19:47:32"
    }
    // ... mais instituições
  ]
}
```

**Resposta (Erro):**
```json
{
  "success": false,
  "message": "Erro ao conectar ao banco de dados"
}
```

### OSRM Route API

API externa para cálculo de rotas (gratuito).

**Endpoint:**
```
https://router.project-osrm.org/route/v1/driving/{lng},{lat};{lng},{lat}?overview=full
```

**Exemplo:**
```
https://router.project-osrm.org/route/v1/driving/-47.649,-22.726;-47.627,-22.739?overview=full&steps=true
```

**Resposta:**
```json
{
  "code": "Ok",
  "routes": [
    {
      "distance": 4532.5,      // metros
      "duration": 324.2,       // segundos
      "geometry": {
        "coordinates": [[-47.649, -22.726], ...]
      }
    }
  ]
}
```

---

## 🏗️ Arquitetura

### Classe `SistemaNavegacao`

Arquivo: `js/navegacao.js`

#### Estrutura
```javascript
class SistemaNavegacao {
    constructor()                          // Inicialização
    inicializar()                          // Setup completo
    capturar_elementos_dom()               // Referências do DOM
    inicializar_mapa()                     // Leaflet setup
    configurar_eventos()                   // Event listeners
    
    // Geolocalização
    obter_localizacao_usuario()            // Pedir localização
    adicionar_marcador_usuario()           // Marcar posição do usuário
    centralizar_mapa_usuario()             // Centralizar em usuário
    
    // Instituições
    carregar_instituicoes()                // Fetch API
    plotar_marcadores_instituicoes()       // Adicionar marcadores
    adicionar_marcador_instituicao()       // Marcador individual
    criar_popup_instituicao()              // HTML do popup
    selecionar_instituicao()               // Ativar seleção
    atualizar_sidebar_instituicoes()       // Listar instituições
    
    // Roteamento
    iniciar_rota()                         // Iniciar navegação
    calcular_rota_osrm()                   // Chamar OSRM
    desenhar_rota()                        // Polyline no mapa
    mostrar_painel_rota()                  // Sidebar direito
    iniciar_atualizacao_rota()             // Atualizar periódicamente
    parar_rota()                           // Cancelar navegação
    
    // Utilidades
    filtrar_instituicoes()                 // Busca
    abrir_no_google_maps()                 // Link externo
    mostrar_loading()                      // Spinner
    mostrar_toast()                        // Notificações
    formatar_distancia()                   // 4532m → 4.5km
    formatar_duracao()                     // 324s → 5min 24s
    escapar_html()                         // XSS prevention
}
```

#### Fluxo de Dados
```
┌─────────────────┐
│   navegacao.html │
│   (Interface)    │
└────────┬─────────┘
         │
         ▼
┌─────────────────┐
│  navegacao.js   │
│   (Lógica)      │
└────────┬─────────┘
         │
    ┌────┴────┬──────────┬──────────┐
    │          │          │          │
    ▼          ▼          ▼          ▼
┌────────┐ ┌──────┐ ┌──────┐ ┌─────────┐
│Leaflet │ │OSRM  │ │Geoloc│ │ PHP API │
└────────┘ └──────┘ └──────┘ └─────────┘
```

---

## ⚠️ Tratamento de Erros

### Tipos de Erro Tratados

#### 1. Falha de Geolocalização
```javascript
// Comportamento:
// - User nega permissão → Usa localização padrão
// - Timeout → Usa localização padrão
// - Erro do navegador → Usa localização padrão
// - Default: Piracicaba [-22.726, -47.649]
```

#### 2. Falha ao Carregar Instituições
```javascript
// Comportamento:
// - Timeout > 10s → Erro exibido
// - HTTP erro → Mensagem de erro
// - JSON inválido → Erro capturado
// - Fallback: Array vazio, sem marcadores
```

#### 3. Falha ao Calcular Rota
```javascript
// Comportamento:
// - OSRM indisponível → Erro exibido
// - Coordenadas inválidas → Erro capturado
// - Timeout > 10s → Erro
// - Fallback: Toast de erro, sem rota desenhada
```

#### 4. Erros de Segurança (XSS)
```javascript
// Método: escapar_html()
// Previne: <script>, onclick=, onerror=
// Aplicado em: Popups, Sidebar, Notifications
```

### Console de Erros
```javascript
// Todos os erros são logados no console
// Formato: ❌ [Tipo] Mensagem
console.error('❌ Erro ao carregar:', erro);
```

### Notificações de Erro ao Usuário
```javascript
// Toast automático
this.mostrar_toast('Erro ao calcular rota', 'error');
```

---

## ⚡ Otimizações e Performance

### 1. Carregamento Assíncrono
```javascript
// Fetch com timeout
const response = await Promise.race([
    fetch(url),
    new Promise((_, reject) =>
        setTimeout(() => reject(new Error('Timeout')), 10000)
    )
]);
```

### 2. Debounce em Busca
```javascript
// Filtro executado ao digitar (sem debounce atualmente)
// Sugestão: Adicionar debounce de 300ms
const searchInput = document.querySelector('.search-bar input');
let debounceTimer;
searchInput.addEventListener('input', (e) => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => {
        this.filtrar_instituicoes(e.target.value);
    }, 300);
});
```

### 3. Cache de Instituições
```javascript
// Instituições carregadas uma única vez na inicialização
// Reutilizadas em todos os filtros/buscas
// Estado: this.estado.instituicoes
```

### 4. Lazy Loading de Marcadores
```javascript
// Todos os marcadores criados uma única vez
// Armazenados em Map para acesso O(1)
// this.estado.marcadores_instituicoes.get(id)
```

### 5. Eventos Delegados
```javascript
// Click em instituição feito via onclick inline
// Evita múltiplos event listeners
```

### 6. Animações CSS vs JS
```css
/* CSS3 animations são mais performáticas */
@keyframes pulse {
    0%, 100% { box-shadow: ... }
    50% { box-shadow: ... }
}
```

### 7. Media Queries Otimizadas
```css
/* Breakpoints: 768px, 480px */
/* Estilos responsivos sem JavaScript desnecessário */
```

---

## ✅ Boas Práticas

### 1. Código Limpo e Legível
```javascript
// ✅ Bom
const distancia_km = (rota.distancia / 1000).toFixed(1);

// ❌ Evitar
const d = r.d / 1000;
```

### 2. Nomenclatura Significativa
```javascript
// ✅ Bom
obter_localizacao_usuario()
mostrar_painel_rota()
calcular_rota_osrm()

// ❌ Evitar
get_pos()
show_panel()
calc_route()
```

### 3. Comentários Úteis
```javascript
/**
 * Calcula rota via OSRM
 * @param {Array} origem - [lng, lat]
 * @param {Array} destino - [lng, lat]
 * @returns {Object} { coordenadas, distancia, duracao }
 */
async calcular_rota_osrm(origem, destino) { }
```

### 4. Tratamento de Erros
```javascript
try {
    await this.carregar_instituicoes();
} catch (erro) {
    console.error('❌ Erro:', erro);
    this.mostrar_toast('Erro ao carregar', 'error');
} finally {
    this.mostrar_loading(false);
}
```

### 5. Segurança (XSS Prevention)
```javascript
// ✅ Bom - Escapa HTML
let html = `<div>${this.escapar_html(nome)}</div>`;

// ❌ Evitar - Vulnerável a XSS
let html = `<div>${nome}</div>`;
```

### 6. Responsive Design Mobile-First
```css
/* ✅ Mobile first */
.container { padding: 8px; }
@media (min-width: 768px) {
    .container { padding: 16px; }
}

/* ❌ Evitar - Desktop first */
```

### 7. Acessibilidade
```html
<!-- ✅ Bom - ARIA labels -->
<button title="Buscar" aria-label="Buscar instituição">🔍</button>

<!-- ❌ Evitar -->
<button>🔍</button>
```

### 8. Performance
```javascript
// ✅ Bom - Evitar repetidos querySelectorAll
const elementos = document.querySelectorAll('.item');

// ❌ Evitar - O(n) loop com querySelectorAll dentro
this.estado.instituicoes.forEach(inst => {
    document.querySelector('.item').innerHTML = inst.nome; // Ruim!
});
```

---

## 🔧 Troubleshooting

### Problema: "Geolocalização não funciona"

**Causa:** Navegador nega permissão ou não tem HTTPS

**Solução:**
```
1. Habilitar localização nas configurações do navegador
2. Usar HTTPS em produção (geolocation requer https://)
3. Verificar console (F12) para mensagens de erro
4. Sistema usa fallback automático (Piracicaba)
```

### Problema: "Instituições não aparecem no mapa"

**Causa:** Falha ao buscar da API

**Solução:**
```
1. Verificar console (F12 → Network)
2. Testar http://localhost/teste_pin/PIn---2026/api/get_instituicoes.php
3. Checar conexão com banco de dados
4. Validar SQL: SELECT COUNT(*) FROM instituicoes;
5. Recarregar página (Ctrl+F5)
```

### Problema: "Rota não calcula"

**Causa:** OSRM indisponível ou coordenadas inválidas

**Solução:**
```
1. Verificar console para erros
2. Testar OSRM diretamente:
   https://router.project-osrm.org/route/v1/driving/-47.649,-22.726;-47.627,-22.739
3. Validar latitudes entre -90 e 90
4. Validar longitudes entre -180 e 180
5. Usar proxy se OSRM bloqueado (produção)
```

### Problema: "Mapa branco/vazio"

**Causa:** Leaflet não carregou do CDN

**Solução:**
```
1. Verificar conexão com internet
2. Verificar console para erros de CDN
3. Usar fallback local do Leaflet:
   - Baixar leaflet-1.9.4.zip
   - Servir localmente
4. Verificar atributo id="mapa"
```

### Problema: "Estilos CSS não aplicados"

**Causa:** CSS não encontrado ou cache

**Solução:**
```
1. Hard refresh: Ctrl+Shift+R (Chrome) ou Cmd+Shift+R (Mac)
2. Verificar caminho: /css/navegacao.css
3. Verificar status HTTP: 200 (não 404)
4. Desabilitar cache do navegador (DevTools)
```

### Problema: "Performance lenta com muitas instituições"

**Causa:** Muitos marcadores/eventos/re-renders

**Solução:**
```
1. Implementar clustering de marcadores (Leaflet.markercluster)
2. Adicionar debounce na busca (300ms)
3. Usar virtual scrolling na sidebar
4. Paginar instituições (load mais → carregar 20 por vez)
5. Remover instituições inativas da exibição
```

---

## 📈 Roadmap Futuro

- [ ] Clustering de marcadores (muitas instituições)
- [ ] Offline mode com service workers
- [ ] Compartilhamento de rotas via URL
- [ ] Histórico de rotas
- [ ] Modo dark theme
- [ ] Suporte a múltiplos idiomas
- [ ] Chat com suporte
- [ ] Avaliações de instituições
- [ ] Integração com Waze/Apple Maps
- [ ] PWA (Progressive Web App)

---

## 📝 Licença

Projeto desenvolvido para PIN 2026. Uso livre dentro do contexto.

---

## 👨‍💻 Desenvolvedor

Desenvolvido com ❤️ para o sistema PIN 2026 de navegação em instituições de saúde.

---

## 📞 Suporte

Para dúvidas ou erros:
1. Verificar console do navegador (F12)
2. Revisar seção Troubleshooting
3. Testar APIs separadamente
4. Consultar documentação oficial:
   - Leaflet: https://leafletjs.com/
   - OSRM: http://project-osrm.org/
   - MDN Geolocation: https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API
