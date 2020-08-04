function enc -d 'Shortcuts for encoding videos'
	function helptext
		echo 'Usage: enc <profile> <file>'
		echo ''
		echo 'Profile may be:'
		echo ''
		echo 'h264      encodes with h264/aac'
		echo 'vp9       encodes with vp9/opus'
	end

	if test (count $argv) -le 1
		helptext
		return 0
	end

	set -l profile $argv[1]
	set -l file $argv[2]
	set -l base (string replace -r '\.[[:alnum:]]+$' '' $file)
	switch $profile
		case h264
			# https://askubuntu.com/a/353282
			ffmpeg -benchmark -i "$file" \
				-c:v libx264 \
				-crf 23 -preset medium \
				-c:a aac -b:a 128k \
				-movflags +faststart \
				-vf scale=-1:1080:flags=lanczos,format=yuv420p \
				"$base.mp4"

		case vp9
			ffmpeg -benchmark -i "$file" -y \
				-filter:v scale=1080:-1 \
				-c:v libvpx-vp9 -b:v 0 -crf 30 \
				-pass 1 -an -f webm /dev/null

			and ffmpeg -benchmark -i "$file" \
				-filter:v scale=1080:-1 \
				-c:v libvpx-vp9 -b:v 0 -crf 30 \
				-pass 2 -c:a libopus \
				"$base.webm"

		case '*'
			echo "Profile $profile not understood!"
			echo ''
			helptext
			return 1
	end
end
