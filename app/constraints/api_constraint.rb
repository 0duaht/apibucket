class ApiConstraint
  attr_reader :version, :default

  def initialize(version, default = false)
    @version = version
    @default = default
  end

  def matches?(request)
    default || request.headers.fetch(:accept).
      include?("vnd.apibucket.v#{version}+json")
  end
end
