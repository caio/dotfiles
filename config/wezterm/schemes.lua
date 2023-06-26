return {
  -- zenbones light, with a dimmer bg and no black/white swap
  ['light'] = {
    background = "#e8e4e3",
    foreground = "#2c363c",
    cursor_bg = "#2c363c",
    cursor_fg = "#e8e4e3",
    cursor_border = "#2c363c",
    selection_bg = "#d2dfe7",
    selection_fg = "#2c363c",

    ansi = {
      "#2c363c",
      "#a8334c",
      "#617437",
      "#944927",
      "#286486",
      "#88507d",
      "#3b8992",
      "#f0edec",
    },

    brights = {
      "#44525b",
      "#9c2842",
      "#55672a",
      "#87411e",
      "#1f5a7a",
      "#864079",
      "#2f7c85",
      "#dcd2ce",
    }
  },

  -- zenbones dark, with a warmer background
  ['dark'] = {
    background = "#221f1d",
    foreground = "#b4bdc3",
    cursor_bg = "#c4cacf",
    cursor_fg = "#221f1d",
    cursor_border = "#c4cacf",
    selection_bg = "#3d4042",
    selection_fg = "#b4bdc3",

    ansi = {
      "#221f1d",
      "#de6e7c",
      "#819b69",
      "#b77e64",
      "#6099c0",
      "#b279a7",
      "#66a5ad",
      "#b4bdc3",
    },

    brights = {
      "#403833",
      "#e8838f",
      "#8bae68",
      "#d68c67",
      "#61abda",
      "#cf86c1",
      "#65b8c1",
      "#888f94",
    }
  },
}
