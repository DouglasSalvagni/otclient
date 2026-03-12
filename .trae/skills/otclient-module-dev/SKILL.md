---
name: "otclient-module-dev"
description: "Cria e mantém módulos OTClient em Lua/OTUI/OTMOD. Use quando implementar lógica de negócio, eventos de jogo, telas e integração entre módulos."
---

# OTClient Module Dev

## Quando usar

- Ao criar um módulo novo em `modules/<nome-do-modulo>/`
- Ao adicionar lógica de negócio em Lua com ciclo `init()/terminate()`
- Ao integrar o módulo com `g_game`, `g_ui`, `g_settings` e outros módulos
- Ao configurar carregamento em `.otmod` com `dependencies`, `autoload` e `load-later`

## Estrutura mínima de módulo

- Arquivo de manifesto: `<modulo>.otmod`
- Script principal Lua: `<modulo>.lua` (ou lista em `scripts`)
- Interface OTUI opcional: `<modulo>.otui`

## Padrão de manifesto `.otmod`

- Defina `Module`, `name`, `description`, `sandboxed`
- Use `scripts: [ arquivo1, arquivo2 ]` sem extensão
- Use `dependencies` para garantir ordem de carga obrigatória
- Use `load-later` para carregar módulos complementares após o módulo atual
- Use `@onLoad` e `@onUnload` chamando `init()` e `terminate()` (ou Controller equivalente)

## Padrão de ciclo de vida em Lua

- Em `init()`:
  - carregar UI com `g_ui.loadUI(...)` ou `g_ui.displayUI(...)` quando necessário
  - `connect(...)` nos eventos usados
  - registrar keybinds e callbacks
  - ler estados persistidos em `g_settings`
- Em `terminate()`:
  - `disconnect(...)` de todos os eventos registrados
  - remover keybinds criados
  - destruir widgets com `:destroy()`
  - limpar referências (`widget = nil`)

## Integração entre módulos

- Acesse APIs por `modules.<nome_modulo>`
- Verifique existência antes de integrar módulos opcionais
- Prefira funções públicas pequenas para não acoplar internals de outros módulos

## Padrão Controller (modulelib)

- Quando o módulo for maior, use `Controller:new()` e `setUI(...)`
- Coloque boot de módulo em `onInit`
- Coloque lógica sensível ao estado online em `onGameStart`/`onGameEnd`
- Registre eventos por `registerEvents` e `registerUIEvents` para cleanup automático

## Checklist de implementação

- `.otmod` com `name` e `scripts` corretos
- Dependências mínimas corretas
- Sem `connect` sem `disconnect`
- Sem widget criado sem `:destroy()`
- Sem keybind criado sem remoção
- Funciona com hot reload sem duplicar UI/eventos
- Não quebra quando o jogador desloga/loga

## Fluxo recomendado

1. Criar pasta do módulo em `modules/`
2. Escrever `.otmod` com ciclo de carga
3. Implementar `init()/terminate()` no Lua
4. Criar OTUI somente para a UI necessária
5. Integrar com `modules.<outro_modulo>` apenas via API pública
6. Validar login/logout, reload do módulo e estabilidade da UI
