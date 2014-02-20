guard :cucumber,
  cli: "--profile guard",
  all_on_start: true do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})  { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end

guard :rspec,
  cmd:          "bundle exec rspec",
  all_on_start: true do

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})       { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')    { "spec" }
  watch(%r{spec/support/.+\.rb})  { "spec" }
end

