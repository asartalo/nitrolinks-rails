module Nitrolinks
  module Rails

    class Engine < ::Rails::Engine
      isolate_namespace Nitrolinks

      config.nitrolinks = ActiveSupport::OrderedOptions.new
      config.nitrolinks.auto_include = true

      initializer :turbolinks do |app|
        ActiveSupport.on_load(:action_controller) do
          if app.config.nitrolinks.auto_include
            include Controller
          end
        end
      end
    end

  end
end

