module ErrorHandler
  extend ActiveSupport::Concern

  def is_success_response?(response)
  	puts response.inspect
  	true
  end
end