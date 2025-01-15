FROM python:3.13.0

#pasta aonde fica a aplicação
WORKDIR /app 

#Copiar os arquivos requirements para instalar
COPY requirements.txt .

#Instalação dos pacotes
RUN pip install -r requirements.txt
COPY . /app/

#expor a porta
EXPOSE 5000

#comando de inicialização que só é executado na inicialização
CMD [ "gunicorn", "--bind", "0.0.0.0:5000", "app:app" ]