# frozen_string_literal: true

class InsectTool < ApplicationRecord
  belongs_to :insect
  belongs_to :tool
end
