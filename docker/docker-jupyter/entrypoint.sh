#!/bin/bash
echo "Running entrypoint.sh"
sh docker/allie-setup.sh
sh -c "jupyter notebook --allow-root -y --ip 0.0.0.0  --no-browser --port=9999 --config=/root/.jupyter/jupyter_notebook_config.py"
