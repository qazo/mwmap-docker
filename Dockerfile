FROM node:15 as builder

RUN git clone https://github.com/MathisBullinger/mwmap /app

WORKDIR /app

RUN echo 'IMG_HOST = https://d38oy7iu7t2hpf.cloudfront.net' > .env
RUN npm install
RUN npm run build

FROM nginx:alpine as production
ENV NODE_ENV production
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 9001

CMD ["nginx", "-g", "daemon off;"]
