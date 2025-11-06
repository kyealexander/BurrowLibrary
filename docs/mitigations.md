# Mitigations — BurrowLibrary

## Core fixes (high priority)
1. **Decode then canonicalize:**  
Decode percent-encodings **once** and immediately canonicalize / resolve the resulting path. Then verify the resolved path is within the allowed base directory.

Example (Python):
```python
from pathlib import Path
from urllib.parse import unquote_plus

BASE_DIR = Path(__file__).parent.joinpath("storage").resolve()
requested = unquote_plus(request.args.get("file", ""))
candidate = (BASE_DIR / requested).resolve()
if not str(candidate).startswith(str(BASE_DIR)):
    abort(403)
return send_file(str(candidate))
```

2. **Prefer allowlists over filters:**  
If the set of servable files is known, return only names from that list (or expose files by ID). Avoid fragile `.replace()` or regex blacklists.

3. **Avoid naive string filters:**  
Do not attempt to remove `../` from the encoded input with simple `replace()` calls. They are brittle and bypassable via encoding.

## Additional hardening (recommended)
- **Serve static files from a controlled directory** (Flask `static/`) or use framework APIs that map logical names to files.  
- **Run the app as a non-root user** and ensure file permissions limit access to only what is necessary.  
- **Add input validation and logging:** record attempted escapes and suspicious requests for monitoring and grading.  
- **Unit / integration tests:** add tests that include single- and multi-encoded traversal payloads to prevent regressions.

## Short operational notes
- If you must accept arbitrary filenames, canonicalize and compare to a resolved base directory on every request.  
- If possible, return content via a safe API that maps `id -> filename` (an integer or slug) instead of accepting raw file paths.

---

Fixing decode → canonicalize and using allowlists removes the root cause and prevents encoded traversal tricks from succeeding.
