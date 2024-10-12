# vim: ft=nginx

server {
    listen 443 ssl;
    server_name invidious.xgabrielmorales.com;

    access_log off;
    error_log /var/log/nginx/error.log crit;

    # SSL Settings
    ssl_certificate /etc/letsencrypt/live/xgabrielmorales.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/xgabrielmorales.com/privkey.pem;

    # Configuración para servir imágenes estáticas desde /vi/
    location ~ (^/vi/) {
        proxy_pass "http://invidious:3000";

        proxy_http_version 1.1;
        proxy_set_header Connection "";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $remote_addr;

        proxy_cache my_cache;
        proxy_cache_valid 200 2d;
        proxy_cache_use_stale error timeout updating;
        proxy_ignore_headers Cache-Control Expires;

        expires 2d;
        add_header Cache-Control "public, max-age=172800";
        access_log off;
    }

    # Configuración para video playback
    location ~ (^/videoplayback|^/vi/|^/ggpht/) {
        proxy_pass "http://invidious:3000";

        proxy_buffering on;
        proxy_buffers 1024 16k;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header CF-Connecting-IP $remote_addr;
        sendfile on;
        sendfile_max_chunk 512k;

        proxy_hide_header "alt-svc";
        tcp_nopush on;
        aio threads=default;
        aio_write on;
        directio 16m;

        proxy_hide_header Cache-Control;
        proxy_hide_header etag;
        proxy_http_version 1.1;
        proxy_set_header Connection keep-alive;
        proxy_max_temp_file_size 32m;
        add_header Cache-Control private always;

    }

    location / {
        proxy_pass "http://invidious:3000";

        proxy_http_version 1.1;
        proxy_set_header Connection "";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $remote_addr;
    }
}
