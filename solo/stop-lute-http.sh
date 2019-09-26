#!/bin/sh
kill -9 `ps -eo pid,cmd | grep [l]ute-http | awk '{print $1}'`
