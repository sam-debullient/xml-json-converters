class HomeController < ApplicationController

  def index
    self.content_type = "application/json"
    begin 
      if request.content_type =~ /json/
        self.content_type = "application/xml"
        render xml: welcome and return
      else
        render json: welcome and return
      end
    rescue Exception
      render json: welcome and return
    end
  end

  private
    def welcome
      {
        message: "Please go to #{request.protocol + request.host_with_port}/api/convert",
        status: 200
      } 
    end

end