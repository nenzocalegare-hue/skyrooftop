<#
.SYNTAX
    .\deploy_skyrooftop.ps1

.DESCRIPTION
    Script de deploy do projeto Skyrooftop com webhook para WhatsApp (grátis - Meta Cloud API)

.NOTES
    1. Preencha as variáveis abaixo com suas credenciais do WhatsApp Cloud API
    2. Execute: .\deploy_skyrooftop.ps1
#>

# ============================================
# CONFIGURAÇÕES DO WHATSAPP CLOUD API (META)
# ============================================
# Para obter:
# 1. Acesse: https://developers.facebook.com/apps
# 2. Crie um app → WhatsApp Cloud API
# 3. Obtenha: Phone Number ID e Access Token
# 4. Configure o número whatssapp (ex: +5511975696266)

$env:WHATSAPP_PHONE_ID = "SEU_PHONE_NUMBER_ID_AQUI"
$env:WHATSAPP_TOKEN = "SEU_ACCESS_TOKEN_AQUI"
$env:WHATSAPP_RECIPIENT_NO = "+5511975696266"  # Para quem envia a mensagem
$env:WHATSAPP_PHONE = "+5511975696266"  # WhatsApp do cliente (opcional)

# ============================================
# CONFIGURAÇÕES DO PROJETO
# ============================================
$projectPath = "C:\Users\aluno\skyrooftop-deploy\deploy-final"
$siteUrl = "https://bucolic-marigold-0fbcb5.netlify.app"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  DEPLOY SKYROOFTOP - WHATSAPP CLOUD API" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# =====================================================================
# PASSO 1: VERIFICAR ARQUIVOS
# =====================================================================
Write-Host "[1/4] Verificando arquivos..." -ForegroundColor Yellow
if (Test-Path "$projectPath\reserva.html") {
    Write-Host "   Arquivo reserva.html encontrado" -ForegroundColor Green
} else {
    Write-Host "   ERRO: reserva.html não encontrado!" -ForegroundColor Red
    exit
}

if (Test-Path "$projectPath\.netlify\functions\salvar-reserva.js") {
    Write-Host "   Função salvar-reserva.js encontrada" -ForegroundColor Green
} else {
    Write-Host "   ERRO: Função não encontrada!" -ForegroundColor Red
    exit
}

# =====================================================================
# PASSO 2: VERIFICAR FORMULÁRIO
# =====================================================================
Write-Host "[2/4] Verificando formulário..." -ForegroundColor Yellow
$formContent = Get-Content "$projectPath\reserva.html" -Raw
if ($formContent -match "salvar-reserva") {
    Write-Host "   Formulário apontando para a função correta" -ForegroundColor Green
} else {
    Write-Host "   ERRO: Formulário não está configurado!" -ForegroundColor Red
    exit
}

# =====================================================================
# PASSO 3: CONFIGURAR VARIÁVEIS DO WHATSAPP CLOUD API
# =====================================================================
Write-Host "[3/4] Configurando variáveis do WhatsApp Cloud API..." -ForegroundColor Yellow

$env:WHATSAPP_PHONE_ID = $env:WHATSAPP_PHONE_ID
$env:WHATSAPP_TOKEN = $env:WHATSAPP_TOKEN
$env:WHATSAPP_RECIPIENT_NO = $env:WHATSAPP_PHONE

Write-Host "   Variáveis do WhatsApp Cloud API:" -ForegroundColor Green
Write-Host "      WHATSAPP_PHONE_ID: $env:WHATSAPP_PHONE_ID" -ForegroundColor Gray
Write-Host "      WHATSAPP_TOKEN: $env:WHATSAPP_TOKEN" -ForegroundColor Gray
Write-Host "      WHATSAPP_RECIPIENT_NO: $env:WHATSAPP_RECIPIENT_NO" -ForegroundColor Gray

# =====================================================================
# PASSO 4: FAZER DEPLOY
# =====================================================================
Write-Host "[4/4] Fazendo deploy no Netlify..." -ForegroundColor Yellow

$deployPath = Join-Path $PWD "deploy-temp"
New-Item -ItemType Directory -Path $deployPath -Force | Out-Null

Copy-Item "$projectPath\*" $deployPath -Recurse -Force

$deployResult = netlify deploy --prod --dir="$deployPath" --no-build --message="Deploy com webhook WhatsApp Cloud API"

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ DEPLOY CONCLUÍDO COM SUCESSO!" -ForegroundColor Green
    Write-Host "   URL do site: https://bucolic-marigold-0fbcb5.netlify.app" -ForegroundColor Green
} else {
    Write-Host "`n❌ ERRO no deploy!" -ForegroundColor Red
    Write-Host "   Código de saída: $LASTEXITCODE" -ForegroundColor Red
    exit
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  FAÇA O TESTE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Acesse: https://bucolic-marigold-0fbcb5.netlify.app/reserva.html" -ForegroundColor Yellow
Write-Host "2. Preencha o formulário com seus dados" -ForegroundColor Yellow
Write-Host "3. Clique em 'Enviar Reserva'" -ForegroundColor Yellow
Write-Host "4. Verifique a console do navegador (F12) para a mensagem do WhatsApp" -ForegroundColor Yellow
Write-Host "5. Verifique o e-mail recebido de WhatsApp ao invés de envio direto" -ForegroundColor Yellow
Write-Host ""
Write-Host "Pronto! O formulário agora envia dados para o WhatsApp via Cloud API." -ForegroundColor Green
Write-Host ""
