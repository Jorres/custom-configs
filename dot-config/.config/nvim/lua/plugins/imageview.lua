-- Require and call setup function somewhere in your init.lua
require('image').setup {
  render = {
    min_padding = 5,
    show_label = true,
		show_image_dimensions = true,
    use_dither = false,
    foreground_color = true,
    background_color = true
  },
  events = {
    update_on_nvim_resize = true,
  },
}
