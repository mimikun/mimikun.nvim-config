# Extensions

Here are a few simple guidelines to make an extension for Telescope:

## Examples

<!-- Please append your extensions at the bottom, not at the top. Also, make sure its inserted in the correct table -->

### Sorter

It's suggested to install one native sorter, for better performance

| Extension                                                                                | Description                                                                    |
|------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Native FZF sorter that uses compiled C to do the matching, supports fzf syntax |
| [telescope-fzy-native.nvim](https://github.com/nvim-telescope/telescope-fzy-native.nvim) | Native FZY sorter that uses compiled C to do the matching                      |
| [telescope-zf-native.nvim](https://github.com/natecraddock/telescope-zf-native.nvim)     | Native zf sorter that prioritizes matches on filenames                         |

Below are benchmarks to show the performance difference between lua, fzf, and fzy. Done with an early version of `plenary.benchmark`. The benchmark was done by calculating the score for 240201 file strings in a table. For each `score > 0` we also calculated the positions (this is the slower part for both algorithms, and telescope tends to only do this for the displayed results, usually less than 50 entries).

The benchmark between fzf-native and fzy-native isn't that meaningful. The benefit of fzf-native is the support with the fzf syntax.

[[imgs/bench1.png]]
[[imgs/bench2.png]]

### Different Plugins with telescope integration

| Extension                                                                                            | Description                                                                                                                                                 |
|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [telescope-box-drawing.nvim](https://github.com/nullromo/telescope-box-drawing.nvim)               | Picker for [box drawing characters](https://en.wikipedia.org/wiki/Box-drawing_characters) |
| [telescope-git-branch.nvim](https://github.com/mrloop/telescope-git-branch.nvim)                     |  Find which files and preview what changes have been made on your git branch across multiple commits | 
| [telescope-all-recent](https://github.com/prochri/telescope-all-recent.nvim)                         | (F)recency sorting for all Telescope pickers.                                                                                                               |
| [http-codes.nvim](https://github.com/barrett-ruth/http-codes.nvim)                           | Quickly investigate HTTP status codes                                                                                                                       |
| [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim)                 | A "smart" picker using [Frecency Algorithm](https://developer.mozilla.org/en-US/docs/Mozilla/Tech/Places/Frecency_algorithm) that can learn from your habit |
| [telescope-recent-files.nvim](https://github.com/mollerhoj/telescope-recent-files.nvim)              | Merges the `find_files` and `oldfiles` picker, so files are sorted by how recently they were opened ([async fork](https://github.com/ronandalton/telescope-recent-files.nvim)) |
| [telescope-session.nvim](https://github.com/HUAHUAI23/telescope-session.nvim)                        | A "xray23" picker to help you manage your vim sessions                                                                                                      |
| [octo.nvim](https://github.com/pwntester/octo.nvim)                                                  | Edit and review GitHub issues and pull requests from the comfort of your favorite editor with telescope integration                                         |
| [telescope-pathogen.nvim](https://github.com/brookhong/telescope-pathogen.nvim)                      | Switch working directory for builtin actions on the fly                                                                                                     |
| [telescope-project.nvim](https://github.com/nvim-telescope/telescope-project.nvim)                   | Switch between projects                                                                                                                                     |
| [telescope-completion.nvim](https://github.com/illia-shkroba/telescope-completion.nvim)              | Pick Insert mode completion                                                                                                                                 |
| [telescope-code-fence.nvim](https://github.com/chip/telescope-code-fence.nvim)                       | Fetch Markdown Code Fences from Github                                                                                                                      |
| [telescope-software-licenses.nvim](https://github.com/chip/telescope-software-licenses.nvim)         | View and paste common software licenses into your project                                                                                                   |
| [telescope-git-grep.nvim](https://gitlab.com/davvid/telescope-git-grep.nvim)                         | Search the current buffer's worktree using `git grep` |
| [telescope-git-selector.nvim](https://gitlab.com/davvid/telescope-git-selector.nvim)                 | Quickly search for Git worktrees and open/search files in the selected worktree |
| [telescope-github.nvim](https://github.com/nvim-telescope/telescope-github.nvim)                     | Integration with github cli                                                                                                                                 |
| [telescope-media-files.nvim](https://github.com/nvim-telescope/telescope-media-files.nvim)           | Preview images, pdf, epub, video, and fonts from Neovim using Telescope                                                                                     |
| [telescope-fzf-writer.nvim](https://github.com/nvim-telescope/telescope-fzf-writer.nvim)             | Incorporating some fzf concepts with plenary jobs and Telescope                                                                                             |
| [telescope-symbols.nvim](https://github.com/nvim-telescope/telescope-symbols.nvim)                   | Picking symbols and insert them at point                                                                                                                    |
| [telescope-ghq.nvim](https://github.com/nvim-telescope/telescope-ghq.nvim)                           | Integration with [ghq](https://github.com/x-motemen/ghq)                                                                                                    |
| [telescope-repo.nvim](https://github.com/cljoly/telescope-repo.nvim)                                 | Jump into the repositories (git, mercurial…) of your filesystem                                                                                             |
| [telescope-node-modules.nvim](https://github.com/nvim-telescope/telescope-node-modules.nvim)         | List all node packages under `node_modules` directory                                                                                                       |
| [telescope-z.nvim](https://github.com/nvim-telescope/telescope-z.nvim)                               | Integration with [z](https://github.com/rupa/z)                                                                                                             |
| [telescope-ros.nvim](https://github.com/bi0ha2ard/telescope-ros.nvim)                                | Pick packages from ROS and ROS2 workspaces                                                                                                                  |
| [telescope_hoogle](https://github.com/luc-tielen/telescope_hoogle)                                   | Live search Haskell functions and docs using Hoogle and Telescope!                                                                                          |
| [telescope-tele-tabby.nvim](https://github.com/TC72/telescope-tele-tabby.nvim)                       | Tab switcher                                                                                                                                                |
| [telescope-lsp-handlers.nvim](https://github.com/gbrlsnchs/telescope-lsp-handlers.nvim)              | Handlers for built-in LSP commands                                                                                                                          |
| [browser-bookmarks.nvim](https://github.com/dhruvmanila/browser-bookmarks.nvim)                      | Open your browser bookmarks from Neovim using Telescope                                                                                                     |
| [telescope-heading.nvim](https://github.com/crispgm/telescope-heading.nvim)                          | Switch between document's headings (Markdown, AsciiDoc, rst, org, latex, and Vim Help)                                                                      |
| [telescope-emoji.nvim](https://github.com/xiyaowong/telescope-emoji.nvim)                            | Find emojis😃                                                                                                                                                |
| [telescope-glyph.nvim](https://github.com/ghassan0/telescope-glyph.nvim)                             | Find font glyphs                                                                                                                                            |
| [telescope-opds](https://github.com/kolja/telescope-opds)                                            | browse opds catalogs                                                                                                                                        |
| [goimpl.nvim](https://github.com/edolphin-ydf/goimpl.nvim)                                           | generate interface stubs for a type                                                                                                                         |
| [telescope-gott.nvim](https://github.com/sshelll/telescope-gott.nvim)                                | exec a specific go test                                                                                                                                     
| [telescope-switch.nvim](https://github.com/sshelll/telescope-switch.nvim)                            | switch between files with given rules |                                                                                                                                     
| [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)                                       | clipboard manager                                                                                                                                           |
| [telescope-tmuxinator.nvim](https://github.com/danielpieper/telescope-tmuxinator.nvim)               | tmuxinator integration                                                                                                                                      |
| [cheatsheet.nvim](https://github.com/doctorfree/cheatsheet.nvim)                                     | Cheatsheet plugin for neovim with Telescope as UI, actively maintained fork of [the original plugin](https://github.com/sudormrfbin/cheatsheet.nvim)        |
| [telescope-hop.nvim](https://github.com/nvim-telescope/telescope-hop.nvim)                           | Navigate, select, and perform actions with motions inspired by hop.nvim                                                                                     |
| [scaladex.nvim](https://github.com/softinio/scaladex.nvim)                                           | Search & add [scaladex](https://index.scala-lang.org/) for dependencies/libraries for your scala projects!                                                  |
| [telescope-ctags-outline.nvim](https://github.com/fcying/telescope-ctags-outline.nvim)               | get ctags outline                                                                                                                                           |
| [telescope-command-palette.nvim](https://github.com/LinArcX/telescope-command-palette.nvim)          | Create key-bindings and watch them with telescope                                                                                                           |
| [telescope-terraform-doc.nvim](https://github.com/ANGkeith/telescope-terraform-doc.nvim)             | Browse Terraform providers resources                                                                                                                        |
| [telescope-windowizer.nvim](https://github.com/wesleimp/telescope-windowizer.nvim)                   | Open and edit files in another tmux window and kill the window when exit vim                                                                                |
| [telescope-ag](https://github.com/kelly-lin/telescope-ag)                                            | A Telescope picker for Silver Searcher(Ag) similar to that of `fzf.vim`                                                                                     |
| [telescope-scriptnames.nvim](https://github.com/LinArcX/telescope-scriptnames.nvim)                  | A Telescope extension wrapper around `:scriptnames`                                                                                                         |
| [telescope-changes.nvim](https://github.com/LinArcX/telescope-changes.nvim)                          | A Telescope extension wrapper around `:changes`                                                                                                             |
| [telescope-gitmoji.nvim](https://github.com/olacin/telescope-gitmoji.nvim)                           | A Telescope integration of [gitmoji](https://gitmoji.dev/).                                                                                                 |
| [telescope-cc.nvim](https://github.com/olacin/telescope-cc.nvim)                                     | A Telescope integration of [Conventional Commits](https://www.conventionalcommits.org/).  
| [telescope-cmdline-word.nvim](https://github.com/otavioschwanck/telescope-cmdline-word.nvim)         | Search word for substitute with tab |
| [telescope-ports.nvim](https://github.com/LinArcX/telescope-ports.nvim)                              | Watch open ports on your system with telescope                                                                                                              |
| [command_center.nvim](https://github.com/FeiyouG/command_center.nvim)                                | A command palette for neovim                                                                                                                                |
| [yanky.nvim](https://github.com/gbprod/yanky.nvim)                                                   | Improved Yank and Put functionalities for Neovim                                                                                                            |
| [vim-p4-files](https://github.com/Badhi/vim-p4-files)                                                | List and select files in Perforce repository                                                                                                                |
| [run-code.nvim](https://github.com/arjunmahishi/run-code.nvim)                                       | Create and manage custom commands you can run while writing code                                                                                            |
| [telescope-everything.nvim](https://github.com/Verf/telescope-everything.nvim)                       | Everything integration                                                                                                                                      |
| [telescope-recent-files](https://github.com/smartpde/telescope-recent-files)                         | Picker for recently opened files, including buffers which are not yet saved in `v:oldfiles`                                                                 |
| [easypick.nvim](https://github.com/axkirillov/easypick.nvim)                                         | Create Telescope pickers from arbitrary console commands                                                                                                    |
| [telescope-extension-maker.nvim](https://github.com/adoyle-h/telescope-extension-maker.nvim)         | Easy to make a telescope extension                                                                                                                          |
| [ad-telescope-extensions.nvim](https://github.com/adoyle-h/ad-telescope-extensions.nvim)             | A set of telescope extensions, which build on telescope-extension-maker                                                                                     |
| [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)         | A file browser extension supporting synchronized creation, deletion, renaming, and moving of files and folders                                              |
| [telescope-alternate](https://github.com/otavioschwanck/telescope-alternate.nvim)                    | Alternate between common files using pre-defined regexp. Just map the patterns and starting navigating between files that are related.                      |
| [scout](https://github.com/aloussase/scout.git)                                                      | Browse packages on Hackage and open their haddock in your browser.                                                                                          |
| [telescope-tabs](https://github.com/LukasPietzschmann/telescope-tabs)                                | Fly through your tabs in neovim ✈️                                                                                                                           |
| [telescope-manix](https://github.com/MrcJkb/telescope-manix)                                         | Search Nix documentation using [Manix](https://github.com/mlvzk/manix) and Telescope.                                                                       |
| [telescope-color-names.nvim](https://github.com/nat-418/telescope-color-names.nvim)                  | Picker for X11 / web color names.                                                                                                                           |
| [lsp-toggle.nvim](https://github.com/adoyle-h/lsp-toggle.nvim)                                       | Disable/Enable LSP clients for buffers.                                                                                                                     |
| [dir-telescope.nvim](https://github.com/princejoogie/dir-telescope.nvim)                             | Perform telescope functions in selected directories                                                                                                         |
| [telescope-directory.nvim](https://github.com/fbuchlak/telescope-directory.nvim)                     | Search for directories with telescope and perform any action.                                                                                                      |
| [haskell-tools.nvim](https://github.com/MrcJkb/haskell-tools.nvim#hoogle-search-for-signature)       | Hoogle search for the type signature of the value under the cursor                                                                                          |
| [telescope-menu.nvim](https://github.com/octarect/telescope-menu.nvim)                               | Add a custom menu that executes a command                                                                                                                   |
| [tailiscope.nvim](https://github.com/danielvolchek/tailiscope.nvim)                                  | TailwindCSS cheatsheet within Telescope                                                                                                                     |
| [telescope-undo.nvim](https://github.com/debugloop/telescope-undo.nvim)                              | Visualize and search all changes in your undo tree                                                                                                          |
| [telescope-monorepos.nvim](https://github.com/rishabhjain9191/telescope-monorepos)                   | A telescope extension for fuzzy searching packages in a monorepo(rush) and navigating to its folder                                                         |
| [adjacent.nvim](https://github.com/MaximilianLloyd/adjacent.nvim)                                    | A telescope extension for finding files in the same directory as the current buffer                                                                         |
| [telescope-search-dir-picker.nvim](https://github.com/smilovanovic/telescope-search-dir-picker.nvim) | A Telescope extension for picking the search directory before `live_grep`                                                                                   |
| [telescope-filelinks.nvim](https://github.com/PhilippFeO/telescope-filelinks.nvim)                   | Add file links to your wiki, the `README.md` or any other file using telescope.                                                                             |
| [telescope-docker.nvim](https://github.com/lpoto/telescope-docker.nvim)                              | Manage docker containers, images and compose files from a telescope prompt.                                                                                 |
| [telescope-tasks.nvim](https://github.com/lpoto/telescope-tasks.nvim)                                | Run and preview the definitions and outputs of custom or auto-generated tasks from a telescope prompt.                                                      |
| [telescope-import.nvim](https://github.com/piersolenski/telescope-import.nvim)                       | Import modules faster based on import patterns you've already used elsewhere in your project.                                                               |
| [telescope-texsuite](https://github.com/cagve/telescope-texsuite)                                    | Telescope menus for latex.                                                                                                                                  |
| [whaler.nvim](https://github.com/salorak/whaler.nvim)                                                | Move between directories blazingly fast.                                                                                                                    |
| [telescope-picker-list.nvim](https://github.com/OliverChao/telescope-picker-list.nvim)               | List all telescope pickers including user extensions. Free your brain.                                                                                      |
| [telescope-git-submodules.nvim](https://github.com/agoodshort/telescope-git-submodules.nvim)         | List and preview your project's git submodules. Interact with them with your favourite git TUI.                                                             |
| [telescope-cmdline.nvim](https://github.com/jonarrien/telescope-cmdline.nvim)                        | Telescope extension to use command line in a floating window, rather than in bottom-left corner. |
| [telescope-git-conflicts](https://github.com/Snikimonkd/telescope-git-conflicts.nvim)                | Telescope git conflicts picker. |
| [telescope-rails.nvim](https://github.com/sato-s/telescope-rails.nvim)                | Navigate Rails app easily. |
| [telescope-helpgrep.nvim](https://github.com/catgoose/telescope-helpgrep.nvim)                | Use helpgrep to grep through help files. |
| [cscope-picker](https://github.com/sgruszka/cscope-picker)                | Simple picker for cscope references. |
| [telescope-just.nvim](https://codeberg.org/elfahor/telescope-just.nvim) | A Telescope picker for [just](https://just.systems) |
| [telescope-zotero.nvim](https://github.com/jmbuhr/telescope-zotero.nvim) | A Telescope picker for [Zotero](https://www.zotero.org/) |
| [telescope-foldmarkers.nvim](https://github.com/gbirke/telescope-foldmarkers.nvim)| A Telescope picker for [Vim fold markers](https://vimdoc.sourceforge.net/htmldoc/fold.html#fold-marker). Build a navigable table of contents for long files in your comments. |
| [telescope-jj.nvim](https://github.com/zschreur/telescope-jj.nvim) | A telescope picker to use with [Jujutsu repos](https://github.com/martinvonz/jj) |
| [grit-telescope.nvim](https://github.com/noahbald/grit-telescope.nvim) | A telescope picker for [Grit](https://github.com/getgrit/gritql) |
| [telescope-live-grep-args.nvim](https://github.com/nvim-telescope/telescope-live-grep-args.nvim) | Enables passing arguments to the grep command |
| [telescope-rg.nvim](https://github.com/BlankTiger/telescope-rg.nvim) | Choose your own grep command and arguments on the fly if it outputs in vimgrep format |
| [feed.nvim](https://github.com/neo451/feed.nvim) | Browse and fuzz your way through your web feeds with telescope |
| [telescope-hierarchy.nvim](https://github.com/jmacadie/telescope-hierarchy.nvim) | Explore the function call stack & class super/sub-types as a tree |
| [telescope-messages.nvim](https://github.com/d4wns-l1ght/telescope-messages.nvim) | Find a specific `message` | 
| [telescope-cache](https://github.com/justpresident/telescope-cache) | Cache files from slow and remote filesystems for fast offline browsing| 
| [telescope-docker-commands](https://github.com/zigotica/telescope-docker-commands.nvim) | Picker that lists docker container, image, volume, network, system actions. Setup allows for complete customization of commands and keymaps| 
| [telescope-find-exe.nvim](https://github.com/aloussase/telescope-find-exe.nvim) | Find executable files in a given directory, copy the name to the clipboard or run them |
| [gitree.nvim](https://github.com/rbmarliere/gitree.nvim) | List, select, add, move and remove git worktrees |
| [emotive.nvim](https://github.com/techne98/emotive.nvim) | An emoji picker for Telescope |

### Extensions that offer Telescope integration for another plugin

| Extension                                                                                  | Description                                                                                                               |
|--------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| [telescope-dap.nvim](https://github.com/nvim-telescope/telescope-dap.nvim)                 | [`nvim-dap`](https://github.com/mfussenegger/nvim-dap) integration                                                        |
| [telescope-dapzzzz](https://github.com/HUAHUAI23/telescope-dapzzzz)                        | facilitate dap to load vscode adapter configure file or user custom configuration file                                    |
| [telescope-packer.nvim](https://github.com/nvim-telescope/telescope-packer.nvim)           | A Telescope extension that provides extra functionality for Packer.nvim                                                   |
| [telescope-vimspector.nvim](https://github.com/nvim-telescope/telescope-vimspector.nvim)   | Integration for [vimspector](https://github.com/puremourning/vimspector)                                                  |
| [telescope-asynctasks.nvim](https://github.com/GustavoKatel/telescope-asynctasks.nvim)     | Integration for [asynctasks](https://github.com/skywind3000/asynctasks.vim)                                               |
| [telescope-ultisnips.nvim](https://github.com/fhill2/telescope-ultisnips.nvim)             | Integration for [ultisnips](https://github.com/SirVer/ultisnips)                                                          |
| [telescope-coc.nvim](https://github.com/fannheyward/telescope-coc.nvim)                    | Integration with [coc.nvim](https://github.com/neoclide/coc.nvim)                                                         |
| [session-lens](https://github.com/rmagatti/session-lens)                                   | A Session Switcher extension built on top of [auto-session](https://github.com/rmagatti/auto-session)                     |
| [telescope-openbrowser.nvim](https://github.com/tamago324/telescope-openbrowser.nvim)      | Integration for [open-browser.vim](https://github.com/tyru/open-browser.vim) with Telescope.nvim                          |
| [telescope-vim-bookmarks.nvim](https://github.com/tom-anders/telescope-vim-bookmarks.nvim) | Integration with the [vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks) plugin                               |
| [telescope-tmux.nvim](https://github.com/camgraff/telescope-tmux.nvim)                     | Integration for [tmux](https://github.com/tmux/tmux)                                                                      |
| [telescope-zoxide](https://github.com/jvgrootveld/telescope-zoxide)                        | Integration with [zoxide](https://github.com/ajeetdsouza/zoxide), a smart directory picker that tracks your usage         |
| [neorg-telescope](https://github.com/nvim-neorg/neorg-telescope)                           | Integration with [neorg](https://github.com/nvim-neorg/neorg)                                                             |
| [telescope-luasnip.nvim](https://github.com/benfowler/telescope-luasnip.nvim)              | Integration for [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                                            |
| [telescope-git-diffs.nvim](https://github.com/paopaol/telescope-git-diffs.nvim)            | Integration for [diffview.nvim](https://github.com/sindrets/diffview.nvim)                                                |
| [telescope-lazy.nvim](https://github.com/tsakirist/telescope-lazy.nvim)                    | Integration for [Lazy.nvim](https://github.com/folke/lazy.nvim), provides handy functionality about installed plugins     |
| [telescope-lazy-plugins.nvim](https://github.com/polirritmico/telescope-lazy-plugins.nvim) | Integration for [Lazy.nvim](https://github.com/folke/lazy.nvim), quickly access configurations of plugins managed by lazy |
| [toggleterm-manager.nvim](https://github.com/ryanmsnyder/toggleterm-manager.nvim)          | Customizable Telescope extension to manage [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) terminal buffers |
| [telescope-gpt.nvim](https://github.com/HPRIOR/telescope-gpt)                              | Integration for [chatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim)                                                  |
| [telescope-cscope.nvim](https://github.com/rbmarliere/telescope-cscope.nvim)              | Integration for [cscope_maps](https://github.com/dhananjaylatkar/cscope_maps.nvim)                                         |
| [todo-nu-picker.nvim](https://github.com/petrisch/todo-nu-picker.nvim)              | Integration for [todo-nu](https://github.com/petrisch/todo-nu)                                         |
| [telescope-resession.nvim](https://github.com/scottmckendry/telescope-resession.nvim)              | Integration for [resession.nvim](https://github.com/stevearc/resession.nvim)                                         |

## Extension folder structure
    .
    ├── README.md                   # README for your awesome extension
    └── lua
        ├── tests                   # TODO: Layout for unit tests
        └── telescope
            └── _extensions         # The underscore is significant
                ├─ plugin_name.lua  # Init and register your extension
                └─ plugin_name
                   ├─ file1.lua     # Break up the heavy-lifting in
                   ├─ file2.lua     # several files
                   └─ ...
