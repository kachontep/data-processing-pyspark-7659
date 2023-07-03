#!/usr/bin/env bash

jupyter notebook --generate-config
sed -i "s/^# c.NotebookApp.token = .*/c.NotebookApp.token = ''/" $HOME/.jupyter/jupyter_notebook_config.py