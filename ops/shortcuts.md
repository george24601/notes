### Vim

append to the end of line
```
:%s/$/replace_string/g
```

jump back to the "{" at the start of the current code block
```
[{
```
And conversely
```
]}
```

jump from the use of a variable to its local declaration
```
gd
```
The same mechanism can be used to type a long word with just a few characters. Especially useful for words that you find hard to type, and it avoids that you type them wrong. Examples:
```
:abbr pn penguin
:ab MS Mandrake Software
```

H/M/L: cursor to high/middle/low part of the page

Ctrl+R:	Redo the last undo.

Ctrl+G	Tells where where you are, and what file you're editing

Ctrl+F, Ctrl+B	The same as PgUp and PgDn. I often use F=forward, B=backward as mnemonic.

C/D - change/delete rest of the line

:%s/foo/bar(&)/g will look for foo, and surround the matched pattern with bar().

[[ : sections backward or to the previous '{' in the first column.

]] : sections forward or to the next '{' in the first column.

select row(s)                            SHIFT + v
select blocks (columns)                  CTRL  + v

gi - switches to insertion mode placing the cursor at the same location it was previously

g; - puts the cursor at the place an edit was made, g, goes to the front

If you're editing a line that is wrapped because it's wider than your buffer, you can move up/down using gk and gj.

Until [character] (t). Useful for any command which accepts a range. My favorite is ct; or ct) which deletes everything up to the trailing semicolon / closing parentheses and then places you in insert mode.

Save the open session so that you can get back to your list of open files later
```
:mksession session_file_name.vim
vim -S session_file_name.vim
```
gt	Cycle forward through your open tabs
gT	Cycle backward through your open tabs
Ngt	Go to the Nth tab


{ — Move to start of previous paragraph or code block.
} — Move to end of next paragraph or code block.

t<char> — Move forward until the next occurrence of the character.
f<char> — Move forward over the next occurrence of the character.
T<char> — Move backward until the previous occurrence of the character.
F<char> — Move backward over the previous occurrence of the character.

### IntelliJ
recent files pop-up
C + A + arrow 

Recent edited files
C + S + E  

shift tabs
S + C +  []

rename refactor
S + F6

reformat
A + C + L

RC + Show Diagram on types
