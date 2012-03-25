ActiveAdmin.register User do
  index do
    column :id do |user|
      link_to user.id, [:admin, user]
    end
    column :name
    column :nickname
    column :created_at
    column :updated_at
  end
  
end
