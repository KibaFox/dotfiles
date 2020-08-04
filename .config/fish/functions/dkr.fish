function dkr -d "Shortcuts for managing Docker"
	function helptext
		echo 'Usage: dkr <command>'
		echo ''
		echo 'Command may be:'
		echo ''
		echo 'killall	to kill and remove all containers'
		echo 'clean	to remove exited docker containers'
		echo 'clean-img	to remove dangling images'
		echo 'clean-vol	to remove dangling volumes'
		return 0
	end

	if test (count $argv) -le 0
		helptext
		return 0
	end

	set -l cmd $argv[1]
	switch $cmd
		case killall
			set -l containers (docker ps -a -q)
			if test -n "$containers"
				docker rm -f $containers
			end

		case clean
			set -l exited (docker ps -a -q -f status=exited)
			if test -n "$exited"
				docker rm -v $exited
			end

		case clean-img
			set -l dangling (docker images -f "dangling=true" -q)
			if test -n "$dangling"
				docker rmi $dangling
			end

		case clean-vol
			set -l dangling (docker volume ls -qf dangling=true)
			if test -n "$dangling"
				docker volume rm $dangling
			end

		case '*'
			echo "Command $cmd not understood!"
			echo ''
			helptext
			return 1
	end
end

complete -c dkr -x -a 'clean clean-img clean-vol killall'
