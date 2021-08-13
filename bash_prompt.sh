
#-- PROMPT (bash-specific)

if [ "$LOGNAME" == "root" ]; then
  TEXTMOD=0
  TEXTCOLOR=35
  PROMPTSUFFIX=#
else
  TEXTMOD=0
  TEXTCOLOR=34
  PROMPTSUFFIX=">"
fi

export PS1="\e[${TEXTMOD};${TEXTCOLOR}m\e[47m\u@\h \W \t\e[m$PROMPTSUFFIX "

