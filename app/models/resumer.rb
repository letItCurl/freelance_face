class Resumer < ApplicationRecord
end

# == Schema Information
#
# Table name: resumers
#
#  id              :bigint           not null, primary key
#  about           :text
#  calendy_code    :text
#  experiences     :jsonb
#  loom_video_code :text
#  skills          :jsonb
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
