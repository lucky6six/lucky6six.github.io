#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <blog_name>"
    exit 1
fi

SOURCE_DIR="./content/blog/example"
TARGET_DIR="./content/blog/$1"

cp -r $SOURCE_DIR $TARGET_DIR


cat << EOF > $TARGET_DIR/index.md
---
title: $1
summary: summary
date: $(date +"%Y-%m-%d")
authors:
- admin
tags:
- example
image:
caption: "Image credit: [**Unsplash**](https://unsplash.com)"
commentable: true
---
EOF