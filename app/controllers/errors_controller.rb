class ErrorsController < ApplicationController
  
  def not_found
    render :status => :not_found
  end

  def internal_server_error
    render :staus => :internal_server_error
  end

  def unauthorized
    render :staus => :unauthorized
  end
end