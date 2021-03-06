module Nitrolinks
  module Rails

    module Controller
      extend ActiveSupport::Concern

      included do
        before_action :set_nitrolinks_location_header_from_session if respond_to?(:before_action)
      end

      def nitrolinks_request?
        request.headers.key? "nitrolinks-referrer"
      end

      def redirect_to(url = {}, options = {})
        super.tap do
          if nitrolinks_request?
            store_nitrolinks_location_in_session(location)
          end
        end
      end

      protected

      def nitrolinks_location(location)
        response.headers["Nitrolinks-Location"] = location
      end

      private

      def store_nitrolinks_location_in_session(location)
        session[:nitrolinks_location] = location if session
      end

      def set_nitrolinks_location_header_from_session
        if session && session[:nitrolinks_location]
          nitrolinks_location(session.delete(:nitrolinks_location))
        end
      end
    end

  end
end

