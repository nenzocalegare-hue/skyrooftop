if(-not (Get-Command netlify -ErrorAction SilentlyContinue)){ npm install -g netlify-cli }
netlify status 2>$null
if($LASTEXITCODE -ne 0){ netlify login }
if(-not (Test-Path "deploy-final")){ New-Item -ItemType Directory "deploy-final" | Out-Null }
Copy-Item "C:\Users\aluno\skyrooftop-landing.html" "deploy-final\index.html" -Force
netlify deploy --prod --dir=deploy-final
Start-Process "https://bucolic-marigold-0fbcb5.netlify.app/"
