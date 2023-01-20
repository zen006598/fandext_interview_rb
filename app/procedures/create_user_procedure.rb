class CreateUserProcedure < ApplicationProcedure
  class InvalidUserAttributes < StandardError; end

  attr_reader :user

  def self.call(context, user:)
    procedure = new(context, user)
    procedure.run
    procedure
  end

  def initialize(context, user)
    @context = context
    @user = user
  end

  def run
    verify_email_domain
    save_user_with_email
    send_welcome_mail
    login_user
  rescue InvalidUserAttributes
    self
  end

  private

  def verify_email_domain
    @error = DomainVerificationService.call(user.email).error
    if @error
      @error = "Domain invalid"
      raise InvalidUserAttributes
    end
  end

  def save_user_with_email
    if user.save_with_email
      @succeeded_message = "Welcome to fandnext"
    else
      @error = "User create failed"
      raise InvalidUserAttributes
    end
  end

  def send_welcome_mail
    # mail to user
  end

  def login_user
    context.login(user)
  end
end
