# Exercises 0.1.-0.6.

## 0.1: HTML
Review the basics of HTML.

## 0.2: CSS
Review the basics of CSS.

## 0.3: HTML forms
Learn about the basics of HTML forms.

## 0.4: New note diagram

```mermaid
sequenceDiagram
    participant browser
    participant server
    browser->>server: HTTP POST https://studies.cs.helsinki.fi/exampleapp/new_note
    activate server
    server-->>browser: HTTP status code 302
    deactivate server
    Note over browser, server: URL redirect 
    browser->>server: HTTP GET https://studies.cs.helsinki.fi/exampleapp/notes
    activate server
    server-->>browser: HTML document
    deactivate server
    browser->>server: GET https://studies.cs.helsinki.fi/exampleapp/main.css
    activate server
    server-->>browser: the CSS file
    deactivate server
    browser->>server: GET https://studies.cs.helsinki.fi/exampleapp/main.js
    activate server
    server-->>browser: the JavaScript file
    deactivate server
    browser->>server: GET https://studies.cs.helsinki.fi/exampleapp/data.json
    activate server
    server-->>browser: [{"content":"JSON data", "date":"2023-2-14"},...]
    deactivate server
```

## 0.5: Single page app diagram

```mermaid
sequenceDiagram
    title Single page app
    participant browser
    participant server
    browser->>server: HTTP GET https://studies.cs.helsinki.fi/exampleapp/spa
    activate server
    server-->>browser: HTTP 200
    deactivate server
    browser->>server: GET https://studies.cs.helsinki.fi/exampleapp/spa.js
    activate server
    server-->>browser: HTTP 200
    deactivate server
    browser->>server: HTTP 200 https://studies.cs.helsinki.fi/exampleapp/data.json
    activate server
    server-->>browser: [{ "content": "HTML is easy", "date": "2023-1-1" }, ... ]
    deactivate server
    Note over browser: spa.js renders notes in JSON data
```
    
## 0.6: New note in Single page app diagram

```mermaid
sequenceDiagram
    title New note (Single page app)
    participant browser
    participant server
    browser->>server:  HTTP POST https://studies.cs.helsinki.fi/exampleapp/new_note_spa
    activate server
    server-->>browser: HTTP 201
    deactivate server
    Note over browser, server: browser stays on the same page, and sends no further HTTP requests
```
