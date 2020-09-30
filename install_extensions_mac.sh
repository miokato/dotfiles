#!/bin/sh

cat ./extensions | while read line
do
  code --install-extensions $line
done
