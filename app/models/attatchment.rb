class Attatchment < ApplicationRecord
  belongs_to :message
  mount_uploader :attatchment, AttatchmentUploader
end
