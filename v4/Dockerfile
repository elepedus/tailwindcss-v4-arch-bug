FROM debian:bookworm-slim
WORKDIR /app

# Install wget
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Download architecture-specific Tailwind v4 binary
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        wget -O tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.10/tailwindcss-linux-x64 && \
        chmod +x tailwindcss; \
    elif [ "$ARCH" = "aarch64" ]; then \
        wget -O tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.10/tailwindcss-linux-arm64 && \
        chmod +x tailwindcss; \
    fi

# Copy files
COPY test.html .
COPY v4/input.css .

# Generate CSS
CMD ["sh", "-c", "./tailwindcss -i input.css -o output.css && cat output.css"]