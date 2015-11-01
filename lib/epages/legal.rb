require 'epages/utils'

module Epages
  class Legal
    include Epages::Utils

    attr_accessor :name, :title, :navigation_caption, :short_description, :description, :company,
                  :contact_person, :contact_person_job_title, :address, :phone, :email

    def initialize(data)
      parse_attributes(data)
    end
  end
end
