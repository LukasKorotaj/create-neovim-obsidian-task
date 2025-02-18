# create-neovim-obsidian-task

This is a very simple, almost entirely AI-generated Neovim plugin for [Obsidian tasks](https://github.com/obsidian-tasks-group/obsidian-tasks). What it does is it creates a small window for an easy creation of tasks.

# Installation

First of all, make sure you change Task Format to Dataview in the Obsidian Tasks plugin! Otherwise, this plugin won't work!

The formatting will still be with emojis inside of Obsidian, so this just changes the Neovim view. I was too lazy to make this work with emojis, sorry.

Put this somewhere in your Neovim config:

```lua
{
    'LukasKorotaj/create-obsidian-task',

    config = function()
      require('tasknote').setup {
        global_filter = '#task',
        keymaps = {
          handle_input = { '<CR>' },
          submit = { '<C-s>' },
        },
      }
    end,
}
```

The setup values are the defaults, so you can skip the config if you want, I think.

# Usage

Open the window with the `:TaskCreateOrEdit` command.

Press `<Cr>`, or whatever you set `handle_input` to, on every line. You can then insert your text in the bar below or select a priority in a submenu. You don't necessarily need to do this for it to work; it will still insert whatever text you set inside, but if you want text like "today," "Monday," "tomorrow," ... to be converted to dates, you need to do it using `handle_input`.

Confirm the input with `<C-s>`, by default.

Lines that are left empty won't be added to the main buffer.

# Notes

This doesn't have all of the features of the Tasks plugin for Obsidian. It doesn't have task dependencies or such. This plugin is okay; it has everything I personally need, so if you want extra features, fork it or make a pull request; that would be nice. I am not planning on adding anything extra. If you have any issues with the plugin, feel free to raise an issue on GitHub.
