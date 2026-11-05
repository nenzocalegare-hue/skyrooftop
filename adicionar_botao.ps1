$dir="C:\Users\aluno\skyrooftop-deploy"
$btn="`n<div style='text-align:center;padding:20px 0;'><a href='https://wa.me/5511975696266' target='_blank' style='display:inline-block;padding:15px 30px;background:#25D366;color:#fff;text-decoration:none;border-radius:50px;font-weight:bold;font-size:16px;box-shadow:0 4px 6px rgba(0,0,0,0.1);'>Falar no WhatsApp</a></div>"
@("$dir\index.html", "$dir\reserva.html", "C:\Users\aluno\skyrooftop-landing.html") | ForEach-Object {
    if (Test-Path $_) {
        $c = Get-Content $_ -Raw -Encoding UTF8
        if ($c -notmatch "wa.me/5511975696266") {
            $c -replace "</form>", "</form>$btn" | Set-Content $_ -Encoding UTF8
            Write-Host "Botão adicionado em $_" -ForegroundColor Green
        }
    }
}
cd $dir
git add .
git commit -m "Adicionar botao de WhatsApp"
git push origin main
