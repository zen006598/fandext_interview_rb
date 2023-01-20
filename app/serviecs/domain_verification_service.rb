require 'resolv'

class DomainVerificationService
  attr_reader :error, :domain
  BLOCKED_DOMAINS_LIST = %w(qq.com maileven.com iffygame.com companycontacts.net)

  def self.call(email)
    service = new(email)
    service
  end

  def initialize(email)
    @domain = email.split("@").last
    verify_domain!
  rescue => e
    # To prevent misjudgement, pass examination if other error raised
  end

  def succeeded?
    error.blank?
  end

  private

  def verify_domain!
    if blocked_domain?
      return @error = "メールアドレスのドメイン【#{domain}】が無効か、メールを受信できる状態ではありません。"
    end

    if invalid_mx_record? && invalid_a_record?
      @error = "メールアドレスのドメイン【#{domain}】が存在しないか、メールを受信できる状態ではありません。"
    end
  end

  def blocked_domain?
    BLOCKED_DOMAINS_LIST.include?(domain)
  end

  def invalid_mx_record?
    Resolv::DNS.new.getresources(domain, Resolv::DNS::Resource::IN::MX).empty?
  end

  def invalid_a_record?
    Resolv::DNS.new.getresources(domain, Resolv::DNS::Resource::IN::A).empty?
  end
end
