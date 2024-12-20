''
    # https://askql.wordpress.com/2011/01/11/zsh-writing-own-completion/
    fpath=(~/.zsh/comp $fpath)

    #[ File ]#######################################################################
    # http://www.thregr.org/~wavexx/rnd/20141010-zsh_show_ambiguity/
    zmodload zsh/complist
    autoload -U compinit
    compinit -u
    zstyle ':completion:*' show-ambiguity true
    autoload -U colors
    colors
    zstyle ':completion:*' show-ambiguity "1;$color[fg-red]"


    zstyle ':completion:*' add-space true
    zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list
    zstyle ':completion:*' menu select=1
    zstyle ':completion:*' file-sort name
    zstyle ':completion:*' list-colors $${(s.:.)ZLS_COLORS}
    zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**' 'l:|=** r:|=**'
    zstyle ':completion:*' menu select
    zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

    #[ Formats ]####################################################################
    zstyle ':completion:*' group 1
    zstyle ':completion:*' format '%B---- %d%b'
    zstyle ':completion:*:corrections' format '%B---- %d (errors %e)%b'
    zstyle ':completion:*:descriptions' format "%B---- %d%b"
    zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
    zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"
    zstyle ':completion:*' group-name ""

    #[ Kill ]#######################################################################
    zstyle ':completion:*:processes' command 'ps -au$USER -o pid,time,cmd|grep -v "ps -au$USER -o pid,time,cmd"'
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)[ 0-9:]#([^ ]#)*=01;30=01;31=01;38'

    #[ hosts and users ]############################################################
    hosts=($( ( \
            ( [ -r ~/.ssh/config ] && awk '/^host +[a-z]/ { print $2 }' ~/.ssh/config) ; \
            ( [ -r ~/.ssh/known_hosts ] && awk '/^\w/ {print $1}' ~/.ssh/known_hosts | tr , '\n') \
    ) | grep -v '\*' | sort -u))

    zstyle ':completion:*' hosts $hosts
    zstyle ':completion:*:hosts' list-colors '=(#b)(*)(.jukie.net)=01;30=01;31' '=[^.]#=01;31'

    users=($USER root labuser)
    if [[ $USER = bart ]] ; then
        users=($${users[@]} bartman)
    fi
    zstyle ':completion:*' users $users

    zstyle ':completion:*:*:[ak]dvi:*' file-patterns \
        '*.dvi:dvi-files:DVI\ files *(-/):directories:Directories' '*:all-files'
    zstyle ':completion:*:*:kghostview:*' file-patterns \
        '*.(ps|pdf)(|.gz|.bz2):pspdf-files:PostScript\ or\ PDF\ files  *(-/):directories:Directories' '*:all-files'
    zstyle ':completion:*:*:swfplayer:*' file-patterns \
        '*.swf:swf-files:Swf\ files  *(-/):directories:Directories' '*:all-files'

    zstyle ':completion:*' file-patterns \
        '%p:globbed-files: *(-/):directories:Directories' '*:all-files'

    #[ ignores for vim ]############################################################

    zstyle ':completion:*:*:vi(m|):*:*files' ignored-patterns '*?.(aux|dvi|ps|pdf|bbl|toc|lot|lof|o|cm?)'
''
