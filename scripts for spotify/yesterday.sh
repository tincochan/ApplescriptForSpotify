#!/bin/bash


file=$HOME/.now
yesterday=$(date -v-1d "+%Y-%m-%d")

grep $yesterday $file | cut -d' ' -f2-
