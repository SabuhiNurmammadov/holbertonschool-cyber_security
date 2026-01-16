#!/bin/bash
curl -s -X POST -H "HOST:  $1" "$2" -d "$3"
