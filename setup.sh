#!/bin/bash

if [ ! -d compile ]; then
  mkdir compile
fi

cp -pr source/* compile
\cp -prf updates/latest/source/* compile 
