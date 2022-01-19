function j -d "Jump to a project"
	function _help
		echo 'Usage: j [QUERY ...]'
		echo ''
		echo 'Jump to a project.'
		echo ''
		echo 'fzf is used to select a project. Arguments are used as the initial fzf query.'
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

	set -l selection (__projects | fzf --query="$argv" --preview='bat --color always --plain {}/README.md; or ls -lAh {}')

	if test -n "$selection"
		cd "$selection"
	end
end
