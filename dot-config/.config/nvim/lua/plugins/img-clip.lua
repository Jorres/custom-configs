require "img-clip".setup {
  default = {
    file_name = "%Y-%m-%d-%H-%M-%S",
    use_absolute_path = false,
    relative_to_current_file = false,
    extension = "jpg",

    template = "$FILE_PATH",
    url_encode_path = false,
    relative_template_path = true,
    use_cursor_in_template = true,
    insert_mode_after_paste = false,

    prompt_for_file_name = false,
    show_dir_path_in_prompt = false,

    dir_path = function()
      local l, r = string.find(vim.fn.expand("%:t:r"), "deck")
      if l ~= nil then
        return "anki/img"
      end

      print(vim.fn.expand("%:t:r"))
      local l, r = string.find(vim.fn.expand("%:t:r"), "media")
      if l ~= nil then
        return "anki/img"
      end

      return "photos"
    end,
  },

  filetypes = {
    markdown = {
      url_encode_path = true,
      template = "- ![$CURSOR]($FILE_PATH)",
      download_images = false,
    },
  },
}
