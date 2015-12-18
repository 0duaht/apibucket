module Api
  class TokenProvider
    def self.encode(payload, exp = 2.days.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
  end
end
