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

---

## Dockerfile.platform

**Multi-stage .NET 8 Application Build with Generic Platform Support**  
This Dockerfile builds and runs a .NET 8 application using a **multi-stage approach** while introducing **platform flexibility** to support multiple architectures (e.g., **linux/amd64**, **linux/arm64**). 

- The **first stage** builds and publishes the application using the **.NET SDK image**, with the runtime identifier dynamically set based on the **target platform**.
- Caching is used for the `.nuget/packages` directory to **optimize the restore, build, and publish processes**.
- The **second stage** switches to an **Alpine Linux base image** using the specified platform, allowing the final image to be platform-specific.
- **Platform-specific dependencies** are installed in the runtime stage to ensure compatibility across different platforms.
- **.NET runtime** is installed dynamically using the install script, supporting platform variations such as **ASP.NET Core**.

**New Features**:
- **Platform flexibility**: Uses `ARG TARGETPLATFORM` to support various platforms like **amd64** and **arm64**.
- **Generic platform handling** in the `FROM` statements, allowing Docker builds for different platforms with minimal changes.

Final image size: **~124MB**

### Usage

```bash
docker build --platform linux/amd64 -t websocket -f Dockerfile.platform --build-arg RUNTIME_IDENTIFIER=linux-amd64 --build-arg TARGETPLATFORM=linux/amd64 .
docker run -p 8080:80 websocket
```

---

## Dockerfile.secret

**Alpine Runtime with Secret Mounting**  
This Dockerfile demonstrates the use of **secret mounting** in a **single-stage Alpine build**. It showcases how to securely access sensitive data during the build process without baking it into the final image.

- The **Alpine Linux image** is used as the base.
- A **secret** is securely accessed during the build using the `--mount=type=secret` option. The secret is mounted at `/run/secrets/test_secret` and accessed within the `RUN` command.
- This setup ensures sensitive information is only available during the build process and is not included in the final image.

**Key Features**:
- **Secret management**: Handles sensitive data securely with `--mount=type=secret`, preventing it from being exposed in the image layers.
- **Platform support**: Utilizes the `TARGETPLATFORM` argument to support different architectures when building the image.

### Usage

```bash 
docker secret create test_secret ./secret

docker build --secret id=test_secret,src=./secret -t test_secret_image -f Dockerfile.secret . --progress=plain --no-cache
docker rum --rm test_secret_image
```

---

## Dockerfile.healthcheck

**Multi-stage .NET 8 Application Build with Health Check**  
This Dockerfile builds and runs a **.NET 8 application** using the same **multi-stage approach** as the previous `Dockerfile.platform`, with the addition of a **health check** to monitor the application's availability.

- **Health check added**: A new **health check** feature monitors the application's availability by using `wget` to check the HTTP endpoint at `localhost:80`. It runs every 30 seconds with a 10-second timeout, retries 3 times, and fails if the endpoint does not respond.
- **Other features remain the same** as `Dockerfile.platform`, including platform support via `TARGETPLATFORM`, performance optimization through caching, and a minimal runtime using **Alpine Linux**.

**New Feature**:
- **Health check**: Ensures the application is responsive by periodically checking the HTTP endpoint.

Final image size: **~124MB**

### Usage

```bash
docker build --platform linux/amd64 -t websocket -f Dockerfile.healthcheck --build-arg RUNTIME_IDENTIFIER=linux-amd64 --build-arg TARGETPLATFORM=linux/amd64 .
docker run -p 8080:80 websocket
```

---

## Using Targeted Builds (--target)

Build only the development environment without going through the full production build process.

```bash
docker build --target=build-env --platform linux/amd64 -t websocket-build -f Dockerfile.healthcheck --build-arg RUNTIME_IDENTIFIER=linux-amd64 --build-arg TARGETPLATFORM=linux/amd64 .
```

---

## Dockerfile.multioutputs

---

**Multi-stage .NET 8 Application Build with Separate Production and Development Pipelines**  
This Dockerfile expands upon previous versions by introducing **distinct pipelines for production and development builds**. It allows for both **release** and **debug** configurations to be built, published, and run in separate runtime stages.

- **Separate build stages** for **production (Release mode)** and **development (Debug mode)** are added, allowing different configurations to be built and optimized for their respective environments.
- **Platform flexibility** remains, with `TARGETPLATFORM` and `RUNTIME_IDENTIFIER` dynamically set to support different architectures.
- **Caching** is used to optimize the restore, build, and publish steps, reducing redundant package downloads.
- **Two runtime stages**: one for **production** and one for **development**, each using **Alpine Linux** as the base image and installing platform-specific dependencies.
- Both runtime images expose the application on **port 80** and run the published application using the installed **ASP.NET Core runtime**.

**New Features Compared to `Dockerfile.platform`**:
- **Separate build and publish pipelines for production and development**: This allows building and running **optimized release** images for production and **debuggable development** images for testing and development.
- **Distinct runtime images**: One for **production** and one for **development**, ensuring the appropriate environment is used when running the container.

Final image sizes: **~124MB** (production), **~124MB** (development)

### Usage

Build and run the production image:

```bash
docker build --target runtime-prod --platform linux/amd64 -t websocket-prod -f Dockerfile.multioutputs --build-arg RUNTIME_IDENTIFIER=linux-amd64 --build-arg TARGETPLATFORM=linux/amd64 .

docker run -p 8080:80 websocket-prod
```

Build and run the development image:

```bash
docker build --target runtime-dev --platform linux/amd64 -t websocket-dev -f Dockerfile.multioutputs --build-arg RUNTIME_IDENTIFIER=linux-amd64 --build-arg TARGETPLATFORM=linux/amd64 .


docker run -p 8080:80 websocket-dev
```