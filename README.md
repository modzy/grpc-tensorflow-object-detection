# gRPC Tensorflow Object Detection

## About this Repository

### gRPC and Modzy Container Specification

This is a gRPC + HTTP/2 implementation of the [Tensorflow Object Detection Tutorial](https://www.tensorflow.org/hub/tutorials/object_detection) and is derived from Modzy's [gRPC Python Model Template](https://github.com/modzy/grpc-model-template).

## Installation

Clone the repository:

```git clone https://github.com/modzy/grpc-tensorflow-object-detection.git```

## Usage

All different methods of testing the gRPC template specification can be found in the [Usage section](https://github.com/modzy/grpc-model-template#Usage) of the gRPC Python Model Template.  

The following usage instructions demonstrate how to build the container image, run the container, open a shell inside the container, and run a test using the `grpc_model.src.model_client` module.

#### Build and run the container

From the parent directory of this repository, build the container image.

```docker build -t grpc-tensorflow-object-detection .```

Run the container interactively.

```docker run -it -p 45000:45000 grpc-tensorflow-object-detection:latest```

#### Run a test inside the container

Open a different terminal, use `docker ps` to extract your running container ID, and open up a shell inside the container.

```docker exec -it <container-id> bash```

In the shell, submit a test using poetry (installed inside the container) and the grpc_model.src.model_client module

```python -m grpc_model.src.model_server``` 
