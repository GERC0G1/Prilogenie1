import os
import psycopg2

def run_sql_file(filename):
    with open(filename, 'r', encoding='utf-8') as file:
        sql = file.read()

    conn = psycopg2.connect(os.environ['DATABASE_URL'])
    cur = conn.cursor()
    cur.execute(sql)
    conn.commit()
    cur.close()
    conn.close()
    print("✅ SQL import successful.")

if __name__ == "__main__":
    run_sql_file("full_postgres_schema.sql")
