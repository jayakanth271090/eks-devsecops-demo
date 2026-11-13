from flask import Flask, jsonify
import os

app = Flask("__name__")

@app.route("/")
def home():
    return jsonify({
        "status": "Helthy",
        "service": "ecommerce-api",
        "version": os.getenv("APP_VERSION","v1.0.0")
        })

@app.route("/health")
def health():
    return "ok", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)