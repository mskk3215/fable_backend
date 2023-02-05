class InsectPost < ApplicationRecord
  blongs_to :post
  blongs_to :insect
end
