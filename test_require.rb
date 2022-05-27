require "standalone" unless defined?(T)
require "cask/config"

Dir.chdir File.expand_path('..', __dir__) do

end

puts ENV["HOMEBREW_PREFIX"]
# TODO: lo dejo si lo hago con comando liego faltaran otras cosas.... o sea igual hacer el global y ver
# realmente las variables que necesito
#
#
#
# require 'formulary'
# curl = Formulary.factory('curl')
#
# unless Formulary.factory('curl').any_version_installed?
#   odie "Fail to install homebrew curl" unless system('brew', 'install', 'curl')
# end

require "utils/gems"

unless system "bundler", "check"
  Homebrew.setup_gem_environment!
  system "bundler", "install"
end

return if Gem.loaded_specs.include? "colorize"

Homebrew.install_gem!("colorize")
require "colorize"
require "standalone"
