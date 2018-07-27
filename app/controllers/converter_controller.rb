class ConverterController < ApplicationController

  def convert
    self.content_type = "application/json"
    begin 
      if request.content_type =~ /json/
        h = JSON.parse(request.body.read)
        self.content_type = "application/xml"
        render xml: h  and return
      elsif
        h = Hash.from_xml(request.body.read)
        if h.key? "hash"
          if h["hash"].blank?
            h = Hash.new
          else
            h = h["hash"]
          end
        end
        render json: h and return
      else
        render json: bad_request, status: 400 and return
      end
    rescue Exception
      render json: bad_request, status: 400 and return
    end
  end

  private
  def bad_request
    {
      error: {
        message: "Bad Request" 
      },
      status: 400
    }
  end

end