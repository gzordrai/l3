#!/bin/bash

if [ -z "$1" ]
then
    echo "Veuillez fournir le nom du tp en argument."
    exit 1
fi

cd "$1/src/" || exit
find . -name "__pycache__" -type d -exec rm -r {} +
tar -czf "../../$1.tar.gz" *
cd ..
echo "L'archive $1.tar.gz a été créée avec succès."