module Spree
  module Seo
    class ApplicationJob
      include Sidekiq::Job
    end
  end
end
