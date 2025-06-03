#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURRENT="$(tmux display-message -p '#S')"

FOLDERS=(
    ~/work 
    ~/.dotfiles
    ~/projects
)

handle_keymaps() {
    km_sessions="Ctrl-s"
    km_projects="Ctrl-d"
    km_kill_session="Ctrl-k"
    km_rename_session="Ctrl-r"
}

handle_style() {
    HEADER="$km_sessions=sessions  $km_projects=new project  $km_kill_session=󱂧  $km_rename_session=󰑕 "
    PREVIEW_LOCATION="bottom"
    PREVIEW_RATIO="80%"
    style_opts=(
        --header="$HEADER"
        --tac
        --border=bold
        --border-label="Current session: \"$CURRENT\""
        --layout=reverse-list
        --preview-window="${PREVIEW_LOCATION},${PREVIEW_RATIO},,"
    )
}

switch_to_session() {
    if [[ -z "$1" ]] ; then
        exit 1
    fi
    selected=$1
    selected_name=$(basename $selected)

    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -d -c $selected -s $selected_name 
        exit 0
    fi


    if ! tmux has-session -t=$selected_name 2> /dev/null; then
        tmux new-session -d -c $selected -s $selected_name 
    fi

    tmux switch-client -t $selected_name
}

handle_binds() {
    SESSION_COMMAND="tmux list-sessions | sed 's/:.*$//' | grep -v $CURRENT"
    SESSION_PREVIEW="tmux capture-pane -ep -t {}"
    NEW_SESSION_COMMAND="fd . "${FOLDERS[@]}" --min-depth=1 --max-depth=1 -t=d"

    KILL_SESSION_COMMAND="tmux kill-session -t {}"
	RENAME_SESSION_COMMAND='bash -c '\'' printf >&2 "New name: ";read name; tmux rename-session -t {1} "${name}"; '\'''

    bind_existing_sessions="$km_sessions:reload($SESSION_COMMAND)+change-prompt(Sessions> )+change-preview($SESSION_PREVIEW)"
    bind_new_project="$km_projects:reload($NEW_SESSION_COMMAND)+change-prompt(Project> )+change-preview(tree {})"
    bind_sessionize="enter:execute(eval switch_to_session)"
    
    bind_rename_session="$km_rename_session:execute($RENAME_SESSION_COMMAND)+reload($SESSION_COMMAND)+change-prompt(Sessions> )"
    bind_kill_session="$km_kill_session:execute-silent($KILL_SESSION_COMMAND)+reload($SESSION_COMMAND)+change-prompt(Sessions> )"

    # crutch for starting in session mode
    bind_start="start:reload($SESSION_COMMAND)+change-prompt(Sessions> )+change-preview($SESSION_PREVIEW)"
    binds=(
        --bind="$bind_existing_sessions"
        --bind="$bind_new_project"
        --bind="$bind_rename_session"
        --bind="$bind_kill_session"
        --bind="$bind_start"
    )
}

handle_keymaps
handle_style
handle_binds

args=(
    "${binds[@]}"
    "${style_opts[@]}"
)

RESULT=$(fzf "${args[@]}" | tail -n1)
switch_to_session "$RESULT"
