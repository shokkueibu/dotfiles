# Defined in - @ line 1
function ls --wraps=exa --wraps='exa -g' --description 'alias ls=exa'
  exa  $argv;
end
