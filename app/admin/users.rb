ActiveAdmin.register User do
  index do
    column :id
    column :name
    column :nickname
    column :created_at
    column :updated_at
  end
  
end
