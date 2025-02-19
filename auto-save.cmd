cd C:\Program Files\Inductive Automation\Ignition\data\projects
git pull origin test-env
timeout 10
git add .
git commit -m "Designer save"
git push origin
timeout 5