# vi: ft=sh
# Various aliases and functions used for convenience

############################################################
# ls with color and ll                                     #
############################################################
if [[ "$OSTYPE" == darwin* ]]; then
    alias ls='ls -Gp'
    alias ll='ls -lGp'
else
    alias ls='ls -p --color'
    alias ll='ls -lp --color'
fi


############################################################
# ssh and scp                                              #
############################################################
alias ssh_to_home="ssh -i $SSH_TO_HOME_PRIVATE_KEY_FILE -p $SSH_TO_HOME_PORT $SSH_TO_HOME_USERNAME@$SSH_TO_HOME_HOST"
alias ssh_tunnel_for_printer="ssh -i $SSH_TO_HOME_PRIVATE_KEY_FILE -p $SSH_TO_HOME_PORT $SSH_TO_HOME_USERNAME@$SSH_TO_HOME_HOST -L 1631:$SSH_TO_HOME_PRINTER:631 -N"

# TODO: These functions do not work very well... (e.g., for 
# multiple files or also issue with using ~ on remote machine
# without quotes
scp_from_home() {
	scp -i $SSH_TO_HOME_PRIVATE_KEY_FILE -P $SSH_TO_HOME_PORT $SSH_TO_HOME_USERNAME@$SSH_TO_HOME_HOST:$1 $2
}
scp_to_home() {
	scp -i $SSH_TO_HOME_PRIVATE_KEY_FILE -P $SSH_TO_HOME_PORT $1 $SSH_TO_HOME_USERNAME@$SSH_TO_HOME_HOST:$2
}


############################################################
# small helpers                                            #
############################################################
alias lpass-login="lpass login $LPASS_EMAIL"

alias findjs='find . -type f -name '"'"'*.js'"'"' -and -not -path '"'"'*node_modules*'"'"' -and -not -path '"'"'*plugins*'"'"' -and -not -path '"'"'*bower_components*'"'"

xmlless() {
    xmllint --format $1 | less
}

alias urldecode='python -c "import sys, urllib as ul; \
    print ul.unquote_plus(sys.argv[1])"'

alias urlencode='python -c "import sys, urllib as ul; \
    print ul.quote_plus(sys.argv[1])"'

pdfcompress() {
    gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/${3:-"printer"} -dCompatibilityLevel=1.4 -sOutputFile="$2" "$1"
}

