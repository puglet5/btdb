# frozen_string_literal: true

# rubocop:disable Lint/ConstantDefinitionInBlock
ActiveSupport.on_load(:action_text_rich_text) do
  module ActionText
    class RichText < ActionText::Record
      def self.ransackable_attributes(_auth_object = nil)
        %w[body created_at id id_value name record_id record_type updated_at]
      end
    end
  end
end
# rubocop:enable Lint/ConstantDefinitionInBlock
