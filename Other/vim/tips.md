append to the end of line
```
:%s/$/replace_string/g
```

jump back to the "{" at the start of the current code block.
```
[{
```

jump from the use of a variable to its local declaration
```
gd
``

You can type "XpmCr", then hit CTRL-N and Vim will expand it to "XpmCreatePixmapFromData" for you (???)

When you are typing a phrase or sentence multiple times, there is an even quicker approach. Vim has a mechanism to record a macro. You type qa to start recording into register 'a'. Then you type your commands as usual and finally hit q again to stop recording. When you want to repeat the recorded commands you type @a. There are 26 registers available for this.

Very often you will make the same mistake again and again. Your fingers just don't do what you intended. This can be corrected with abbreviations. A few examples:
```
:abbr Lunix Linux
:abbr accross across
:abbr hte the
```

The same mechanism can be used to type a long word with just a few characters. Especially useful for words that you find hard to type, and it avoids that you type them wrong. Examples:
```
:abbr pn penguin
:abbr MS Mandrake Software
```
