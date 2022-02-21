# Please consult the README if you need help in selecting a base image
FROM python:3 as application

ENV LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

WORKDIR /opt/app

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    git \
    make \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    libgl1-mesa-glx \
&& rm -rf /var/lib/apt/lists/*

ENV PYTHON_VERSION=3.9.6 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBTYECODE=1 \
    PYENV_ROOT="/.pyenv" \
    PATH="/.pyenv/bin:/.pyenv/shims:${PATH}"

RUN git clone --depth=1 https://github.com/pyenv/pyenv.git /.pyenv && \
    pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION}

# copy application files into the container image
# NOTE: to avoid overly large container size, only copy the files actually needed by
#       explicitly specifying the needed files with the `COPY` command or adjusting
#       the `.dockerignore` file to ignore unneeded files
# Create the application working directory
WORKDIR /opt/app
COPY grpc_model ./grpc_model
COPY model_lib ./model_lib
COPY asset_bundle/1.0.0 ./asset_bundle/1.0.0
COPY image.jpg ./image.jpg

# environment variable to specify model server port
ENV PSC_MODEL_PORT=45000 \
    PATH=${PATH}:/home/modzy-user/.local/bin/

ARG CIRCLE_REPOSITORY_URL
LABEL com.modzy.git.source="${CIRCLE_REPOSITORY_URL}"

COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

CMD ["python", "-m", "grpc_model.src.model_server"]
