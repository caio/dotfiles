#!/usr/bin/env python
#
# __hg_ps1 - Shell prompt helper for Mercurial (cf. __git_ps1)
#
# Copyright 2009 Kevin R. Bullock <kbullock@ringworld.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
# USA.

COLOR_BRANCH = '\[\e[0;32m\]'
COLOR_STATUS = '\[\e[1;35m\]'

def main():
    import sys
    from mercurial import ui, hg, error

    u = ui.ui()  # get a ui object
    try:
      # get a repository object for the current dir
      r = hg.repository(u, ".")
    except error.RepoError:
      # exit if we're not in a repository
      sys.exit(1)

    # Let's check for local branches
    if hasattr(r, 'getlocalbranch') and hasattr(r, 'loadlocalbranch'):
        branch_name = r.getlocalbranch() or 'default'
        r.loadlocalbranch(branch_name)
    else:
        branch_name = "%s%s" % (COLOR_BRANCH, r.dirstate.branch().rstrip())

    # repository.status(rev1, rev2, match, ignored, clean, unknown)
    # (last three params are flags whether to include files of the given status)
    # returns a tuple of lists of files:
    # (modified, added, removed, deleted, unknown, ignored, clean)
    stat = r.status('.', None, None, False, False, True)

    sys.stdout.write(branch_name)
    status = ""
    if True in [bool(l) for l in stat[0:4]]:
      status = "!"
    elif stat[4]:
      status = "?"
    print "%s%s" % (COLOR_STATUS, status)

if __name__ == '__main__':
    main()
