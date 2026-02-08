from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello from Flask!'

if __name__ == '__main__':
    # Para que a aplicação seja acessível de fora do WSL (ou seja, do seu navegador Windows)
    # precisamos que ela escute em '0.0.0.0'. A porta padrão do Flask é 5000.
    app.run(host='127.0.0.1', port=5000)