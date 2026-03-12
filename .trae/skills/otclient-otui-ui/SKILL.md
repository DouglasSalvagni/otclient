---
name: "otclient-otui-ui"
description: "Projeta interfaces OTClient com OTUI e CSS-like. Use quando criar telas, estilizar widgets, definir estados visuais e ligar eventos Lua da UI."
---

# OTClient OTUI UI

## Quando usar

- Ao criar ou ajustar interfaces em arquivos `.otui`
- Ao estilizar widgets com padrão CSS-like em `data/styles/custom.css`
- Ao usar âncoras, layouts, estados (`$hover`, `$checked`, `$disabled`) e bindings de evento
- Ao organizar tema e tokens visuais com variáveis OTML (`&` e `$`)

## Fundamentos OTUI no projeto

- Widgets e herança: `WidgetFilho < WidgetBase`
- Hierarquia por indentação
- Props comuns: `anchors`, `margin-*`, `padding`, `width`, `height`, `color`, `image-*`
- Eventos inline: `@onClick`, `@onSetup`, `@onEnter`, `@onEscape`
- Texto/tooltip localizável: `!text: tr('...')`, `!tooltip: tr('...')`

## Estados visuais

- `$hover`, `$pressed`, `$checked`, `$disabled`, `$focus`
- Combinações como `$on !checked` e `$!checked`
- Use estados para feedback visual e não para lógica complexa de negócio

## Layout e posicionamento

- Prefira `anchors` para responsividade
- Use `prev` para encadear blocos verticais em formulários
- Use `layout:` (`verticalBox`, `horizontalBox`, `grid`) para listas e painéis compostos
- Mantenha tamanhos fixos somente quando necessário para consistência visual

## Variáveis OTML e campos Lua

- Definição de variável OTML: `&TOKEN: valor`
- Referência OTML: `propriedade: $TOKEN`
- `&` também cria campo Lua no widget
- Evite colisão de nomes entre tokens de estilo e campos Lua
- Para tokens compartilhados, prefira variáveis no nível raiz do arquivo

## CSS-like do projeto

- O arquivo `data/styles/custom.css` aplica ajustes globais por tipo de widget
- Regras comuns:
  - padding/margins padronizados
  - tamanhos de componentes base
  - refinamento visual de widgets reutilizados
- Ao ajustar UI global, altere CSS-like com impacto mínimo e previsível

## Integração Lua + UI

- Carregue com `g_ui.loadUI('arquivo', parent)` para painel no parent definido
- Ou `g_ui.displayUI('arquivo')` para exibição direta
- Capture elementos por `id` e conecte callbacks no Lua
- Sempre destrua a UI no `terminate()`

## Checklist de qualidade de interface

- IDs claros e estáveis para widgets usados no Lua
- Estados visuais consistentes com os componentes do jogo
- Sem sobreposição de widgets em resoluções comuns
- Textos localizáveis e tooltips claros
- Hooks de evento funcionam sem duplicidade após reload
- UI é destruída corretamente no unload
