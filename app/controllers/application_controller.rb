class ApplicationController < ActionController::API

  rescue_from ActionController::RoutingError,
    with: :page_not_found
  rescue_from ActionController::ParameterMissing,
    with: :parameter_missing
  rescue_from ArgumentError,
    with: :invalid_argument
  rescue_from TypeError,
    with: :invalid_type
  rescue_from ActionController::UnpermittedParameters,
    with: :parameter_missing

  def page_not_found
    render json: {
      error: {
        message: 'Not Found'
      }
    }, status: 404
  end 

  def parameter_missing(error)
    render json: {
      error: {
        message: error.message
      }
    }, status: 400
  end 

  def invalid_argument(error)
    render json: {
      error: {
        message: error.message
      }
    }, status: 400
  end 

  def invalid_type(error)
    render json: {
      error: {
        message: error.message
      }
    }, status: 400
  end 
end
