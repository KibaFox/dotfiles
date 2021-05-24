function towebp -d 'Converts images to WebP using GraphicsMagick batch process.'
	function _help
		echo 'Usage: towebp [options] IMAGES...'
		echo ''
		echo 'Converts images to WebP using GraphicsMagick batch process.'
		echo 'Run without options to convert with default settings.'
		echo ''
		echo 'Options:'
		echo ''
		echo '-r, --resize      resize images to specified geometry.  Default is `1024x>`'
		echo '                  which means resize to 1024 pixels wide if width is larger'
		echo '                  and maintain aspect ratio.'
		echo '-n, --dry-run     print the GraphicsMagick commands, but do not run'
		echo '-h, --help        to show this help text'
	end

	argparse --name=towebp 'n/dry-run' 'r/resize=' 'h/help' -- $argv
	or return

	if test -n "$_flag_help" -o -z "$argv"
		_help
		return
	end

	if not command -q gm
		echo 'Command `gm` not found.  Please install GraphicsMagick.'
		return 1
	end

	if test -z "$_flag_resize"
		set _flag_resize '1024x>'
	end

	function _batch --inherit-variable _flag_resize
		for file in $argv
			set -l webp (string replace -i -r '\.(png|jpg|jpeg)$' '.webp' "$file")
			or set -l webp "$file.webp"
			echo "convert '$file' -resize '$_flag_resize' '$webp'"
			echo "identify '$webp'"
		end
	end

	if test -n "$_flag_dry_run"
		_batch $argv
	else
		_batch $argv | gm batch -echo on -feedback on -stop-on-error on -
		or return 1
	end
end
