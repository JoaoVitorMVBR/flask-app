#!/bin/bash

REPOSITORIO_URL="git@github.com:JoaoVitorMVBR/flask-app.git"
DIRETORIO_DEPLOY="/home/joaovilas/pessoal/devops/flask-app"
APP="app.py"

echo " ---INICIANDO--- "

# 1. Clonar/Puxar o repositório Git
if [ ! -d "$DIRETORIO_DEPLOY" ]; then # se FALSE o operador ! passa para TRUE e entra na condição
    echo "Diretório de deploy '$DIRETORIO_DEPLOY' não encontrado. Clonando repositório..."
    git clone "$REPOSITORIO_URL" "$DIRETORIO_DEPLOY"
    if [ $? -ne 0 ]; then
        echo "ERRO: Falha ao clonar o repositório."
        exit 1
    fi
else
    echo "Diretório de deploy '$DIRETORIO_DEPLOY' encontrado. Atualizando repositório..."
    cd "$DIRETORIO_DEPLOY"
    git pull origin main # Assumindo que a branch principal é 'main'
    if [ $? -ne 0 ]; then
        echo "AVISO: Falha ao puxar as atualizações do repositório. Pode ser um merge conflict ou outro problema."
        # No deploy, falha ao puxar é um erro sério. Em pipelines mais avançados, isso seria mais robusto.
        exit 1
    fi
    cd - > /home/joaovilas/pessoal/devops/ # Volta ao diretório anterior (my-flask-app)
fi
echo "Repositório Git atualizado com sucesso em '$DIRETORIO_DEPLOY'."

# 2. Instalar dependências (Flask)
echo "Instalando/Atualizando dependências Python..."
cd "$DIRETORIO_DEPLOY"
pip3 install Flask
if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao instalar dependências Python." 
    exit 1
fi
echo "Dependências Python instaladas/atualizadas."

# 3. Reiniciar o serviço da sua aplicação
echo "Reiniciando aplicação Flask..."

# Encontra e mata o processo Python da nossa aplicação Flask
# Isso é um método simples para um app de desenvolvimento. Em produção, você usaria systemd/gunicorn.
PIDS=$(ps aux | grep "$DEPLOY_DIR/$APP" | grep -v grep | awk '{print $2}')

if [ -n "$PIDS" ]; then
    echo "Processos antigos encontrados ($PIDS). Terminando..."
    kill $PIDS
    sleep 2 # Dá um tempo para os processos terminarem
if [ $? -ne 0 ]; then
    echo "AVISO: Falha ao matar processo(s) antigo(s). Pode ser que não estivessem rodando."
fi
else
    echo "Nenhum processo antigo da aplicação encontrado."
fi

# Inicia a aplicação Flask em segundo plano usando nohup
# A saída será redirecionada para app.log dentro do diretório de deploy
nohup python3 "$APP_FILE" > app.log 2>&1 &
if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao iniciar a aplicação Flask."
    exit 1
fi
echo "Aplicação Flask iniciada em segundo plano. Verifique os logs em '$DEPLOY_DIR/app.log'."
echo "--- Processo de deploy finalizado com sucesso! ---"

# O servidor Flask escuta na porta 5000 por padrão
echo "Acesse sua aplicação em: http://localhost:5000"