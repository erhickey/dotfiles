config.load_autoconfig()

c.editor.command = [ 'st', 'vim', '{file}' ]

c.url.searchengines = { 'DEFAULT': 'https://google.com/search?q={}' }
c.url.start_pages = [ 'https://google.com' ]

c.colors.webpage.darkmode.enabled = True

c.content.user_stylesheets = [ 'qutebrowser.css' ]
