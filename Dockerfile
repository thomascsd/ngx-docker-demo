#stage 1
FROM node:12-alpine as ngx-web
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm i
COPY . /app
RUN npm run build

#stage 2
FROM nginx:stable-alpine
COPY --from=ngx-web /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
