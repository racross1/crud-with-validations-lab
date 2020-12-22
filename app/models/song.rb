require 'pry'

class Song < ApplicationRecord
    validates_presence_of :title, :artist_name
    validates_uniqueness_of :title, scope: :release_year
    validates :released, inclusion: [true, false]
    validates_numericality_of :release_year, if: :was_released 
    validates_numericality_of :release_year, allow_nil: true, if: :not_released? 
    validate :current_year

    def was_released
        self.released == true 
    end 

    def not_released?
        self.released == false
    end 

    def current_year
        #binding.pry
        unless self.release_year.to_i <= Time.now.year 
            errors.add(:release_year, "Not a valid release year")  
        end 
    end 

    # validates :age, numericality: {greater_than: 0}

end
