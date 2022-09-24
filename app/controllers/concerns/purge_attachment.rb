# frozen_string_literal: true

module PurgeAttachment
  extend ActiveSupport::Concern

  included do
    def purge_attachment(id)
      @blob = ActiveStorage::Blob.find_signed(id)
      @blob.attachments.first.purge_later
    end
  end
end
