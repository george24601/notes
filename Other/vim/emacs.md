M-x dired 
invokes Dired, the file manager mode, on a directory of your choice. Then C-x C-q (or M-x wdired-change-to-wdired-mode) switches to Editable Dired mode. In this mode, changing the filenames in the right-hand column and then typing C-x C-s ("save") renames the indicated files. Renaming files is as easy as editing text. 

M-x shell
Starts a shell in the buffer named *shell*, switching to it if it already exists. Use C-u M-x shell to use a buffer with a different name.

M-x shell-command or M-!
Executes a command and displays the output in a new buffer.

M-x grep 
Invokes grep and prints results in a new buffer.

M-x java-mode

M-x python-mode

M-x text-mode

M-x flyspell-mode
Highlights misspelled words as you type.

M-x follow-mode
If you have a buffer displayed in two windows side by side, follow-mode forces them to scroll together such that the text displayed in the second window comes right after the text in the first window, and moving your cursor off the bottom of the left window causes it to appear at the top of the right window

M-x icomplete-mode
In the M-x prompt (and elsewhere), show completions as you type

If you executed a command and Emacs has modified your buffer, use C-/ to undo that change.
If you pressed a prefix key (e.g. C-x) or you invoked a command which is now prompting you for input (e.g. Find file: …), type C-g, repeatedly if necessary, to cancel.

Quit Emacs: ‘C-x C-c’

Split Window: ‘C-x 2’ or ‘C-x 3’

Unsplit windows (maximize selected window, within its Frame): ‘C-x 1’
Switch to another buffer: ‘C-x b’

You can also press Ctrl-x Ctrl-b to get a list of currently existing buffers

redo: after undo, C-g and then C-x u

cancel current operation: ‘C-g’

Shift a block of lines rigidly right or left: ‘C-x TAB’

Delete to end of sentence: ‘M-k’

Set mark: ‘C-SPC’, `C-@’, ‘M-x set-mark-command’

Transpose adjacent words: ‘M-t’

C-x b
switch-to-buffer. Prompts for a buffer name and switches the buffer of the current window to that buffer. Doesn't change your window configuration. This command will also create a new empty buffer if you type a new name; this new buffer will not be visiting any file, no matter what you name it.

C-x C-b
list-buffers. Pops up a new window which lists all your buffers, giving for each the name, modified or not, size in bytes, major mode and the file the buffer is visiting.

C-x k
kill-buffer. Prompts for a buffer name and removes the entire data structure for that buffer from Emacs. If the buffer is modified you'll be given an opportunity to save it. Note that this in no way removes or deletes the associated file, if any.

C-v
scroll-up. The basic command to scroll forward (towards the end of the file) one screenful. By default Emacs leaves you two lines of context from the previous screen.

M-v
scroll-down. Just like C-v, but scrolls backwards.

C-x o
other-window. Switch to another window, making it the active window. Repeated invocation of this command moves through all the windows, left to right and top to bottom, and then circles around again. Under a windowing system, you can use the left mouse button to switch windows.

C-x 1
delete-other-windows. Deletes all other windows except the current one, making one window on the screen. Note that this in no way deletes the buffers or files associated with the deleted windows.

C-x 0
delete-window. Deletes just the current window, resizing the others appropriately.

C-x 2
split-window-vertically. Splits the current window in two, vertically. This creates a new window, but not a new buffer: the same buffer will now be viewed in the two windows. This allows you to view two different parts of the same buffer simultaneously.

C-x 3
split-window-horizontally. Splits the current window in two, horizontally. This creates a new window, but not a new buffer: the same buffer will now be viewed in the two windows. This allows you to view two different parts of the same buffer simultaneously.

C-M-v
scroll-other-window. Just like C-v, but scrolls the other window. If you have more than two windows, the other window is the window that C-x o would switch to.

【 Ctrl + g 】 → Cancel a command in progress, or cancel unfinished keyboard keystroke sequence.
