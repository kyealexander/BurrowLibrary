def naive_sanitise(s: str) -> str:
    return s.replace("../", "")
