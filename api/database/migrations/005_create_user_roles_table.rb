# frozen_string_literal: true

Sequel.migration do
  transaction

  up do
    extension :pg_triggers
    # user table
    create_table(:users) do
      Serial   :id, primary_key: true
      String   :name, size: 100, null: false
      String   :username, size: 150, null: false
      String   :password, size: 150, null: false

      DateTime :created_at, default: Sequel.function(:NOW)
      DateTime :updated_at, default: Sequel.function(:NOW)
    end

    # role table
    create_table(:roles) do
      Serial   :id, primary_key: true
      String   :name, size: 100, null: false

      DateTime :created_at, default: Sequel.function(:NOW)
      DateTime :updated_at, default: Sequel.function(:NOW)
    end

    # many to many users roles
    create_table(:users_roles) do
      Serial   :id, primary_key: true
      foreign_key :user_id, :users
      foreign_key :role_id, :roles

      DateTime :created_at, default: Sequel.function(:NOW)
      DateTime :updated_at, default: Sequel.function(:NOW)
    end

    pgt_updated_at(:users,
                   :updated_at,
                   function_name: 'update_updated_at_column_at_users_table',
                   trigger_name: :set_updated_at)

    pgt_updated_at(:roles,
                   :updated_at,
                   function_name: 'update_updated_at_column_at_roles_table',
                   trigger_name: :set_updated_at)

    pgt_updated_at(:users_roles,
                   :updated_at,
                   function_name: 'update_updated_at_column_at_users_roles_table',
                   trigger_name: :set_updated_at)
  end

  down do
    drop_trigger(:users, :set_updated_at)
    drop_function(:update_updated_at_column_at_users_table)
    drop_table(:users)

    drop_trigger(:roles, :set_updated_at)
    drop_function(:update_updated_at_column_at_roles_table)
    drop_table(:roles)

    drop_trigger(:users_roles, :set_updated_at)
    drop_function(:update_updated_at_column_at_users_roles_table)
    drop_table(:users_roles)
  end
end
