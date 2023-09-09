return {
  prompt = function(msg, default)
    local input = vim.fn.input(msg..' (default: '..default..'): ')
    if input == '' then
      return default
    end
    return input
  end
}
