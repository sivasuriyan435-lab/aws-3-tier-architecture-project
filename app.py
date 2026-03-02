from flask import Flask, jsonify
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app)


db_config = {
    "host": "ytdb.cpk8oagkgyaz.ap-south-1.rds.amazonaws.com",
    "user": "admin",
    "password": "YOUR_DB_PASSWORD",
    "database": "ytdatabase"
}


def get_connection():
    return mysql.connector.connect(**db_config)


@app.route("/login", methods=["GET"])
def login():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        # Fetch first user (demo purpose)
        cursor.execute("SELECT * FROM users LIMIT 1;")
        user = cursor.fetchone()

        cursor.close()
        conn.close()

        if user:
            return jsonify(user)
        else:
            return jsonify({"message": "No users found"}), 404

    except mysql.connector.Error as err:
        return jsonify({"error": f"Database error: {err}"}), 500
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    print("🚀 Flask app starting on port 5000...")
    app.run(host="0.0.0.0", port=5000, debug=True)
