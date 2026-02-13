#!/bin/bash
grep -Ev '^\s*#|^\s*$' /etc/ssh/ssh_config
