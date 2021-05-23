function towebp -d 'To WebP. Convert an image to WebP using GraphcsMagick.'
	function _help
		echo 'Usage: towebp [options] FILES...'
		echo ''
		echo 'Run without options to convert with default settings.'
		echo ''
		echo 'Options:'
		echo ''
		echo '-i, --icon        create an icon'
		echo '-h, --help        to show this help text'
	end

	argparse --name=towebp 'i/icon' 'h/help' -- $argv
	or return

	if test -n "$_flag_h"
		_help
		return
	end

	if not command -q gm
		echo 'Command `gm` not found.  Please install GraphicsMagick.'
		return 1
	end

	if test -n "$_flag_i"
		echo 'Icon option not implemented yet!'
		return 1
	end

	for file in $argv
		set -l webp (string replace -i -r '\.(png|jpg|jpeg)$' '.webp' "$file")
		gm convert "$file" -resize '1024x>' "$webp"
	end
end
