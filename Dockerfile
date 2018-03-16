FROM nginx:1.13.7-alpine

COPY _site /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
