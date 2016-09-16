require 'git'
require 'sinatra'

if ARGV.size == 0
  puts "Please specify a repo root as argument" 
  exit 1
end

repos_root = ARGV[0]

get '/:repo/:commit/*.*' do
  begin
    content_type params['splat'][1]
  rescue
    content_type 'application/octet-stream'
  end
  repo = Git.open("#{repos_root}/#{params[:repo]}")
  repo.show(params[:commit], params[:splat].join("."))
end
