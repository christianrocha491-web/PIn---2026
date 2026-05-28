# ⚡ Guia Rápido de Instalação - Sistema de Navegação PIN 2026

## Instalação em 3 Passos

### 1️⃣ Copiar Arquivos

```bash
# Copie para: c:\xampp\htdocs\teste_pin\PIn---2026\

✅ navegacao.html          (HTML principal)
✅ css/navegacao.css        (Estilos)
✅ js/navegacao.js          (Lógica)
✅ api/get_instituicoes.php (API Backend)
```

### 2️⃣ Verificar Banco de Dados

```bash
# Abrir XAMPP e ir a: http://localhost/phpmyadmin/
1. Base: pin2026
2. Tabela: instituicoes
3. Registros: > 0 (pode estar vazia, é normal)

# Se não existir a tabela, executar SQL:
#   sql/pin2026 (1).sql
```

### 3️⃣ Acessar no Navegador

```
http://localhost/teste_pin/PIn---2026/navegacao.html
```

---

## ✅ Checklist de Funcionamento

- [ ] **Página carrega sem erros** (verificar console F12)
- [ ] **Mapa aparece** (OpenStreetMap cinza/bege)
- [ ] **Pede localização** (aviso no navegador)
- [ ] **Marcadores aparecem** (bolinhas vermelhas/verdes no mapa)
- [ ] **Sidebar lista instituições** (esquerda)
- [ ] **Busca funciona** (digitar na barra)
- [ ] **Clique em instituição** (popup com detalhes)
- [ ] **Rota calcula** (clique no botão "Iniciar Rota")
- [ ] **Rota desenha** (linha azul no mapa)

---

## 🔧 Configurações Recomendadas

### Aumentar Timeout para Rotas Grandes

`js/navegacao.js` - Linha ~50:

```javascript
this.config = {
    zoom_inicial: 14,
    osrm_url: 'https://router.project-osrm.org/route/v1/driving',
    timeout_fetch: 15000,  // ⬅️ Aumentado de 10000 para 15000ms
    refresh_rota_intervalo: 5000,
};
```

### Usar OSRM Local (Recomendado para Produção)

Se o OSRM público ficar lento, instale localmente:

```bash
# Docker: docker run -p 5000:5000 osrm/osrm-backend
# Depois alterar em js/navegacao.js:

this.config = {
    osrm_url: 'http://localhost:5000/route/v1/driving',
    // ... resto da config
};
```

### Limitar Zoom Mínimo

`js/navegacao.js` - Linha ~123:

```javascript
this.estado.mapa = L.map(this.elementos.mapa_container).setView(
    piracicaba,
    this.config.zoom_inicial,
    { minZoom: 8, maxZoom: 19 }  // ⬅️ Adicionar
);
```

---

## 🎨 Customizações Visuais

### Mudar Cor do Tema Principal

`css/navegacao.css` - Linha ~12:

```css
:root {
    --primary-color: #1f77d2;        /* Azul padrão */
    --primary-hover: #1a5fa8;
    /* Mudar para: */
    --primary-color: #00b894;        /* Verde */
    --primary-hover: #00a881;
}
```

### Mudar Localização Padrão (não Piracicaba)

`js/navegacao.js` - Linha ~130:

```javascript
const piracicaba = [-22.726226, -47.649373];  // ⬅️ Mudar coordenadas
```

Encontrar coordenadas: https://www.google.com/maps

### Mudar Ícone de Instituição

`js/navegacao.js` - Linha ~350:

```javascript
// Mudar emoji 🏥 para outro:
// 🏨 🏪 🏬 ⚕️ 🩺 💊 🔬
<span>⚕️</span>  // ⬅️ Trocar emoji
```

---

## 📱 Responsividade

### Testar em Mobile

```bash
# Chrome DevTools:
1. Pressione F12
2. Ctrl+Shift+M (mobile view)
3. Testar em diferentes resoluções
```

**Breakpoints:**
- 📱 < 480px: Mobile pequeno
- 📱 480-768px: Tablet
- 💻 > 768px: Desktop

---

## 🐛 Debug Mode

### Ativar Logs Completos

`js/navegacao.js` - Adicione no início:

```javascript
// Debug mode
const DEBUG = true;
const log = (msg, data = null) => {
    if (DEBUG) {
        console.log(`[PIN] ${msg}`, data || '');
    }
};
```

### Monitorar Requisições

```bash
Chrome DevTools:
1. F12
2. Aba "Network"
3. Fazer ações (buscar instituições, calcular rota)
4. Ver requisições HTTP
```

### Inspecionar Estado da Aplicação

```javascript
# Console (F12 > Console):
sistemaNavegacao.estado           # Estado atual
sistemaNavegacao.estado.mapa       # Instância Leaflet
sistemaNavegacao.elementos         # Referências DOM
```

---

## 🚀 Deploy em Produção

### Pré-requisitos
- ✅ HTTPS obrigatório (geolocation)
- ✅ PHP 7.4+
- ✅ MariaDB/MySQL

### Checklist

```bash
☑ Transferir arquivos via SFTP
☑ Alterar credenciais BD (usuário/senha)
☑ Minificar CSS/JS (opcional)
☑ Habilitar CORS se necessário
☑ Testar geolocation (HTTPS)
☑ Testar OSRM (pode ser bloqueado)
☑ Adicionar SSL/TLS
☑ Configurar cache HTTP headers
☑ Monitorar performance
☑ Backup do banco regularmente
```

### Exemplo .htaccess para Cache

```apache
# .htaccess na raiz
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType text/html "access plus 1 hour"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType text/javascript "access plus 1 month"
    ExpiresByType image/* "access plus 1 month"
</IfModule>
```

---

## 📊 Monitoração

### Métricas Importantes

```javascript
// Tempo de carregamento
const t_inicio = performance.now();
await sistemaNavegacao.carregar_instituicoes();
const t_fim = performance.now();
console.log(`Carregamento: ${(t_fim - t_inicio).toFixed(2)}ms`);

// Quantidade de marcadores
console.log(`Marcadores: ${sistemaNavegacao.estado.marcadores_instituicoes.size}`);

// Localização do usuário
console.log('Localização:', sistemaNavegacao.estado.usuario_localizacao);
```

---

## 🆘 Erros Comuns

| Erro | Solução |
|------|---------|
| `Cannot read property 'id' of undefined` | Instituições não carregaram. Verificar API/BD |
| `Geolocation permission denied` | Usuário negou. Usar fallback automático |
| `OSRM: invalid request` | Coordenadas inválidas. Verificar formato |
| `CSS não carrega` | Caminho errado. Usar `/css/navegacao.css` |
| `Mapa branco` | Leaflet CDN indisponível. Tentar refresh |

---

## 💡 Dicas Pro

1. **Usar devtools debugger para pausar execução**
   ```javascript
   debugger;  // Pausa aqui quando DevTools aberto
   ```

2. **Performance: Desabilitar animações se lento**
   ```css
   @media (prefers-reduced-motion: reduce) {
       * { animation-duration: 0.01ms !important; }
   }
   ```

3. **Aumentar tamanho do marcador do usuário**
   ```javascript
   // Em adicionar_marcador_usuario()
   width: 40px;  → width: 60px;
   ```

4. **Salvar preferências do usuário em localStorage**
   ```javascript
   localStorage.setItem('zoom_preferido', 15);
   localStorage.getItem('zoom_preferido');
   ```

5. **Compartilhar rota via URL**
   ```javascript
   const params = new URLSearchParams();
   params.set('to_id', instituicao.id);
   window.location.hash = params.toString();
   ```

---

## 📚 Recursos Úteis

- **Leaflet Docs**: https://leafletjs.com/reference.html
- **OpenStreetMap**: https://www.openstreetmap.org/
- **OSRM**: http://project-osrm.org/docs/v5.24.0/api/
- **MDN Web Docs**: https://developer.mozilla.org/
- **Coordenadas**: https://www.latlong.net/
- **Color Picker**: https://htmlcolorcodes.com/

---

## 📞 Suporte Rápido

**Problema**: Sistema não inicia
**Verificação**:
1. `http://localhost/teste_pin/PIn---2026/navegacao.html` é acessível?
2. Console (F12) mostra erros?
3. Banco de dados conecta?

**Próximo passo**: Consultar seção Troubleshooting em `NAVEGACAO_README.md`

---

✅ **Pronto! Sistema de navegação configurado com sucesso!**

Enjoy! 🚀🗺️
