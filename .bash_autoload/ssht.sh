function ssht()
{
    ssh "$(tmux list-windows -F '#{window_name} #{?window_active,active_tmux_window,}' | grep active_tmux_window | cut -d ' ' -f 1)"
}
