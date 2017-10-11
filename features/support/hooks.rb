Before do
  visit nitro_page("nitrolinks")
  jscript('nitroTesting.clearDomLoads()')
  @initial_page_loads = jscript('nitroTesting.domLoadCount()').to_i
end

Around('@allow-rescue') do |scenario, block|
  Dummy::Application.config.consider_all_requests_local = false
  block.call
  Dummy::Application.config.consider_all_requests_local = true
end

