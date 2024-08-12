# Stage 1: Build Gaia
FROM golang:1.19-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git make gcc libc-dev linux-headers

# Set working directory
WORKDIR /gaia

# Clone Gaia repository and checkout v7.1.0
RUN git clone https://github.com/cosmos/gaia.git . && \
    git checkout v7.1.0

# Build Gaia
RUN make build

# Stage 2: Create final image
FROM alpine:3.14

# Install ca-certificates for HTTPS
RUN apk add --no-cache ca-certificates

# Copy binary from builder
COPY --from=builder /gaia/build/gaiad /usr/local/bin/

# Set entrypoint
ENTRYPOINT ["gaiad"]

# Default command (can be overridden)
CMD ["start"]