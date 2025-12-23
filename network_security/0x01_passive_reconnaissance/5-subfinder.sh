#!/bin/bash
subfinder -d $1 -ip -nW -silent | cut -d "," -f1,2 | tee $1.txt
