#!/bin/sh
kill -9 `ps -ef | grep [l]ute-http | awk '{print $1}'`
