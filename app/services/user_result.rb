class UserResult

  ERROR_TYPES = {
    :duplicate => 'This email is already taken'
  }.freeze

  attr_reader :success, :error_reader

  def initialize(success:, error_type: nil)
    @success = success
    @error_type = error_type
  end

  def success?
    return @success
  end

  def duplicate?
    return true if @error_type == :duplicate
  end

  def error_message
    ERROR_TYPES[@error_type]
  end

  def self.duplicate_result
    UserResult.new(success: false, error_type: :duplicate)
  end

  def self.successful_result
    UserResult.new(success: true)
  end
end
