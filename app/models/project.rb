class Project < ApplicationRecord
	  # a project will always belong to a team.
  belongs_to :team
  # A project belongs to a user when created.
  belongs_to :owner, class_name: "User"

    # To associated all projects to a team requires us to add a nested form for the team in mention.
  accepts_nested_attributes_for :team

end
