require "socket"
require "./lib/http_parser.rb"
require "./lib/http_response.rb"

#SERVER STUFF

server = TCPServer.new("localhost", 8080)
puts "Server Started and Listening at port 8080....:)"

while client = server.accept
  begin
    trap("SIGINT") do
      client.close
      puts "Server closed"
      exit!
    end
    request = client.readpartial(1024 * 16)
    puts "Request - #{request.lines[0]} "
    request = HttpParser.new(request)
    response = HttpResponse.new(request.all)
    puts "Response - #{response.status_code} - #{response.status}"
    client.write(response.getdata)
    client.close
  rescue EOFError
  end
end
