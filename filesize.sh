#!/bin/bash

    FILESIZE=$(stat -c%s /etc/hosts)

echo $FILESIZE
