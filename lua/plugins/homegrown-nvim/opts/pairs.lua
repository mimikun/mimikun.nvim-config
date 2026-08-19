-- Enable zero-dependency autopairs
local pairs = {
  enabled = true,

  self_closing_tags = {
    area = true,
    base = true,
    br = true,
    col = true,
    embed = true,
    hr = true,
    img = true,
    input = true,
    keygen = true,
    link = true,
    meta = true,
    param = true,
    source = true,
    track = true,
    wbr = true,
  },

  tag_filetypes = {
    astro = true,
    heex = true,
    html = true,
    javascriptreact = true,
    jinja = true,
    markdown = true,
    php = true,
    svelte = true,
    typescriptreact = true,
    vue = true,
    xhtml = true,

    -- Enable tag-closing in XML files
    xml = true,
  },
}

return pairs
