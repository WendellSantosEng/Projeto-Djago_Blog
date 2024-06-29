# Use a imagem base do Python
FROM python:3.11.3-alpine3.18

# Defina o mantenedor do Dockerfile
LABEL maintainer="wendellsdev@gmail.com"

# Variável de ambiente para não escrever bytecode (.pyc)
ENV PYTHONDONTWRITEBYTECODE 1

# Variável de ambiente para saída não armazenada em buffer
ENV PYTHONUNBUFFERED 1

# Define o diretório de trabalho
WORKDIR /djangoapp

# Copia a pasta "djangoapp" e "scripts" para dentro do contêiner
COPY djangoapp /djangoapp
COPY scripts /scripts

# Exponha a porta 8000 (se necessário)
EXPOSE 8000

# Executa comandos para configurar o ambiente e instalar dependências
RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /djangoapp/requirements.txt && \
    adduser --disabled-password --no-create-home duser && \
    mkdir -p /data/web/static && \
    mkdir -p /data/web/media && \
    chown -R duser:duser /venv && \
    chown -R duser:duser /data/web/static && \
    chown -R duser:duser /data/web/media && \
    chmod -R 755 /data/web/static && \
    chmod -R 755 /data/web/media && \
    chmod -R +x /scripts

# Adiciona a pasta scripts e venv/bin no $PATH do contêiner
ENV PATH="/scripts:/venv/bin:$PATH"

# Muda o usuário para duser
USER duser

# Comando padrão a ser executado quando um contêiner baseado neste Dockerfile for iniciado
CMD ["sh", "/scripts/commands.sh"]
