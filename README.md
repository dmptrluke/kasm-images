# Custom Kasm Workspace images
Custom Kasm Workspace images with some extra tooling based on the [official images](https://github.com/kasmtech/workspaces-images). Images are automatically built weekly.

# Usage
Create a new Workspace and edit it. If you want to use for example Ubuntu Noble Desktop then you should select the Noble Desktop Workspace from the official Registry and then click "Edit".

In the edit menu, Replace the Docker Image under container options. The Image name follows the following naming convention: `ghcr.io/dmptrluke/kasm-workspace-{{Dockerfile-name}}:{{kasm-version}}`. So if you want to use the Image ubuntu-noble-desktop with the 
kasm version 1.15, then the image tag will be `ghcr.io/dmptrluke/kasm-workspace-ubuntu-noble-desktop:1.15.0`.

To enable persistant storage, put something like the following path into persistant storage path:
```
/mnt/kasm_profiles/{image_id}/{username}
```