# frozen_string_literal: true
# rubocop:todo all

class Purchase
  include Mongoid::Document
  embeds_many :line_items
end
