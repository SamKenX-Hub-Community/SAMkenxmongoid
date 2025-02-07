# frozen_string_literal: true
# rubocop:todo all

module Mongoid

  # Encapsulates behavior around logging and caching warnings so they are only
  # logged once.
  #
  # @api private
  module Warnings

    class << self
      def warning(id, message)
        singleton_class.class_eval do
          define_method("warn_#{id}") do
            unless instance_variable_get("@#{id}")
              Mongoid.logger.warn(message)
              instance_variable_set("@#{id}", true)
            end
          end
        end
      end
    end

    warning :geo_haystack_deprecated, 'The geoHaystack type is deprecated.'
    warning :as_json_compact_deprecated, '#as_json :compact option is deprecated. Please call #compact on the returned Hash object instead.'
    warning :symbol_type_deprecated, 'The BSON Symbol type is deprecated by MongoDB. Please use String or StringifiedSymbol field types instead of the Symbol field type.'
    warning :legacy_readonly, 'The readonly! method will only mark the document readonly when the legacy_readonly feature flag is switched off.'
    warning :mutable_ids, 'Ignoring updates to immutable attribute `_id`. Please set Mongoid::Config.immutable_ids to true and update your code so that `_id` is never updated.'
  end
end
