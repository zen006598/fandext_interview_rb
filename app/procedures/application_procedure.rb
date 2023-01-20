class ApplicationProcedure
  attr_reader :error, :succeeded_message

  def succeeded?
    error.blank?
  end

  def failed?
    error.present?
  end

  private

  attr_reader :context, :user
  delegate :logger, :controller_name, :action_name, to: :context
end
