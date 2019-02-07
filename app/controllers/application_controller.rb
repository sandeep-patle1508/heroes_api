class ApplicationController < ActionController::API

	def render_response(result)
		if result 
      render_success_response(result)
    else
      render_not_found_response('Not able to find record for this request')
    end
	end

	def render_success_response(response)
		render json: response
	end

	def render_not_found_response(exception)
    render json: { error: exception }, status: :not_found
  end
end
