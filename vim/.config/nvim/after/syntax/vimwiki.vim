

" '- [ ]' should start a bold line, as it's a task
highlight boldline gui=bold cterm=bold guifg=#ffffff
syn match boldline /^\* \[.\].*$/

highlight Section guifg=#FCD885 gui=bold
"syn region Comment start="└" end="┘"
"syn region Comment start="┌" end="┐"

" any box building character is a comment:
" ┌ ┐ └ ┘ ├ ┤ ┬ ┴ ┼ │ ─
syn match Comment "┌"
syn match Comment "┐"
syn match Comment "└"
syn match Comment "┘"
syn match Comment "├"
syn match Comment "┤"
syn match Comment "┬"
syn match Comment "┴"
syn match Comment "┼"
syn match Comment "│"
syn match Comment "─"


"" don't include the start and end characters in the Section:
"" A section is just something like "│  blablabla  │"
"syn region Comment start="│" end="│" contains=Section

"" anything that's in between these two characters is a section:
"syntax match Section "│.*│" contained


