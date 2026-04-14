#!/bin/bash
grep "from" auth.log  | awk -F"from" '{print $2}' | awk -F" " '{print $1}' | sort  | uniq -c | wc -l
