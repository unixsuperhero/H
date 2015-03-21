#!/usr/bin/env ruby

#require 'english'  # actual names for global variables instead of dollars and symbols
require 'awesome_print'


class HeroParser
  attr_accessor :data, :lines
  attr_accessor :metadata, :name, :tags

  def initialize(stdin=$stdin)
    @data = stdin.read
    @lines = @data.split(/\n/)

    extract_tags
    extract_metadata
    extract_name
  end

  def extract_tags
    @tags ||= data.scan(/(?<![\w\\])(?<=#)(\w+)/)
  end

  def extract_metadata
    @metadata ||= lines.take_while do |line|
      line[/^[\w\s]+:\s*\w|^\s*$/]
    end.inject({}) do |h,line|
      md = line.match(/^([\w\s]+)\s*:\s*(\w.*)$/)
      md &&= Hash[md[1], md[2]]
      h.merge md || {}
    end
  end

  def extract_name
    @name ||= extract_body.first[/^\s*(.{0,79}(?!\S))/]
  end

  def extract_body
    @body ||= lines.drop_while do |line|
      line[/^[\w\s]+:\s*\w|^\s*$/]
    end
  end
end

p = HeroParser.new
ap [:@name, :@metadata, :@tags, :@body].map{|x| p.instance_variable_get(x) }, raw: true, index: false

__END__
[
