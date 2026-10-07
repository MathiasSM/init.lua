---@module "snacks"

---@type blink.cmp.Config
local blink_opts = {
  keymap = {
    preset = "default",
    -- Trigger completion when the menu is hidden; select when it is open
    ["<C-n>"] = { "select_next", "show" },
    ["<C-p>"] = { "select_prev", "show" },
    ["<C-Space>"] = { "select_and_accept", "fallback" },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = { window = { border = "rounded" } },
    menu = { border = "rounded" },
  },
  signature = {
    enabled = true,
    window = { border = "rounded" },
  },
  fuzzy = { implementation = "prefer_rust" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "calc", "tmux" },
    per_filetype = {
      markdown = { inherit_defaults = true, "cmp_pandoc", "IM" },
      pandoc = { inherit_defaults = true, "cmp_pandoc", "IM" },
      rmd = { inherit_defaults = true, "cmp_pandoc", "IM" },
      tex = { inherit_defaults = true, "cmp_pandoc", "IM" },
      text = { inherit_defaults = true, "cmp_pandoc", "IM" },
      asciidoc = { inherit_defaults = true, "cmp_pandoc", "IM" },
      html = { inherit_defaults = true, "cmp_pandoc", "IM" },
      rst = { inherit_defaults = true, "cmp_pandoc", "IM" },
      gitcommit = { inherit_defaults = true, "cmp_pandoc", "IM" },
    },
    providers = {
      lsp = { score_offset = 999 },
      calc = { name = "calc", module = "blink.compat.source" },
      tmux = {
        name = "tmux",
        module = "blink.compat.source",
        score_offset = -9999,
      },
      cmp_pandoc = { name = "cmp_pandoc", module = "blink.compat.source" },
      IM = { name = "IM", module = "blink.compat.source" },
    },
  },
  cmdline = {
    enabled = true,
    keymap = { preset = "cmdline" },
    completion = { menu = { auto_show = false }, ghost_text = { enabled = false } },
    sources = function()
      if vim.fn.getcmdtype() == ":" then return { "cmdline", "path" } end
      return { "buffer" }
    end,
  },
}

return function()
  require("blink.cmp").setup(blink_opts)

  -- Disable completion inside the snacks picker input (previously done via cmp.setup.filetype)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "snacks_picker_input",
    callback = function() vim.b.completion = false end,
  })

  -- Toggle completion globally. Blink respects `vim.b.completion` per buffer.
  local toggle = Snacks.toggle.new({
    name = "Completion",
    get = function() return vim.b.completion ~= false end,
    set = function(state) vim.b.completion = state end,
  })
  Snacks.keymap.set("n", "<leader><leader>n", function() toggle:toggle() end, { desc = "Toggle completion" })
end
