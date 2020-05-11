SERVER_ROOT = Dir.pwd + "/public/"

def file_path(request)
  if request[:path] == "/"
    SERVER_ROOT + "index.html"
  else
    SERVER_ROOT + request[:path]
  end
end

def search_file(request)
  path = file_path(request)
  if File.exists?(path)
    File.binread(path)
  else
    File.binread(SERVER_ROOT + "404.html")
  end
end
