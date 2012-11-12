#!/usr/bin/env ruby
# encoding: utf-8

module Main
  class Hoge
    def foo str
      puts str+'foo!'
    end # def foo

    def self.bar(tsura, poyo)
      tsura.each do |i|
        if poyo
          puts i if true
        end # if poyo
      end # tsura.each do |i|
    end # def self.bar
  end
end # module main

unless ARGV.empty?

  case ARGV.size
  when 1
    if ARGV[0] == "help"
      puts <<-EOS
Hey! this is textobj for ruby.
You can test many features in this file
if you are interested in this plugin.
Let's load this plugin on runtimepath!
      EOS
    else
      begin
        raise
      rescue RuntimeError
        puts "you mean 'help' ?"
      end # begin
    end # if ARGV[0] == "help"
  when 2
    Main::Hoge.new.foo ARGV[0]+ARGV[1]
  when 3
    Main.Hoge.bar *ARGV.shift
  else
    puts "nothing to say."
  end # case ARGV.size
end
