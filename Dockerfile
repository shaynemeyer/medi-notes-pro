# Stage 1: Build the Next.js app
FROM node:22-alpine AS frontend-builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

ARG NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY
ENV NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=$NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY

RUN npm run build

# Stage 2: Production container with Node.js + Python
FROM node:22-slim

WORKDIR /app

# Install Python, pip, and curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install uv, create venv, install Python dependencies
ENV VIRTUAL_ENV=/app/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY requirements.txt .
RUN pip3 install --no-cache-dir uv --break-system-packages && \
    uv venv $VIRTUAL_ENV && \
    uv pip install --no-cache -r requirements.txt

# Copy FastAPI server
COPY api/server.py .

# Copy Next.js standalone output and static assets
COPY --from=frontend-builder /app/.next/standalone ./
COPY --from=frontend-builder /app/.next/static ./.next/static
COPY --from=frontend-builder /app/public ./public

# Startup script
COPY start.sh .
RUN chmod +x start.sh

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

EXPOSE 8000

CMD ["./start.sh"]
