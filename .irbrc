require 'irb'
require 'irb/completion'
require 'rubygems'
require 'pp'
IRB.conf[:SAVE_HISTORY] = 1000

IRB.conf[:PROMPT][:MY_PROMPT] = {
  AUTO_INDENT: true, # enables auto-indent mode
  PROMPT_I: '>> ', # simple prompt
  PROMPT_S: nil, # prompt for continuated strings
  PROMPT_C: nil, # prompt for continuated statement
  RETURN: "    ==>%s\n" # format to return value
}

IRB.conf[:PROMPT_MODE] = :MY_PROMPT
def ri(*names)
  system(%{ri #{names.map {|name| name.to_s}.join(" ")}})
end

class Class
  public :include

  # Show only this class class methods
  def class_methods
    (methods - Class.instance_methods - Object.methods).sort
  end

  # Show instance and class methods
  def defined_methods
    methods = {}

    methods[:instance] = new.local_methods
    methods[:class] = class_methods

    methods
  end
end

class Object
  # Show local methods from the object's class
  def defined_methods
    (methods - Object.instance_methods).sort
  end

  # Open a particular method in an editor
  def ocode(method_name)
    file, line = self.method(method_name).source_location

    if file && line
      # or code -g
      `subl '#{file}:#{line}'`
    else
      "'#{method_name}' not found."
    end
  end
end
define_singleton_method(:load) { require_relative "./init" }
