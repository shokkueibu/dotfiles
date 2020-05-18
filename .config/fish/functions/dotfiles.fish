# Defined in - @ line 1
function dotfiles --wraps='/usr/bin/git --git-dir=/home/shock/dotfiles --work-tree=/home/shock' --description 'alias dotfiles=/usr/bin/git --git-dir=/home/shock/dotfiles --work-tree=/home/shock'
  /usr/bin/git --git-dir=/home/shock/dotfiles --work-tree=/home/shock $argv;
end
