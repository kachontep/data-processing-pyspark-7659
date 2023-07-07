#!/usr/bin/env bash

for nb_file in $(ls ./notebooks/*.ipynb)
do
    jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace $nb_file
done