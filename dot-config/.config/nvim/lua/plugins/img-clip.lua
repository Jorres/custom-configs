require "img-clip".setup {
  default = {
    dir_path = "photos",
    file_name = "%Y-%m-%d-%H-%M-%S",
    use_absolute_path = false,
    relative_to_current_file = false,

    template = "$FILE_PATH",
    url_encode_path = false,
    relative_template_path = true,
    use_cursor_in_template = true,
    insert_mode_after_paste = true,

    prompt_for_file_name = false,
    show_dir_path_in_prompt = false,
  },

  filetypes = {
    markdown = {
      url_encode_path = true,
      template = "![$CURSOR]($FILE_PATH)",
      download_images = false,
    },
  },
}
