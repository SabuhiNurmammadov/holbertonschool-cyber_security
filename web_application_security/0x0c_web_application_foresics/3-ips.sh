#!/bin/bash
grep -oP 'from \K\S+' auth.log | sort -u | wc -l
