# Check version control
vcs_status() {
    if [[ $(whence in_svn) != "" ]] && in_svn; then
        svn_prompt_info
    elif [[ $(whence in_hg) != "" ]] && in_hg; then
        hg_prompt_info
    else
        git_prompt_info
    fi
}

if [[ "$SESSION_TYPE" == "remote/ssh" ]]; then
		PROMPT_CHAR="@"
else
		PROMPT_CHAR=">"
fi

PROMPT='$(git_prompt_info) $PROMPT_CHAR %u%{$reset_color%}'
