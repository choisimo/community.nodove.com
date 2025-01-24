### server.conf
```nginx
# for auth_request 
location /auth_check {
    internal;
    proxy_pass http://192.168.1.35:18080;
    proxy_pass_request_body off;           
    proxy_set_header Authorization $auth_header;  
    proxy_set_header Content-Length "";     
    proxy_set_header X-Original-URI $request_uri;  
    proxy_set_header X-Original-Method $request_method; 
    proxy_set_header X-Original-Host $host;  
    proxy_set_header X-Original-IP $remote_addr;  

    # SSL certificates
    # proxy_ssl_server_name on;               # This is required for SNI
    # proxy_ssl_protocols TLSv1.2 TLSv1.3;    # This is required for TLS 1.3
    # proxy_ssl_ciphers HIGH:!aNULL:!MD5;     # This is required for PCI compliance
    # proxy_ssl_verify on;                    # This is required for PCI compliance
    # proxy_ssl_trusted_certificate /data/custom_ssl/npm-28/fullchain.pem; 
}

location /api/ {
    auth_request /auth_check;
    proxy_set_header Authorization $auth_header;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Cookie $http_cookie;
    proxy_pass http://192.168.1.35:18081;
}



location /api/sse/subscribe {
    auth_request /auth_check;
    proxy_pass http://192.168.0.44:8080;
    add_header Cache-Control 'no-cache';
    add_header Content-Type text/event-stream;
    add_header Connection keep-alive;
    proxy_set_header X-Accel-Buffering no;
    proxy_read_timeout 3600; 
    proxy_send_timeout 3600;
    keepalive_timeout 3600;
    proxy_http_version 1.1;
}

location /api/file/ {
}
```

VSCode Setting
```json
{
    "workbench.colorTheme": "Default Dark Modern",
    "[dart]": {
        "debug.openDebug": "openOnDebugBreak",
        "debug.internalConsoleOptions": "openOnSessionStart",
        "editor.formatOnSave": true,
        "editor.formatOnType": true,
        "editor.rulers": [
            80
        ],
        "editor.selectionHighlight": false,
        "editor.tabCompletion": "onlySnippets",
        "editor.wordBasedSuggestions": "off",
        "editor.codeActionsOnSave": {
            "source.fixAll": "explicit"
        },
        "editor.formatOnPaste": true,
        "dart.previewFlutterUiGuides": true,
    }
}
```
VSCode plugins
```
Error Lens
Better Comments
Pubspec Assist
Awesome Fluttter Snippets
Build Runner
Flutter Widget Snippets
Flutter Tree

```