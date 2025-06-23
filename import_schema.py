
import psycopg2

conn = psycopg2.connect("postgresql://postgres:PSSNHPpxjsQFhtMvpcBieZcluOvLkAjz@postgres.railway.internal:5432/railway")
cur = conn.cursor()

with open("full_postgres_schema.sql", "r", encoding="utf-8") as f:
    sql = f.read()

cur.execute(sql)
conn.commit()
cur.close()
conn.close()

print("✅ База успешно импортирована!")
