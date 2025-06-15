FROM node:20-alpine
WORKDIR /app

# Install Tailwind CSS v3
RUN npm install -g tailwindcss@3.4.3

# Copy configuration files
COPY test.html .
COPY v3/input.css .
COPY v3/tailwind.config.js .

# Generate CSS
CMD ["sh", "-c", "tailwindcss -i input.css -o output.css && cat output.css"]