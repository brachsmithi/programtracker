require './app/services/application_service.rb'
require 'json'

class JsonWriter < ApplicationService
  attr_reader :content, :file_name

  def initialize(input)
    @content = input[:content]
    @file_name = input[:file_name]
  end

  def call()
    dir = "#{Rails.root}/export"
    FileUtils.mkdir(dir) unless Dir.exists?(dir)
    file = File.new("#{dir}/#{@file_name}", 'w');
    file.syswrite(JSON.generate(@content));
    file.close();
  end

end