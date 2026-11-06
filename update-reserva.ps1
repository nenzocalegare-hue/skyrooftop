$src='C:\Users\aluno\skyrooftop-landing.html'
Copy-Item $src "$src.bak" -Force
$h=Get-Content $src -Raw -Encoding UTF8
$h=[regex]::Replace($h,'(?s)(<form[^>]*id="reserveForm"[^>]*?)\s+action="[^"]*"','$1 onsubmit="return false"')
$h=[regex]::Replace($h,'(?s)(<form[^>]*id="reserveForm".*?)<button[^>]*type="submit"[^>]*>.*?</button>','$1')
[IO.File]::WriteAllText($src,$h,(New-Object Text.UTF8Encoding $false))
Copy-Item $src .\index.html -Force
Copy-Item $src .\dist\index.html -Force
git add -A
git commit -m "Reserva: remove envio por e-mail, envia apenas por WhatsApp"
git push origin main
