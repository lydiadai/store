# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  quantity    :integer
#  price       :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#

class Product < ApplicationRecord
    mount_uploader :image, ImageUploader
    def hide!
        self.is_hidden = true
        save
    end

    def publish!
        self.is_hidden = false
        save
    end
end
