require 'active_support/concern'
require 'active_support/inflector'

module Patternifier::Base
  extend ActiveSupport::Concern

  def config
    self.class.config
  end

  def patterns_root
    self.config[:patterns_root]
  end

  class_methods do
  	def config
  	  @config ||= {}
  	end

    def patterns_root(path)
      config[:patterns_root] = path
    end

    def patterns(*args)
      config.fetch(:patterns, []) << args
      args.each do |pattern_name|
      	# require "pry"; binding.pry
        method_name = "#{pattern_name.to_s.singularize}_for"
        self.define_method(method_name) do |pattern_object_name|
          require File.join(patterns_root, pattern_name.to_s, pattern_object_name.to_s)
          pattern_object_name.to_s.classify.constantize.new
        end
      end
    end
  end
end
