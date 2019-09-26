#!/bin/sh
kill -9 `ps -ef | grep [j]ava | awk '{print $1}'`
