class BaseModel
	def self.is_success_response?(response)
  	response.success?
  end
end