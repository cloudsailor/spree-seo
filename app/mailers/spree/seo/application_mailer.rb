# frozen_string_literal: true

module Spree
  module Seo
    # Base application mailer
    class ApplicationMailer < ActionMailer::Base
      default from: 'from@example.com'
      layout 'mailer'
    end
  end
end
