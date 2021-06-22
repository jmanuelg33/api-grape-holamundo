# frozen_string_literal: true

Sequel.migration do
  transaction

  up do
    alter_table(:personas) do
      set_column_type :description, String, size: 255
    end
  end
  
end