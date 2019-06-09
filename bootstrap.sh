#!/usr/bin/env bash

function doSync() {
    rsync --exclude ".git/" \
        --exclude "README.md" \
        --exclude "bootstrap.sh" \
        -avh --no-perms . ~;
}

doSync;
