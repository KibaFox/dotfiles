# Source: https://github.com/oh-my-fish/plugin-pj
#
# The MIT License (MIT)
#
# Copyright (c) 2016 Espen Henriksen
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function pj --description "Jump to a project"
  set -l argc (count $argv)

  if test (count $PROJECT_PATHS) -eq 0
    echo 'Add some directories to the environment variable $PROJECT_PATHS to get started!'
    echo '  set -gx PROJECT_PATHS ~/dir1 ~/dir2'
    return 1

  else if test $argc -le 0 -o $argc -gt 2
    echo 'Usage: pj [open] [PROJECT]'
    return 1

  else if test $argc -eq 2 -a $argv[1] != 'open'
    echo 'Usage: pj [open] [PROJECT]'
    return 1

  else if contains -- --help $argv
    echo 'Usage: pj [open] [PROJECT]'

  else if test $argv[1] = "open"
    set -l target (find $PROJECT_PATHS -maxdepth 1 -name $argv[2] | head -n 1)

    if test -n "$target"
      cd $target
      eval $EDITOR $target
    else
      echo "No such project: $argv[2]"
      return 1
    end

  else
    set -l target (find $PROJECT_PATHS -maxdepth 1 -name $argv[1] | head -n 1)

    if test -n "$target"
      cd $target
    else
      echo "No such project: $argv[1]"
      return 1
    end
  end
end

function __project_basenames --description "List of project basenames"
  set -l project_basenames

  for pp in $PROJECT_PATHS
    set -a project_basenames (basename $pp)

    for project in (ls -d $pp/*/)
      set -a project_basenames (basename $project)
    end
  end

  echo $project_basenames
end
