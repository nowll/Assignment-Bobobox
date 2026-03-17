# Next.js Docker Containerization

This folder contains the containerization setup for a Next.js web application.

It uses a **multi-stage Docker build** to create an optimized, secure, and lightweight production image, orchestrated with Docker Compose.

---

##  Prerequisites

Before you begin, ensure you have the following installed:

- **Docker Engine** (v20.10+)
- **Docker Compose** (v2.0+)

---

##  Project Structure

Ensure your project follows this structure:

```
.
├── app/
│   ├── pages/
│   │   └── index.js      # React component returning "Hello, Docker!"
│   └── package.json      # Next.js dependencies
├── Dockerfile            # Multi-stage build instructions
├── docker-compose.yml    # Service orchestration
└── .dockerignore         # Ignore node_modules, build files
```

---

##  How to Build and Run

### 1. Build and Start Container

Run this command in the root directory:

```bash
docker-compose up -d --build
```

- `-d` → run in background
- `--build` → rebuild latest image

---

### 2. Verify Container

```bash
docker ps
```

You should see your container running.

---

### 3. Access Application

Open your browser:

```
http://localhost:8080
```

Expected output:

```html
<h1>Hello, Docker!</h1>
```

---

### 4. View Logs (Optional)

```bash
docker-compose logs -f web
```

---

##  Stop and Clean Up

```bash
docker-compose down
```

This stops and removes containers and networks.

---

## Architecture & DevOps Reasoning

###  Multi-Stage Docker Build

The Dockerfile is split into 3 stages:

- **deps**
  - Install dependencies from `package.json`

- **builder**
  - Build Next.js into optimized production files

- **runner**
  - Final lightweight image
  - Contains only compiled `.next` output and minimal dependencies

 Benefits:
- Smaller image size  
- Faster CI/CD  
- Reduced attack surface  

---

###  Alpine Linux Base Image

Uses:

```
node:18-alpine
```

Benefits:
- Lightweight
- Security-focused
- Minimal unnecessary packages

---

###  Port Mapping & Networking

- Container runs on: `3000`
- Exposed to host: `8080`

```
8080:3000
```

 Avoids port conflicts while keeping internal consistency

---

###  High Availability (Restart Policy)

Docker Compose configuration:

```yaml
restart: unless-stopped
```

 Ensures:
- Auto-restart if container crashes  
- Auto-restart after Docker daemon reboot  
- Self-healing behavior  

---

##  Summary

This project demonstrates:

- Docker multi-stage builds
- Lightweight container optimization
- Secure container practices
- Simple service orchestration with Docker Compose
