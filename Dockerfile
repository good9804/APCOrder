# build stage
FROM node:lts-alpine 

WORKDIR /app
COPY . .
RUN npx update-browserslist-db@latest

WORKDIR /app/front
RUN npm install

RUN npm run build

WORKDIR /app/back
RUN npm install

EXPOSE 3003

CMD ["npm","start"]
