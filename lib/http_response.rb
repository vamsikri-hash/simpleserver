require "./lib/file_search.rb"

class HttpResponse
  attr_accessor :status_code, :status, :headers, :body, :response

  def initialize(request)
    filedata = search_file(request)
    if filedata
      @status_code = 200
      @status = "OK"
      @body = filedata
    else
      @status_code = 400
      @status = "File Not Found"
      @body = ""
    end
  end

  def getdata
    @response = "HTTP/1.1 #{@status_code}  #{@status}\r\n" +
                "Content-Length: #{@body.size}\r\n" +
                "\r\n" +
                "#{@body}\r\n"
  end
end
