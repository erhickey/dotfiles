-- load all lua files in autorun
-- files are loaded in order alphabetically
for filename in io.popen('ls -pqAL "$HOME/.config/nvim/lua/autorun"'):lines() do
  filename = filename:match('^(.*)%.lua$')
  if filename then
    require('autorun/' .. filename)
  end
end
