Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
>> Model Relationships
Plants
validates :name, presence: true
validates_length_of :name, minimum: 3, maximum: 15, allow_blank: false
# validates :name, presence: true, length: {minimum: 3, maximum: 15 }, allow_blank: false
belongs_to:
Users

Users
has_many :plants
validates :name, presence: true
validates_length_of :name, minimum: 3, maximum: 15, allow_blank: false
# validates :name, presence: true, length: { minimum: 3, maximum: 15, message:"MyerrorMessage" }, allow_blank: false

Booking
belongs_to:
plants, users
reference :plants, foreign_key
reference :users, foreign_key

git checkout -b "nameofthebranch"
rails g model Booking plants:references
