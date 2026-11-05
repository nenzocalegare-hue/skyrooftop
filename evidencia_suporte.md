# EVIDÊNCIA PARA SUPORTE DO NETLIFY
## Causa Raiz do Problema
O formulário de reserva publicado no Netlify **não possui o atributo data-netlify="true"**, o que impede que o Netlify Forms detecte o formulário e envie notificações de e-mail.

## Detalhes Técnicos
- **Site ID:** 98183b74-5255-483b-af3d-02533ab1b9f2
- **Site URL:** https://bucolic-marigold-0fbcb5.netlify.app
- **Formulário:** reserva
- **E-mail de notificação:** nenzocalegare@gmail.com

## Problema Identificado
O HTML publicado no Netlify no arquivo `reserva.html` possui:
```html
<form method='POST' name='reserva'>
  <input type="hidden" name="form-name" value="reserva">
```

**FALTANDO os atributos:**
- `data-netlify="true"`
- `netlify-honeypot="bot-field"`

## Etapas de Diagnóstico Realizadas

### Etapa 1: Instalação do Netlify CLI
- **Versão:** netlify-cli/27.14.3 win32-x64 node-v26.12.1
- **Status:** Instalado e disponível

### Etapa 2: Autenticação
- **Status:** Configuração pendente
- **Ação necessária:** Definir NETLIFY_AUTH_TOKEN no ambiente

### Etapa 3: Link do Site
- **Site:** bucolic-marigold-0fbcb5
- **Status:** Linkado corretamente
- **Admin URL:** https://app.netlify.com/projects/bucolic-marigold-0fbcb5

### Etapa 4: Verificação via API
- **Resultado:** Acesso negado (token não configurado)
- **Motivo:** NETLIFY_AUTH_TOKEN não está definido no ambiente

## Recomendação de Correção
1. Atualizar o HTML do formulário com os atributos corretos:
```html
<form name="reserva" method="POST" data-netlify="true" netlify-honeypot="bot-field">
  <input type="hidden" name="form-name" value="reserva">
  <input type="text" name="bot-field" style="display:none">
</form>
```

2. Fazer deploy do site no Netlify

3. Verificar no painel do Netlify que o formulário aparece em "Forms"

4. Testar o envio com um e-mail real

## Observações
- O site está publicado e acessível
- As fotos e páginas estão funcionando corretamente
- O problema é específico da configuração do formulário
- O Netlify CLI está instalado e o site está linkado
