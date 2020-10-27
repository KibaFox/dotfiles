function pwrem -d 'Password remember.  Practice a password to remember it.'
	function _help
		echo 'Usage: pwrem [options]'
		echo ''
		echo 'Run without options to practice the stored password.'
		echo ''
		echo 'Options:'
		echo ''
		echo '-a, --add         to add a new password'
		echo '-d, --del         to delete the password'
		echo '-r, --reveal      to reveal the password'
		echo '-h, --help        to show this help text'
	end

	function _get -d 'Get password'
		security find-generic-password -a "$USER" -s 'pwrem' -w
		or return 1
	end

	function _add -d 'Add password to remember'
		echo 'Please enter a new password to store in the keychain...'

		read --local --silent passwd
		or return 1

		security add-generic-password -a "$USER" -s 'pwrem' -U -w "$passwd"
		or return 1

		echo 'Your password is saved to keychain.'
		echo 'Run `pwrem` without options to practice it.'
	end

	function _del -d 'Delete password'
		security delete-generic-password -a "$USER" -s 'pwrem'
		or return 1

		echo 'Password deleted from keychain.'
	end

	argparse --name=pwrem 'a/add' 'd/del' 'r/reveal' 'h/help' -- $argv
	or return

	if test -n "$_flag_h"
		_help
		return
	end

	if test -n "$_flag_a"
		_add
		or return 1
	else if test -n "$_flag_d"
		_del
		or return 1
	else if test -n "$_flag_r"
		_get
		or return 1
	else
		if not isatty
			# escape if we aren't in a TTY
			return
		end

		set -l pw (_get)
		or return 0 # no password

		while true
			echo 'Enter the password you are trying to remember:'
			read --local --silent --prompt-str='Password> ' passwd

			if test "$pw" = "$passwd"
				echo 'Correct!  Run `pwrem --del` to delete your password.'
				continue
			end

			echo 'Incorrect!  Reveal password?)'
			read --local --prompt-str='y/n> ' reveal

			if test "$reveal" = 'y'
				_get
			end
		end
	end
end
