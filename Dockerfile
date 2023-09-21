# build stage
FROM node:18.16.0 

WORKDIR /app
COPY . .


WORKDIR /app/front
RUN npm install
RUN npx update-browserslist-db@latest

RUN npm run build

WORKDIR /app/back
RUN npm install

EXPOSE 3003

CMD ["npm","start"]
