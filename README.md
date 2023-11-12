
# 💡 Eureka - Here when your memory is not

This is a plugin for Neovim that helps you keep track of important stuff. 

When I started using Neovim, I had a hard time remembering some of the commands(or even forgetting that I had some that I could use for a specific case). That's why I made Eureka. It's a simple tool where you can write down notes and commands, so you don't forget them.

With Eureka, you get a special place in Neovim to write and see your notes anytime.

There is a place for the "Default Notes"(you can add from the configs) which are not changed from the popup(you can change them visually but they will be there again the next time you open it)

There is also the section for the "Custom Notes" which you can edit directly from the popup.

Now, let's get Eureka set up on your Neovim.


## ⚙️ Installation

Here's what you need to do:

Add this line in your packer configuration
```lua
   use("EdmondTabaku/eureka")
```

Then configure your default notes, close key, and popup remap:

```lua
local eureka = require('eureka')

eureka.setup({
    default_notes = {
        "yi() - yank content between ()",
    },
    close_key = "<Esc>",
})

vim.keymap.set("n", "<C-u>", eureka.show_notes)
```

There is no default keymap for the show_notes function so make sure to add the last line. While the default close key is 'q'.

Dont forget to run :PackerInstall
## Usage

Using Eureka is simple. Here's what you do:

1. **Open Your Notes**: Press the key you chose (like `<C-o>`) to see your notes.

2. **Edit Notes**: Just start typing like you normally do in Neovim.

3. **Close and Save**: When you're done, press the close key (like `q` or another key you picked). This saves your notes and closes the window.

That's it.

## 👀 Take a peek 

![Peek](https://raw.githubusercontent.com/EdmondTabaku/eureka/master/eureka.png)
## 🤝 Contributing
Contributions are welcomed, whether it's bug fixes, new features, or improvements to the documentation.

