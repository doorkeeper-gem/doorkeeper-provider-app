# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user

  validates :user, :name, :url, presence: true
end
