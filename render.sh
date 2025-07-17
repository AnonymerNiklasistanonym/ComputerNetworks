#!/bin/bash

# Check if plantuml command is available
if ! command -v plantuml &> /dev/null
then
    echo "plantuml could not be found. Please install it or add it to your PATH."
    exit 1
fi

# Check if mermaid-cli command is available
if ! command -v mmdc &> /dev/null
then
    echo "mermaid-cli could not be found. Please install it or add it to your PATH."
    exit 1
fi

# Check if graphviz command is available
if ! command -v dot &> /dev/null
then
    echo "graphviz could not be found. Please install it or add it to your PATH."
    exit 1
fi

# Find all .puml files recursively and generate SVGs
find . -type f -name "*.puml" | while read -r file; do
    echo "Processing $file..."
    plantuml -tsvg "$file"
done

# Find all .mmd files recursively and generate SVGs
find . -type f -name "*.mmd" | while read -r file; do
    echo "Processing $file..."
    mmdc -i "$file" -o "${file%.mmd}.svg"
done

# Find all .mmd files recursively and generate SVGs
find . -type f -name "*.dot" | while read -r file; do
    echo "Processing $file..."
    dot -Tsvg "$file" -o "${file%.dot}.svg"
done

echo "Done generating SVG files."
