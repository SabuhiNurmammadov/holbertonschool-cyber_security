#!/bin/bash
grep "FAILED LOGIN" auth.log | awk -F'`' '{print $2}' | cut -d"'" -f1 | sort | uniq -c | sort -nr 
