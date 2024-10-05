# Practicing Dockerfile creation

---

## Dockerfile

**Multi-stage .NET 8 Application Build**  
This Dockerfile is designed to **build and publish a .NET 8 application** in a **multi-stage** approach, ensuring that the **final image is smaller** and optimized for runtime.

- The first stage uses the **.NET SDK image** to **restore, build, and publish** the application.
- The second stage uses the **.NET runtime image** to run the application, ensuring only the necessary files are included.
- **Adds the application source code** from a **GitHub repository** and builds the project from it.
- **EXPOSES port 80** and configures the application to listen on that port.
- Final image size is minimized by **excluding SDK-related files** and keeping only the **published output**.

### Usage

```bash
docker build -t websocket -f Dockerfile .
docker run -d -p 8080:80 websocket
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

### Usage

```bash
docker build -t websocket -f Dockerfile.alpine .
docker run -d -p 8080:80 websocket
```