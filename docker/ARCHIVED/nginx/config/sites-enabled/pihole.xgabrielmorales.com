# vim: ft=nginx

server {
    listen 443 ssl;
    server_name pihole.xgabrielmorales.com;

    access_log off;
    error_log /var/log/nginx/error.log crit;

    # SSL Settings
    ssl_certificate /etc/letsencrypt/live/xgabrielmorales.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/xgabrielmorales.com/privkey.pem;

    location / {
        proxy_pass "http://pihole:80";
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $remote_addr;
    }
}
