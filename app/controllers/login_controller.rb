class LoginController < ApplicationController

  def index

    render({:template => "login/index", layout: false})
  end


end
