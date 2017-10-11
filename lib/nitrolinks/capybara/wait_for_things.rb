module Nitrolinks
  module Capybara
    module WaitForThings
      def wait_for_page_load
        Timeout.timeout(::Capybara.default_max_wait_time) do
          loop until finished_loading?
        end
      end

      def finished_loading?
        jscript('document.getElementsByClassName("testing-visiting").length').zero?
      end

      def pause_pls
        $stderr.write 'Press enter to continue'
        $stdin.gets
      end
    end
  end
end


