#!/bin/bash

REPOSITORIO_URL="git@github.com:JoaoVitorMVBR/flask-app.git"
DIRETORIO_RAIZ="/home/joaovilas/pessoal/devops"
APP="app.py"

echo " ---INICIANDO--- "

# 1. Clonar/Puxar o repositório Git
if [ ! -d "$DIRETORIO_DEPLOY" ]; then 
    echo "Diretório de deploy '$DIRETORIO_DEPLOY' não encontrado. Clonando repositório..."
    git clone "$REPOSITORIO_URL" "$DIRETORIO_DEPLOY"
    if [ $? -ne 0 ]; then
        echo "ERRO: Falha ao clonar o repositório."
        exit 1
    fi
else
    echo "Diretório de deploy '$DIRETORIO_DEPLOY' encontrado. Atualizando repositório..."
    cd "$DIRETORIO_DEPLOY"
    git pull origin main
    if [ $? -ne 0 ]; then
        echo "AVISO: Falha ao puxar as atualizações do repositório. Pode ser um merge conflict ou outro problema."
        exit 1
    fi
fi
echo "Repositório Git atualizado com sucesso em '$DIRETORIO_DEPLOY'."

#Ativando o virtual enviroment
cd /home/joaovilas/pessoal/devops
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Ativando o venv"
    source .venv/bin/activate
    if [ $? -ne 0 ]; then
        echo "Erro ao iniciar o .venv"
        exit 1
    fi
else
    echo " venv ativo : '$VIRTUAL_ENV' "
fi

#Instalar dependências (Flask e psycopg2-binary)
echo "Instalando/Atualizando dependências Python..."
pip3 install Flask && pip3 install psycopg2-binary
if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao instalar dependências Python." 
    exit 1
fi
echo "Dependências Python instaladas/atualizadas."

#Gerando o requirements.txt
pip freeze > requirements.txt


#Reiniciar o serviço da sua aplicação
echo "Reiniciando aplicação Flask..."

PIDS=$(ps aux | grep "python3 app.py" | grep -v grep | awk '{print $2}')

if [ -n "$PIDS" ]; then
    echo "Processos antigos encontrados ($PIDS). Terminando..."
    kill $PIDS
    sleep 2
    if [ $? -ne 0 ]; then
        echo "AVISO: Falha ao matar processo(s) antigo(s). Pode ser que não estivessem rodando."
    fi
else
    echo "Nenhum processo antigo da aplicação encontrado."
fi

# Inicia a aplicação Flask em segundo plano usando nohup
# A saída será redirecionada para app.log dentro do diretório de deploy
cd $DIRETORIO_DEPLOY
echo $VIRTUAL_ENV
nohup python3 "$APP" > app.log 2>&1 &
if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao iniciar a aplicação Flask."
    exit 1
fi
echo "Aplicação Flask iniciada em segundo plano. Verifique os logs em '$DEPLOY_DIR/app.log'."
echo "--- Processo de deploy finalizado com sucesso! ---"

echo "Acesse sua aplicação em: http://localhost:5000"