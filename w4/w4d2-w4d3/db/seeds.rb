# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  age         :integer          not null
#  birth_date  :date             not null
#  color       :string(255)      not null
#  name        :string(255)      not null
#  sex         :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

User.create(user_name: "goku", password: "123123")
User.create(user_name: "vegeta", password: "ughugh")
User.create(user_name: "nappa", password: "whatislove")

Cat.create(age: 3, birth_date: Date.today, color: "black", 
           name: "breakfast", sex: "F", user_id: 1)
Cat.create(age: 4, birth_date: Date.today, color: "rainbow", 
           name: "funkycat", sex: "F", user_id: 2)
Cat.create(age: 5, birth_date: Date.today, color: "tiger stripes", 
           name: "garfield", sex: "M", user_id: 3)
           
CatRentalRequest.create(cat_id: 3, start_date: "2014-08-24", end_date: "2014-08-27", user_id: 1)
CatRentalRequest.create(cat_id: 3, start_date: "2014-08-20", end_date: "2014-08-22", user_id: 1)
CatRentalRequest.create(cat_id: 3, start_date: "2014-08-22", end_date: "2014-08-25", user_id: 1)
CatRentalRequest.create(cat_id: 3, start_date: "2014-08-26", end_date: "2014-09-22", user_id: 1)