FROM nginx:latest

COPY index.html /usr/share/nginx/html
COPY assets /usr/share/nginx/html/assets


EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]