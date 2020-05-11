require "socket"
require "./lib/http_parser.rb"
require "./lib/http_response.rb"

#SERVER STUFF
server = TCPServer.new("localhost", 8080)
while client = server.accept
  begin
    request = client.readpartial(1024 * 16)
    puts request
    request = HttpParser.new(request)
    response = HttpResponse.new(request.total)
    client.write(response.getdata)
    client.close
  rescue EOFError
  end
end
