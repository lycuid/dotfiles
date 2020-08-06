#!/bin/bash
echo $(tmux ls 2> /dev/null | wc -l)
