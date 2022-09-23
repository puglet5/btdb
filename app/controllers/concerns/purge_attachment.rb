module PurgeAttachment
  extend ActiveSupport::Concern

  included do
    def purge_attachment
      @blob = ActiveStorage::Blob.find_signed(params[:id])
      @blob.attachments.first.purge_later
    end
  end
end
