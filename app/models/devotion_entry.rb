class DevotionEntry < ActiveRecord::Base

    belongs_to :user

    def formatted_created_at
        self.created_at.strftime("%A, %d %b %Y %l:%M.%S %p")
        end


end
