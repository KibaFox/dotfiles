function j -d "Jump to a project"
	function _help
		echo 'Usage: j'
		echo ''
		echo 'Jump to a project.'
		echo ''
		echo 'Without any arguments, fzf will be used to select a project.'
		echo ''
		echo 'Set variable PROJECT_PATHS with a list of directories to find projects:'
		echo 'For example:'
		echo ''
		echo '    set -gx PROJECT_PATHS ~/proj ~/repos'
		echo ''
		echo 'Default is ~/proj'
		echo ''
		echo 'Projects are directories which contain a `.git` directory.'
	end

	if test (count $argv) -ge 1
		_help
		return 0
	end

	argparse --name=pwrem 'a/add' 'd/del' 'r/reveal' 'q/query' 'h/help' -- $argv
	or return

	if test -n "$_flag_h"
		_help
		return
	end

	function __projects
		if not set -q PROJECT_PATHS
			set -l PROJECT_PATHS ~/proj
		end
		find $PROJECT_PATHS -maxdepth 3 -type d -name '.git' -prune | sed 's|/\.git$||'
	end

	cd (__projects | fzf)
end
