FROM scene_graph_benchmark

RUN python -c "import torch; print(torch.cuda.device_count())"
RUN nvcc --version
RUN ls /usr/local/

WORKDIR /root

USER root

RUN mkdir /notebooks

WORKDIR /notebooks

# install PyTorch Detection
ARG FORCE_CUDA="1"
ENV FORCE_CUDA=${FORCE_CUDA}

WORKDIR /scene_graph_benchmark

RUN jupyter notebook --generate-config

ENV CONFIG_PATH="/root/.jupyter/jupyter_notebook_config.py"

COPY "jupyter_notebook_config.py" ${CONFIG_PATH}

ENTRYPOINT ["/scene_graph_benchmark/docker/docker-jupyter/entrypoint.sh"]
