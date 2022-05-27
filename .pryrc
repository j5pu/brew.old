# frozen_string_literal: true

require 'pry'
[Pathname.pwd, Pathname.pwd / 'Library/Homebrew'].each do |path|
  $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
end
Pry.config.pager = false
Pry.config.history_load = true
Pry.config.history_save = true
Pry.config.requires = %w[init]
Pry.config.history_file = '~/.irb_history'
