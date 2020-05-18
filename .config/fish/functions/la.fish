# Defined in - @ line 1
function la --wraps='exa -la' --wraps=ls --wraps='ls -la' --description 'alias la=ls -la'
  ls -la $argv;
end
