`:G` or `:Git`: start the interactive prompt. You can then move around using vim's movement. Once in this screen, press `g?` to get a help screen that explains all the commands available.

* `Untracked`: not tracked by git.
* `Unstaged`: tracked files that have changes in them. Needs to be staged before a commit.
* `Staged`: staged files ready to be committed.

To stage a file: move the cursor to the line of that file and press `s` to add it to the `Staged` list.

To unstage a file: move the cursor to a staged file and press `u` to remove it from the `Staged` list and add it to the `Unstaged` list.

Then, to commit the changes, press `cc`. You will then be asked to provide a commit message. Once done you can just `:wq` it and the commit will commence.

Once you're ready to push your commit, push the commit using `:Git push`.
