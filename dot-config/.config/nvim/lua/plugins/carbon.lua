local carbon = require('carbon-now')

carbon.setup({
  options = {
    base_url = "https://carbon.now.sh/",
    open_cmd = "xdg-open",
    options = {
      theme = "cobalt",
      window_theme = "none",
      font_family = "Hack",
      font_size = "18px",
      bg = "gray",
      line_numbers = true,
      line_height = "133%",
      drop_shadow = false,
      drop_shadow_offset_y = "20px",
      drop_shadow_blur = "68px",
      width = "680",
      watermark = false,
    },
  }
})