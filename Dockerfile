# BUILD
FROM node:alpine as build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
CMD ["npm", "run", "build"]

# RUN
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
