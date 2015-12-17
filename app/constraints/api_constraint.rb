class ApiConstraint
  attr_reader :version

  def initialize(version)
    @version = version
  end

  def matches?(request)
    request.headers.fetch(:accept).
      include?("vnd.apibucket.#{version}+json")
  end
end
