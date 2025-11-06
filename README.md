# BurrowLibrary

**A tiny Web/API CTF by Kye Murphy**

**Category:** Web / API · **Difficulty:** Easy

**Description**  
A small library API that serves public files about burrowing animals.  
Exploit the API to burrow past the filters and retrieve the hidden flag.

---

## Context & Lessons Learned

BurrowLibrary was developed as part of a cybersecurity build challenge focused on secure coding and web exploitation.  
The goal was to design a simple yet educational API challenge that demonstrates the risks of improper input sanitisation and double URL encoding.

Through building and testing this challenge, I reinforced key lessons in:
- Understanding URL encoding and how filters can be bypassed when decoding occurs in the wrong order.
- Using Docker to containerise and safely isolate vulnerable web applications.
- Structuring a capture-the-flag challenge that balances accessibility and technical depth.

**References & Further Reading**
- OWASP Path Traversal: https://owasp.org/www-community/attacks/Path_Traversal
- Flask Secure File Serving: https://flask.palletsprojects.com/en/latest/patterns/fileuploads/
- PortSwigger File Path Traversal: https://portswigger.net/web-security/file-path-traversal