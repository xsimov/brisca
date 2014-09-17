guard :bundler do
  watch('Gemfile')
end

guard :rspec, run_all: true do
  watch(%r{^lib/(.+)\.rb$})     { "spec" }
  watch(%r{^spec/(.+)\.rb$})     { "spec" }
end
