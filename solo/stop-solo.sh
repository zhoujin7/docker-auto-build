#!/bin/sh
kill -9 `ps -eo pid,cmd | grep [j]ava | awk '{print $1}'`
