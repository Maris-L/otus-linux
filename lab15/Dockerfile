FROM nginx:alpine

RUN apk add --update nginx && apk upgrade

EXPOSE 80 443

COPY ./index.html /usr/share/nginx/html/index.html

WORKDIR /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
