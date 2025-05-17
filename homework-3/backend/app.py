from flask import Flask
from flask_cors import CORS
import socket

app = Flask(__name__)
CORS(app)  # Esto permite peticiones desde otros orígenes

@app.route('/info')
def get_info():
    return {
        "hostname": socket.gethostname(),
        "ip_address": socket.gethostbyname(socket.gethostname())
    }

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
