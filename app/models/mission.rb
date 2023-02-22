class Mission < ApplicationRecord
    belongs_to :scientist
    belongs_to :planet

    validates :name, :scientist_id, :planet_id, presence: true
    validates :scientist_id, uniqueness: { scope: :name,
        message: "cannot join the same mission twice" }
end
