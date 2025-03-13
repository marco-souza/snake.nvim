<h1 align="center">🐍 Snake for Neovim</h1>
<div>
  <h4 align="center">
    <a href="#install">Install</a> ·
    <a href="#usage">Usage</a>
  </h4>
</div>
<div align="center">
  <a href="https://github.com/marco-souza/plugin.nvim/releases/latest"
    ><img
      alt="Latest release"
      src="https://img.shields.io/github/v/release/marco-souza/snake.nvim?style=for-the-badge&logo=starship&logoColor=D9E0EE&labelColor=302D41&&color=d9b3ff&include_prerelease&sort=semver"
  /></a>
  <a href="https://github.com/marco-souza/snake.nvim/pulse"
    ><img
      alt="Last commit"
      src="https://img.shields.io/github/last-commit/marco-souza/snake.nvim?style=for-the-badge&logo=github&logoColor=D9E0EE&labelColor=302D41&color=9fdf9f"
  /></a>
  <a href="https://github.com/neovim/neovim/releases/latest"
    ><img
      alt="Latest Neovim"
      src="https://img.shields.io/github/v/release/neovim/neovim?style=for-the-badge&logo=neovim&logoColor=D9E0EE&label=Neovim&labelColor=302D41&color=99d6ff&sort=semver"
  /></a>
  <a href="http://www.lua.org/"
    ><img
      alt="Made with Lua"
      src="https://img.shields.io/badge/Built%20with%20Lua-grey?style=for-the-badge&logo=lua&logoColor=D9E0EE&label=Lua&labelColor=302D41&color=b3b3ff"
  /></a>
  <!-- <a href="https://www.buymeacoffee.com/marco-souza" -->
  <!--   ><img -->
  <!--     alt="Buy me a coffee" -->
  <!--     src="https://img.shields.io/badge/Buy%20me%20a%20coffee-grey?style=for-the-badge&logo=buymeacoffee&logoColor=D9E0EE&label=Sponsor&labelColor=302D41&color=ffff99" -->
  <!-- /></a> -->
</div>
<hr />


🐍 Snake game for Neovim (`snake.nvim`).

## Install

```lua
-- Lazy plugin
{
  "marco-souza/snake.nvim",
  cmd = "Snake",
  opts = {},
},
```

## Usage

Install it with your plugin manager, then add a keymap to the following command:

```sh
:Snake
```

To move your snake, you need to use `hjkl`:
```sh
h -> left
j -> down
k -> up
l -> right
```

### Demo

https://github.com/marco-souza/snake.nvim/assets/4452113/22e73925-72ec-4af9-b1c3-023603229a16


https://github.com/marco-souza/snake.nvim/assets/4452113/77e6602c-974a-4b9b-960f-f4ba88da96ab

