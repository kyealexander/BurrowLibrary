import os
from flask import Flask, request, send_file, render_template, abort
from urllib.parse import unquote_plus

from util import naive_sanitise

app = Flask(__name__)

BURROW_DIR = os.path.join(os.path.dirname(__file__), "storage")

@app.get("/")
def index():
    files = sorted(os.listdir(BURROW_DIR))
    return render_template("index.html", files=files)

@app.get("/api/get")
def api_get():
    q = request.args.get("file", "")
    if not q:
        abort(400, "missing file parameter")

    cleaned = naive_sanitise(q)
    cleaned = unquote_plus(cleaned)

    candidate = os.path.normpath(os.path.join(BURROW_DIR, cleaned))

    try:
        return send_file(candidate)
    except Exception as e:
        print("DEBUG: send_file exception ->", repr(e))
        abort(404)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
