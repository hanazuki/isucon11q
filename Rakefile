require 'bundler/setup'

task :default => :deploy

task :deploy do
  sh 'scripts/deploy'

  sh 'newrelic', 'deployment', '-edeployment'
end
