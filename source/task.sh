#!/bin/bash

__load_task() {
    local taskrc="/usr/share/doc/task/scripts/bash/task_completion.sh"
    test ! -f ${taskrc} && return 0
    . ${taskrc}
}
