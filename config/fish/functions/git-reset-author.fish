function git-reset-author -d 'Rewrite git commit history to a single author'
	set -l email (git config --get user.email)
	set -l user (git config --get user.name)

	git filter-branch --env-filter "
		if [ '\$GIT_AUTHOR_EMAIL' != '$email' ]; then
			 GIT_AUTHOR_EMAIL='$email';
			 GIT_AUTHOR_NAME='$user';
			 GIT_COMMITTER_EMAIL=\$GIT_AUTHOR_EMAIL;
			 GIT_COMMITTER_NAME='\$GIT_AUTHOR_NAME';
		fi" -- --all
end
