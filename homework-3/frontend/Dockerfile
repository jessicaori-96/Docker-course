# Build stage
FROM alpine AS builder
WORKDIR /build

COPY . .

#  Runtime stage 
FROM nginx:alpine AS runtime
WORKDIR /usr/share/nginx/html

COPY --from=builder /build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

