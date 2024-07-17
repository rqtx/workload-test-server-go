# builder image
FROM golang:1.17.6-alpine AS builder

RUN apk add --update --no-cache make ca-certificates && rm -rf /var/cache/apk/*

# create a working directory inside the image
WORKDIR /app

# copy Go modules and dependencies to image
COPY go.mod ./

# download Go modules and dependencies
RUN go mod download

# copy directory files i.e all files ending with .go
COPY ./src/*.go ./

# compile application
RUN go build -o /app

# generate clean, final image for end users
FROM scratch
COPY --from=builder /build/pddoc/bin/pddoc /usr/local/bin/
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT [ "app" ]
