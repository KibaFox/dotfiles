package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

var links = map[string]string{
	"~/.config/bat/":             "config/bat/*",
	"~/.config/fish/config.fish": "config/fish/config.fish",
	"~/.config/fish/functions/":  "config/fish/functions/*",
	"~/.config/git/":             "config/git/*",
	"~/.config/ripgrep/":         "config/ripgrep/*",
	"~/.local/bin/":              "local/bin/*",
	"~/.rgignore":                "rgignore",
	"~/.ssh/config":              "ssh/config",
	"~/.tmux.conf":               "tmux.conf",
	"~/.vim/autoload/":           "vim/autoload/*",
	"~/.vimrc":                   "vimrc",
}

// home is the user's home directory.
var home string

func init() {
	var err error
	home, err = os.UserHomeDir()
	fatalErr(err)
}

func main() {
	for dest, glob := range links {
		linkGlob(dest, glob)
	}
}

// linkGlob will create a list of
func linkGlob(dest, glob string) {
	targets, globErr := filepath.Glob(glob)
	fatalErr(globErr)

	for _, target := range targets {
		fmt.Printf("Linking `%s` with `%s`\n", dest, target)
		warn(link(dest, target))
	}
}

// link will symlink the intended target at the given path.  Will expand ~/ with
// the home directory for the target.
func link(dest, target string) error {
	var (
		isDestDir = dest[len(dest)-1] == '/' // is dest a directory?
		absTgt    string                     // absolute path of target
		absDst    string                     // absolute path of dest
		fulDst    string                     // full dest path
		dstDir    string                     // destination directory
		relTgt    string                     // relative path to target
		err       error
	)

	// get absolute path of destination, expand ~/
	absDst, err = filepath.Abs(expandHome(dest))
	if err != nil {
		return fmt.Errorf("problem finding absolute path for `%s`: %w",
			dest, err)
	}

	// get absolute path of link target
	absTgt, err = filepath.Abs(target)
	if err != nil {
		return fmt.Errorf("problem finding absolute path for `%s`: %w",
			target, err)
	}

	// check if link target exists
	if _, err := os.Stat(absTgt); err != nil {
		return fmt.Errorf("link target `%s` does not exist", absTgt)
	}

	// define the destination diretory and the full destination path
	if isDestDir {
		dstDir = absDst
		fulDst = filepath.Join(absDst, filepath.Base(absTgt))

	} else {
		dstDir = filepath.Dir(absDst)
		fulDst = absDst
	}

	// ensure destination directory is made and is a directory
	if destInfo, err := os.Stat(dstDir); err != nil {
		if err = os.MkdirAll(dstDir, 0o755); err != nil {
			return fmt.Errorf(
				"could not make destination dir `%s`: %w", dest, err)
		}
	} else if !destInfo.IsDir() {
		return fmt.Errorf("destination `%s` is not a directory", dest)
	}

	// remove full destination path, if is a link
	if _, err := os.Lstat(fulDst); err == nil {
		if os.Remove(fulDst) != nil {
			return fmt.Errorf(
				"failed to remove existing link at `%s`", dest)
		}
	}

	if relTgt, err = filepath.Rel(dstDir, absTgt); err != nil {
		return fmt.Errorf(
			"could not find relative path from `%s` to `%s`",
			dest, target)
	}

	return os.Symlink(relTgt, fulDst)
}

// expandHome will replace ~/ with the user home directory.
func expandHome(path string) string {
	if strings.HasPrefix(path, "~/") {
		path = home + path[1:]
	}

	return path
}

// fatalErr will print the error and exit if err is not nil.
func fatalErr(err error) {
	if err != nil {
		fmt.Printf("ERROR: %v\n", err)
		os.Exit(1)
	}
}

// warn will the error if err is not nil.
func warn(err error) {
	if err != nil {
		fmt.Printf("WARN: %v\n", err)
	}
}
