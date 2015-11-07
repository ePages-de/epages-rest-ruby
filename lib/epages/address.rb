require 'epages/utils'

module Epages
  class Address
    include Epages::Utils

    KEYS = %w(company salutation title first_name last_name street street_details zip_code
              city state country vat_id birthday email_address).collect(&:to_sym).freeze

    attr_accessor *KEYS

    def initialize(data)
      parse_attributes(data)
    end

    def to_json
      {
        firstName: first_name,
        lastName: last_name,
        street: street,
        zipCode: zip_code,
        city: city,
        country: country,
        birthday: birthday,
        emailAddress: email_address,
      }
    end
  end
end
