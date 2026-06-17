# Build stage
FROM golang:1.24-alpine AS builder

RUN apk add --no-cache git

WORKDIR /app

# Copy source code
COPY . .

# Build
RUN go build -o /crush .

# Runtime stage
FROM alpine:3.21

RUN apk add --no-cache \
    ca-certificates \
    tzdata

# Copy binary
COPY --from=builder /crush /usr/local/bin/crush

# Create config directory
RUN mkdir -p /root/.config/crush /root/.local/share/crush

WORKDIR /workspace

# Default entrypoint
ENTRYPOINT ["crush"]
CMD ["--help"]
