# create-neovim-obsidian-task

This is a very simple, Neovim plugin for [Obsidian tasks](https://github.com/obsidian-tasks-group/obsidian-tasks). What it does is it creates a small window for an easy creation of tasks.

# Installation

First of all, make sure you change Task Format to Dataview in the Obsidian Tasks plugin! Otherwise, this plugin won't work!
The Global filter should be the same as in the Obsidian Tasks plugin. If you don't use a global filter set the `global_filter` to `''`, as the default is `#task`.

The formatting will still be with emojis inside of Obsidian, so this just changes the Neovim view.

Setup for lazy.nvim:

```lua
return {
  {
    'LukasKorotaj/create-neovim-obsidian-task',

    config = function()
      require('tasknote').setup {
        global_filter = '#task',
        keymaps = {
          handle_input = { '<CR>' },
          submit = { '<C-s>' },
        },
        statuses = {
          { command = 'TaskToggleInProgress', symbol = '/', append = ' ' },
          { command = 'TaskToggleDone', symbol = 'x', append = '[completed:: today' },
          { command = 'TaskToggleCancelled', symbol = '-', append = '[cancelled:: today]' },
        },
      }
    end,
  },
}
```
The keybindings are the defaults, but you need to have the statuses if you want them.
# Usage

## Creating tasks
Open the window with the `:TaskCreateOrEdit` command.

Press `<Cr>`, or whatever you set `handle_input` to, on every line. You can then insert your text in the bar below or select a priority in a submenu. You don't necessarily need to do this for it to work; it will still insert whatever text you set inside, but if you want strings like "today," "Monday," "tomorrow," ... to be converted to dates, you need to do it using `handle_input`.

Confirm the input with `<C-s>`, by default.

Lines that are left empty won't be added to the main buffer.

## Date format
The date should be written in this format: `YYYY-MM-DD`. This is due to the Obsidian tasks plugin.

## Changing task status
If you copied the config file, you will be able to toggle the default Obsidian tasks statuses with `:TaskToggleDone`, `:TaskToggleInProgress` and `:TaskToggleCancelled`. The difference between changing the symbol inside the brackets manually and using the commands is that you can use the commands to automatically append strings with a valid time format.

## Shortcuts
You don't need to write the date unless you want to. The shortcuts that automatically change to dates are: monday, tuesday, wednesday, thursday, friday, saturday, sunday, mon, tue, wed, thu, fri, sat, sun, yesterday, today, now, tomorrow, in X days/weeks, X days/weeks ago, Xd/w, Xd/w ago. There are no shortcuts for months. You have to enter those manually.

# Config file
In the config file, you can change the default keybindings and add your own statuses. There are some restrictions to what you can do; the symbol can only be one character, and the text must include a valid time format; otherwise, the command won't show up in Neovim.

# Notes

This doesn't have all of the features of the Tasks plugin for Obsidian. It doesn't have task dependencies or such. This plugin has everything I personally need, so if you want extra features, fork it or make a pull request; that would be nice. If you have any issues with the plugin, feel free to raise an issue on GitHub.

A lot of this plugin was AI-generated, which I am not really proud of, but it works. So if the code/comments seem generated, it's because they mostly are.

I am not planning on adding emoji support.
