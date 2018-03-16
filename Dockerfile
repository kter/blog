FROM kter/nginx-module-vts:1.12.2-0.1.15

COPY _site /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
