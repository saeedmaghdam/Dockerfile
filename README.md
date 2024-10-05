# Practicing Dockerfile creation

---

## Tips and Tricks

- **Use multi-stage builds** to keep the final image size small.
- **Use .dockerignore** to exclude unnecessary files and directories.
- **Use the right base image** to keep the image size small.
- **Combine RUN commands** to reduce the number of layers.
- **Use COPY instead of ADD** if you don't need the extra features of ADD.
- **Use the right tag** for the base image to get the right version.
- **Use the right version** of the base image to get the latest features and security updates.
- **Use the right base image** for the application type (ASP.NET, .NET Core, etc.).
- **Use the right base image** for the target platform (Linux, Windows, etc.).
- **Use the right base image** for the target architecture (x86, ARM, etc.).
- **Use the right base image** for the target runtime (Alpine, Debian, etc.).
- **Use the right base image** for the target environment (development, production, etc.).
- **Use the right base image** for the target workload (web server, database, etc.).
- **Use the right base image** for the target language (Python, Node.js, etc.).
- **Use the right base image** for the target framework (Django, Express, etc.).
- **Use the right base image** for the target application (WordPress, Magento, etc.).
- **Use the right base image** for the target service (NGINX, Redis, etc.).
- **Use the right base image** for the target container (Docker, Kubernetes, etc.).
- **Use the right base image** for the target cloud (AWS, Azure, etc.).
- **Use the right base image** for the target provider (Google, IBM, etc.).
- **Use the right base image** for the target registry (Docker Hub, GitHub, etc.).
- **Use the right base image** for the target repository (official, community, etc.).
- **Use the right base image** for the target organization (Microsoft, Google, etc.).
- **Use the right base image** for the target team (Azure DevOps, GitHub Actions, etc.).
- **Use the right base image** for the target project (web app, mobile app, etc.).
- **Use the right base image** for the target client (browser, mobile, etc.).
- **Use the right base image** for the target user (root, non-root, etc.).
- **Use the right base image** for the target group (staff, users, etc.).
- **Use the right base image** for the target permissions (read, write, etc.).
- **Use the right base image** for the target security (firewall, antivirus, etc.).
- **Use the right base image** for the target compliance (HIPAA, GDPR, etc.).
- **Use the right base image** for the target regulations (PCI DSS, SOX, etc.).
- **Use the right base image** for the target standards (ISO 27001, NIST, etc.).

### Overwrite the default entrypoint

```dockerfile
docker run -it --rm --entrypoint /bin/sh websocket
```

---

## Dockerfile

**Multi-stage .NET 8 Application Build**  
This Dockerfile is designed to **build and publish a .NET 8 application** in a **multi-stage** approach, ensuring that the **final image is smaller** and optimized for runtime.

- The first stage uses the **.NET SDK image** to **restore, build, and publish** the application.
- The second stage uses the **.NET runtime image** to run the application, ensuring only the necessary files are included.
- **Adds the application source code** from a **GitHub repository** and builds the project from it.
- **EXPOSES port 80** and configures the application to listen on that port.
- Final image size is minimized by **excluding SDK-related files** and keeping only the **published output**.

Final image size: **~221MB**

### Usage

```bash
docker build -t websocket -f Dockerfile .
docker run -p 8080:80 websocket
```

---

## Dockerfile.alpine

**Multi-stage .NET 8 Application Build with Alpine Runtime**  
This Dockerfile builds and runs a .NET 8 application using a **multi-stage approach**, but it now uses **Alpine Linux** for the final runtime stage, leading to a **smaller and more efficient final image**.

- Similar to the previous Dockerfile: the first stage uses the **.NET SDK image** to **restore, build, and publish** the application.
- In the second stage, instead of using a .NET runtime image, it switches to **Alpine 3.20**, a minimal base image.
- **Adds Alpine dependencies** such as `bash`, `icu-libs`, `krb5-libs`, and more.
- The .NET runtime is **installed manually** using the **dotnet-install script**.
- **Final image size is reduced** further by using **Alpine** compared to the full runtime image.

Final image size: **~124MB**

### Usage

```bash
docker build -t websocket -f Dockerfile.alpine .
docker run -p 8080:80 websocket
```

## Dockerfile.cache

**Multi-stage .NET 8 Application Build with Alpine Runtime and Cache Optimization**  
This Dockerfile builds and runs a .NET 8 application using a **multi-stage approach** with **Alpine Linux** as the runtime and introduces **caching optimizations** to speed up the build process.

- Compared to the previous one, **cache mounts are added** for the `.nuget/packages` directory, **reducing build times** by reusing previously downloaded packages.
- The initial checkout stage is now **split into three stages**: checkout, restore, and publish, enhancing **build process clarity** and **layer caching efficiency**.
- Retains the **Alpine base image** for a **smaller runtime footprint**.
- Final image size is minimized through **manual installation** of .NET runtime and necessary Alpine dependencies, just like the previous Dockerfile.

Final image size: **~124MB**

### Usage

```bash
docker build -t websocket -f Dockerfile.cache .
docker run -p 8080:80 websocket
```