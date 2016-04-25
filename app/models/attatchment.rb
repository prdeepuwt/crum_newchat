class Attatchment < ApplicationRecord
  belongs_to :message
  mount_uploader :file, AttatchmentUploader
end
