
from flask import Flask
import psycopg2
import os

app = Flask(__name__)

@app.route("/")
def index():
    try:
        conn = psycopg2.connect(os.getenv("DATABASE_URL"))
        cur = conn.cursor()
        cur.execute("SELECT NOW();")
        result = cur.fetchone()
        return f"✅ Успешное подключение к базе данных! Время: {result[0]}"
    except Exception as e:
        return f"❌ Ошибка подключения: {str(e)}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
