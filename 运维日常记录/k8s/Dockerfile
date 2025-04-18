FROM harbor-in.lrhealth.com:9002/test/node:16 as build
WORKDIR /app
COPY package.json .
RUN --mount=type=cache,target=/app/node_modules,id=node_modules \
    --mount=type=cache,target=/root/.npm,id=npm_cache \
    npm config set registry https://registry.npmmirror.com/ && \
    npm install
COPY . .
ARG PROFILE
RUN --mount=type=cache,target=/app/node_modules,id=node_modules \
    --mount=type=cache,target=/root/.npm,id=npm_cache \
    npm run build:$PROFILE


FROM harbor-in.lrhealth.com:9002/test/nginx:stable-alpine
ENV TZ=Asia/Shanghai
COPY --from=build /app/dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /etc/nginx/logs
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
