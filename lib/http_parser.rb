class HttpParser
  attr_accessor :method, :path, :headers, :version, :all

  def initialize(request)
    @all = parser(request)
  end

  private

  def parser(request)
    @method, @path, @version = request.lines[0].split
    {
      method: method,
      path: path,
      headers: parse_headers(request),
    }
  end

  def parse_headers(request)
    headers = {}
    request.lines[1..-1].each do |line|
      header, value = line.split
      headers[header] = value
    end
  end
end
