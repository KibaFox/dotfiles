# Gemini Vim Syntax

This repo contains basic syntax highlighting for the [Gemini protocol](https://gemini.circumlunar.space/)'s **text/gemini** format.

## How to install

```
git clone https://tildegit.org/sloum/gemini-vim-syntax
cd gemini-vim-syntax
make
```

That should get you up and running. Note that this installs the files for your user, not globally for the system. It should support Linux, Unix/BSD/Darwin, Windows, and Haiku out of the box.

## What is supported

The current state of the syntax covers all items officially supported by the [gemini spec](https://gemini.circumlunar.space/docs/spec-spec.txt):

- Links get colored in three parts:
    - =>
    - URL
    - Link text
- Headings
    - Up to three levels
    - Lines that start with one, two, or three _\#_ characters
- List items
    - Lines that start with _*_
- Preformatted text blocks 
    - Handled as a range that starts and ends with _\`\`\`_

I plan to update the syntax when and if the spec adds more items to *text/gemini*.


## Filetype

This syntax is set up to be used with files labled with the **gmi** or **gemini** extensions. For example:
```
$ vim my_gemini_map.gmi
# or
$ vim my_gemini_map.gemini
```

## Surprises

It is possible that Windows users may find that the syntax does not work. I do not have a machine to test it on and would love some feedback. If it is not working it likely has to do with line endings. Windows uses \<cairrage-return\><\<line-feed\> and linux/unix use just \<line-feed\>. There are a number of ways to solve this problem ranging from just replacing the newlines manually to using software. In either case it shouldn't be too difficult. 

## License

All source files are provided under the [unlicense](https://unlicense.org/). 

