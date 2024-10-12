# vim: ft=nginx

server {
    listen 443 ssl;
    server_name pairdrop.xgabrielmorales.com;

    access_log off;
    error_log /var/log/nginx/error.log crit;

    # SSL Settings
    ssl_certificate /etc/letsencrypt/live/xgabrielmorales.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/xgabrielmorales.com/privkey.pem;

    location / {
        proxy_pass "http://pairdrop:3000";
        proxy_http_version 1.1;
        proxy_set_header Host $host;

        # WebSocket Support
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header X-Forwarded-For $remote_addr;
    }
}
