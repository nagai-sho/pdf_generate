class Sheet < ApplicationRecord
  validates :content, format: { without: /\d/, message: '数字だめよ'}
end
