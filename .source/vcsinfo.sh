#!/bin/bash
# References
#  * http://gist.github.com/31934
#  * http://glandium.org/blog/?p=170

__vcs_dir() {
  local vcs base_dir sub_dir ref RED YELLOW GREEN BLUE
  local LIGHT_RED LIGHT_GREEN WHITE LIGHT_GRAY COLOR_NONE

  RED="\[\033[0;31m\]"
  YELLOW="\[\033[0;33m\]"
  GREEN="\[\033[0;32m\]"
  BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
  LIGHT_GREEN="\[\033[1;32m\]"
  WHITE="\[\033[1;37m\]"
  LIGHT_GRAY="\[\033[0;37m\]"
  COLOR_NONE="\[\e[0m\]"

  sub_dir() {
    local sub_dir
    sub_dir=$(readlink -f "${PWD}")
    sub_dir=${sub_dir#$1}
    echo ${sub_dir#/}
  }

  git_dir() {

      parse_git_branch() {
          # Capture the output of the "git status" command.
          git_status="$(git status 2> /dev/null)"

          # Set color based on clean/staged/dirty.
          if [[ ${git_status} =~ "working directory clean" ]]; then
              state="${GREEN}"
          elif [[ ${git_status} =~ "Changes to be committed" ]]; then
              state="${YELLOW}"
          else
              state="${RED}"
          fi

          # Set arrow icon based on status against remote.
          remote_pattern="# Your branch is (ahead of|behind)"
          if [[ ${git_status} =~ ${remote_pattern} ]]; then
              if [[ ${BASH_REMATCH[1]} == "ahead of" ]]; then
                  remote="↑"
              else
                  remote="↓"
              fi
          fi
          diverge_pattern="# Your branch and (.*) have diverged"
          if [[ ${git_status} =~ ${diverge_pattern} ]]; then
              remote="↕"
          fi

          # Get the name of the branch.
          branch_pattern="^# On branch ([^${IFS}]*)"
          if [[ ${git_status} =~ ${branch_pattern} ]]; then
              branch=${BASH_REMATCH[1]}
          fi

          # Display the prompt.
          echo "${state}${branch}${remote}${COLOR_NONE}"
      }
      base_dir=$(git rev-parse --git-dir 2>/dev/null) || return 1
      base_dir=$(readlink -f "$base_dir/..")
      sub_dir=$(git rev-parse --show-prefix)
      sub_dir=${sub_dir%/}
      ref=$(parse_git_branch)
      vcs="git"
  }

  svn_dir() {
      [ -d ".svn" ] || return 1
      base_dir="."
      while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
      base_dir=$(readlink -f "$base_dir")
      sub_dir=$(sub_dir "${base_dir}")
      ref=$(svn info "$base_dir" | awk '/^URL/ { sub(".*/","",$0); r=$0 } /^Revision/ { sub("[^0-9]*","",$0); print r":"$0 }')
      vcs="svn"
  }

  hg_dir() {
      base_dir="."
      while [ ! -d "$base_dir/.hg" ]; do base_dir="$base_dir/.."; [ $(readlink -f "${base_dir}") = "/" ] && return 1; done
      base_dir=$(readlink -f "$base_dir")
      sub_dir=$(sub_dir "${base_dir}")
      ref="$(hg_ps1.py 2>/dev/null)" || ref=$(cat "${base_dir}/.hg/branch" 2>/dev/null)
      [ "$ref" == "" ] && ref="${GREEN}default"
      vcs="hg"
  }

  git_dir ||
  svn_dir ||
  hg_dir ||
  base_dir="$PWD"

  __vcs_base_dir="${base_dir/$HOME/~}"
  if [ -n "$vcs" ]; then
      __vcs_prefix="$vcs"
      __vcs_ref="$ref"
      __vcs_sub_dir="${sub_dir}"
  else
      __vcs_prefix=""
      __vcs_ref=""
      __vcs_sub_dir=""
  fi
}
