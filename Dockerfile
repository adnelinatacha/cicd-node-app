FROM alpine:3.10
WORKDIR /app
COPY . .
EXPOSE 3000
CMD sh -c "apk add --no-cache nodejs npm && npm install --no-audit --no-fund && npm start"
