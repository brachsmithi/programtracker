require 'will_paginate/array' 

class ApplicationController < ActionController::Base

  before_action :set_page

  private

  def set_page
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
  end

end
