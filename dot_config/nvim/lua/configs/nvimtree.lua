local options = {
  sort_by = "case_sensitive",
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  view = {
    adaptive_size = true,
    side = "left",
    width = 25,
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "none",
    indent_markers = {
      enable = false,
    },
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    custom = { "^.git$", "^.null-ls.*$", "^__pycache__$" },
  },
}
return options
