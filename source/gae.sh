#!/bin/bash

__load_gae() {
    local gaepath="${HOME}/src/sdks/google_appengine"
    test ! -d ${gaepath} && return 0
    pathprepend ${gaepath}
}

__load_gae
