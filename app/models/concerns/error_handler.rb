module ErrorHandler
  extend ActiveSupport::Concern

  included do
    validates :name, length: { minimum: 2, maximum: 60 }
  end

  def get_error
    all_errors = errors.full_messages
    all_errors ? all_errors[0] : "Invalid Entry. Please try again."
  end
end
