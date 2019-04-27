function fish_prompt
  # Cache exit status
  set -l last_status $status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_char
    switch (id -u)
      case 0
        set -g __fish_prompt_char '!'
      case '*'
        set -g __fish_prompt_char '$'
    end
  end

  # Setup colors
  set -l normal (set_color normal)
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l bpurple (set_color -o purple)
  set -l bred (set_color -o red)
  set -l bcyan (set_color -o cyan)
  set -l bwhite (set_color -o white)

  # Configure __fish_git_prompt
  set -g __fish_git_prompt_show_informative_status true
  set -g __fish_git_prompt_showcolorhints true
  set -g __fish_git_prompt_char_upstream_ahead '+'
  set -g __fish_git_prompt_char_upstream_behind '-'
  set -g __fish_git_prompt_char_dirtystate '+'
  set -g __fish_git_prompt_char_invalidstate '#'
  set -g __fish_git_prompt_char_stagedstate '*'
  set -g __fish_git_prompt_char_untrackedfiles '~'
  set -g __fish_git_prompt_char_cleanstate '='

  # Color prompt char red for non-zero exit status
  set -l pcolor $bpurple
  if [ $last_status -ne 0 ]
    set pcolor $bred
  end

  # Top
  echo -n $yellow(prompt_pwd)$normal
  __fish_git_prompt

  echo

  # Bottom
  echo -n $pcolor$__fish_prompt_char $normal
end
