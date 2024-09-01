# build process
FROM golang:1.22 AS build-stage

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./

RUN go build -o mu app

# hosting method 
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /

COPY --from=build-stage /app/api /app

EXPOSE 8080

ENTRYPOINT [ "./api" ]